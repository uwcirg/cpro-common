from wtforms.fields import StringField, PasswordField
from wtforms.fields.html5 import EmailField
from wtforms.validators import DataRequired
from wtforms.validators import StopValidation
from .base import BaseForm
from ..models import db
from ..models.user import User
from ..auth import login


class AuthenticateForm(BaseForm):
    email = EmailField(description='Email', validators=[DataRequired()])
    password = PasswordField(description='Password', validators=[DataRequired()])
 
    def __init__(self, *args, **kwargs):
        super(AuthenticateForm, self).__init__(*args, **kwargs)
        self._user = None

    def validate_password(self, field):
        email = self.email.data.lower()
        user = User.query.filter_by(email=email).first()
        if not user or not user.check_password(field.data):
            raise StopValidation('This email cannot be found.')
        self._user = user

    def login(self):
        if self._user:
            login(self._user, True)


class UserCreationForm(BaseForm):
    email = EmailField(description='Email', validators=[DataRequired()])
    password = PasswordField(description='Password', validators=[DataRequired()])

    def validate_email(self, field):
        email = field.data.lower()
        user = User.query.filter_by(email=email).first()
        if user:
            raise StopValidation('An account for this email already exists')

    def signup(self):
        email = self.email.data.lower()
        user = User(email=email)
        user.password = self.password.data

        try:
            db.session.add(user)
            db.session.commit()
        except:
            db.session.rollback()
            raise
       
        login(user, True)
        return user
