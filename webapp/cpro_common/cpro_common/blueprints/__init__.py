from . import account
from . import client
from . import oauth2
from . import api
from . import static
from . import connect

def init_app(app):
    app.register_blueprint(account.bp, url_prefix='/account')
    app.register_blueprint(connect.bp, url_prefix='')
    app.register_blueprint(client.bp, url_prefix='/client')
    app.register_blueprint(oauth2.bp, url_prefix='/oauth2')
    app.register_blueprint(api.bp, url_prefix='/api/v1.0')
    app.register_blueprint(static.bp, url_prefix='')
