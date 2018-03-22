import os
from flask import Flask, g
from flask_cors import CORS
from flask_migrate import Migrate
from .models import db
from flask_sqlalchemy import SQLAlchemy
migrate = Migrate()


def create_app(config=None):
    app = Flask('cpro-common', template_folder='cpro_common/templates', static_folder='cpro_common/static')

    app.config.update(dict(
        Debug=True,
        SQLALCHEMY_DATABASE_URI = 'mysql+pymysql://cpro:cpro@cpro-common-db:3306/cpro_common',
        SQLALCHEMY_TRACK_MODIFICATIONS = False,
        SQLALCHEMY_POOL_RECYCLE = 60,
        SQLALCHEMY_BINDS = {
            'cpro':        'mysql+pymysql://dhair:dhair@dhair2-db:3306/dhair2_demo',
        }
    ))

    CORS(app)

    app.config.from_envvar('CPRO_COMMON_SETTINGS', silent=True)
    app.secret_key = '12345678'

    ## App Creation
    db.init_app(app)

    # Reflect only the structure of the cPRO db.
    with app.app_context():
        db.reflect(bind='cpro')

    from .models import OAuth2Client, OAuth2AuthorizationCode, OAuth2Token        
    from .services import oauth2
    from . import auth, blueprints

    migrate.init_app(app, db)

    auth.init_app(app)
    oauth2.init_app(app)
    blueprints.init_app(app)

    return app
