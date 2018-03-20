from wtforms.fields import (
    PasswordField,
    BooleanField,
)
from wtforms.fields.html5 import EmailField
from wtforms.validators import DataRequired
from wtforms.validators import StopValidation
from .base import BaseForm
from ..models.user import User
from ..auth import login


class ConfirmForm(BaseForm):
    confirm = BooleanField()


class LoginConfirmForm(BaseForm):
    email = EmailField(description='Email', validators=[DataRequired()])
    password = PasswordField(description='Password', validators=[DataRequired()])

    def validate_password(self, field):
        email = self.email.data.lower()
        user = User.query.filter_by(email=email).first()
        if not user or not user.check_password(field.data):
            raise StopValidation('Cannot find your account.')

        login(user, False)
