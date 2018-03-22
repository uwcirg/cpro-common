from flask import Blueprint, url_for
from flask import render_template, abort, redirect, request
from authlib.client.apps import get_app
from ..auth import oauth, require_login, current_user
from ..models.user import Connect
import requests
import xml.etree.ElementTree as ET


bp = Blueprint('connect', __name__)

@bp.route('/launch/epic')
def launch():
    # Handle iss, launch token
    conformance_uri = request.args.get("iss") + '/metadata'
    metadata_request = requests.get(conformance_uri)
    parsed_body = ET.fromstring(metadata_request.text)
    
    oauth.epic.api_base_url = request.args.get("iss")
    oauth.epic.authorize_url = parsed_body.findall('.//*[@url="authorize"]*')[0].attrib['value']
    oauth.epic.access_token_url = parsed_body.findall('.//*[@url="token"]*')[0].attrib['value']
    oauth.epic.launch = request.args.get('launch')
    oauth.epic.state = '1342' # TODO: change!

    redirect_uri = url_for('connect.callback', _external=True)

    return oauth.epic.authorize_redirect(redirect_uri)

@bp.route('/callback/epic')
def callback():
    state = request.args.get("state")
    code = request.args.get("code")


    client = oauth.epic
    token = client.authorize_access_token()
    
    ## Get patient id and other params here too! and save them

    # jj
    # # Get the relevant user info
    # # user_info = service.profile()

    # # token['sub'] = user_info.sub
    
    Connect.create_token(name, token, current_user)
    

    # # Redirect to correct cPRO App
    # return redirect(url_for('.list_connects'))

# @bp.route('')
# @require_login
# def list_connects():
#     services = oauth._registry.keys()
#     q = Connect.query.filter_by(user_id=current_user.id)
#     connects = {item.name: item for item in q}
#     return render_template(
#         'connects.html',
#         connects=connects,
#         services=services,
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
#     return client.authorize_redirect(redirect_uri)



def _get_service_or_404(name):
    service = get_app(name)
    if not service:
        abort(404)
    return service