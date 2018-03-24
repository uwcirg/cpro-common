from flask import Blueprint, url_for
from flask import render_template, abort, redirect, request, session, Response, current_app
from authlib.client.apps import get_app
from ..auth import oauth, require_login, current_user
from ..models import db, OAuth2Client
from ..auth import login
from ..models.user import Connect, User
import requests
import xml.etree.ElementTree as ET
import uuid


bp = Blueprint('connect', __name__)

@bp.route('/launch/epic')
def launch():
    # Handle iss, launch token
    conformance_uri = request.args.get("iss") + '/metadata'
    metadata_request = requests.get(conformance_uri)
    parsed_body = ET.fromstring(metadata_request.text)
    
    client = oauth.epic 
    client.api_base_url = request.args.get("iss")
    client.authorize_url = parsed_body.findall('.//*[@url="authorize"]*')[0].attrib['value']
    client.access_token_url = parsed_body.findall('.//*[@url="token"]*')[0].attrib['value']
    client.client_kwargs['launch'] = request.args.get('launch')

    redirect_uri = url_for('connect.callback', _external=True, _scheme='https')
    return client.authorize_redirect(redirect_uri, launch = client.client_kwargs['launch'])

@bp.route('/launch/mychart')
def launch_mychart():
    # Handle iss, launch token
    conformance_uri = request.args.get("iss") + '/metadata'
    metadata_request = requests.get(conformance_uri)
    parsed_body = ET.fromstring(metadata_request.text)
    
    client = oauth.mychart 
    client.api_base_url = request.args.get("iss")
    client.authorize_url = parsed_body.findall('.//*[@url="authorize"]*')[0].attrib['value']
    client.access_token_url = parsed_body.findall('.//*[@url="token"]*')[0].attrib['value']
    client.client_kwargs['launch'] = request.args.get('launch')

    redirect_uri = url_for('connect.callback_mychart', _external=True, _scheme='https')
    
    return client.authorize_redirect(redirect_uri, launch = client.client_kwargs['launch'])

@bp.route('/callback/epic')
def callback():
    state = request.args.get("state")
    code = request.args.get("code")

    client = oauth.epic
    token = client.authorize_access_token(scope='patient/* launch')

    url = "DSTU2/Patient/"+token['patient']
    patient_data = client.get(url).text # TODO: , headers={'Content-type': 'application/json'})
     
    ## Get patient id and other params here too! and save them    

    user = User.query.filter_by(name=token['EPICUSERID']).first()
    
    if not user:
        user = User(name=token['EPICUSERID'], email=token['EPICUSERID']+"@"+str(uuid.uuid1()))
        try:
            db.session.add(user)
            db.session.commit()
        except:
            db.session.rollback()
            raise

    login(user, True)
    
    session['launch'] = str(uuid.uuid1())
    session['EPICUSERID'] = token['EPICUSERID']
    session['PATID'] = token['PATID']
    session['patient'] = token['patient']
    session['patient_data'] = patient_data
    
    current_app.logger.info(session)
    Connect.create_token('epic', token, current_user)

    create_client_for_user(user, '381979a0-8989-455e-87b4-399513d51e5a', session['EPICUSERID'], 'https://mpower.cpro.cirg.washington.edu/auth/sof/oauth2callback https://p3p.cpro.cirg.washington.edu/auth/sof/oauth2callback https://paintracker.cpro.cirg.washington.edu/auth/sof/oauth2callback')

    return render_template(
        'menu.html',
        launch = session['launch']
    )

@bp.route('/callback/mychart')
def callback_mychart():
    state = request.args.get("state")
    code = request.args.get("code")

    client = oauth.mychart
    token = client.authorize_access_token(scope='patient/* launch')

    url = "DSTU2/Patient/"+token['patient']
    patient_data = client.get(url).text # TODO: , headers={'Content-type': 'application/json'})
     
    ## Get patient id and other params here too! and save them    

    user = User.query.filter_by(name=token['PATID']).first()
    if not user:
        user = User(name=token['PATID'], email=token['PATID']+"@"+str(uuid.uuid1()))
        try:
            db.session.add(user)
            db.session.commit()
        except:
            db.session.rollback()
            raise

    login(user, True)
    
    session['launch'] = str(uuid.uuid1())
    session['PATID'] = token['PATID']
    session['patient'] = token['patient']
    session['patient_data'] = patient_data
    
    Connect.create_token('mychart', token, current_user)

    create_client_for_user(user, '381979a0-8989-455e-87b4-399513d51e5a', session['PATID'], 'https://mpower.cpro.cirg.washington.edu/auth/sof/oauth2callback https://p3p.cpro.cirg.washington.edu/auth/sof/oauth2callback https://paintracker.cpro.cirg.washington.edu/auth/sof/oauth2callback')

    return render_template(
        'menu.html',
        launch = session['launch']
    )


@bp.route('/connects')
@require_login
def list_connects():
    services = oauth._registry.keys()
    q = Connect.query.filter_by(user_id=current_user.id)
    connects = {item.name: item for item in q}
    return render_template(
        'connects.html',
        connects=connects,
        services=services,
    )

def _get_service_or_404(name):
    service = get_app(name)
    if not service:
        abort(404)
    return service

def create_client_for_user(user, client_id, name, redirect_uri):
    client = OAuth2Client.query.filter_by(user_id=user.id, client_id=client_id).first()
    
    if client:
        return client
    
    client = OAuth2Client(
        user_id=user.id,
        client_id=client_id,
        client_secret='',
        name=name,
        is_confidential=False,
        redirect_uris=redirect_uri,
        default_redirect_uri=redirect_uri.split()[1],
        website='http://cirg.washington.edu',
        allowed_scopes='launch openid profile user/*.* patient/*.*',
        allowed_grants='authorization_code'
    )
        
    try:
        db.session.add(client)
        db.session.commit()
    except:
        db.session.rollback()
        raise

    return client


# @bp.route('/menu')
# @require_login
# def menu():
#     return render_template(
#         'menu.html'
#     )

# @bp.route('/bind/<name>')
# @require_login
# def bind(name):
#     callback_uri = url_for('.authorize', name=name, _external=True)
#     return service.authorize_redirect(callback_uri)

# @app.route('/login/<name>')
# def login(name):
#     client = oauth.create_client(name)
#     redirect_uri = url_for('authorize', name=name, _external=True)
#     return cli ent.authorize_redirect(redirect_uri)
