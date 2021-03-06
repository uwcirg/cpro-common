from flask import Blueprint, request
from flask import jsonify, render_template, current_app, session
from authlib.specs.rfc6749 import OAuth2Error
from ..models import OAuth2Client
from ..models.user import User
from ..auth import current_user
from ..forms.auth import ConfirmForm, LoginConfirmForm
from ..services.oauth2 import authorization, scopes

from ..auth import login

bp = Blueprint('oauth2', __name__)


@bp.route('/authorize', methods=['GET', 'POST'])
def authorize():
    current_app.logger.info(current_user)
    current_app.logger.info(session)
    
    if current_user:
        form = None
    else: 
        form = LoginConfirmForm()

    if (form and form.validate_on_submit()) or current_user:
        grant_user = current_user
        return authorization.create_authorization_response(grant_user)
    
    try:
        grant = authorization.validate_authorization_request()
    except OAuth2Error as error:
        # TODO: add an error page
        payload = dict(error.get_body())
        return jsonify(payload), error.status_code

    client = OAuth2Client.get_by_client_id(request.args['client_id'])

    return render_template(
        'account/authorize.html',
        grant=grant,
        scopes=scopes,
        client=client,
        form=form,
    )


@bp.route('/token', methods=['POST', 'GET'])
def issue_token(): 
    user = User.query.filter_by(name='UWASH03').first()
    login(user, True)

    session['EPICUSERID'] = 'UWASH03'
    session['PATID'] = '202500'
    session['patient'] = 'T81lum-5p6QvDR7l6hv7lfE52bAbA2ylWBnv9CZEzNb0B'

    current_app.logger.info(request)
    current_app.logger.info(session)
    current_app.logger.info(current_user)
    return authorization.create_token_response(session, current_app)

 
@bp.route('/revoke', methods=['POST', 'GET'])
def revoke_token():
    return authorization.create_revocation_response()
