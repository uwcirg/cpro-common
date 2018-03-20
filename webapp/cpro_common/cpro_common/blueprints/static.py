from flask import Blueprint, make_response, jsonify, flash, redirect, url_for, request, current_app, render_template

bp = Blueprint('static', __name__)

@bp.route('/')
def index():
    return render_template('home.html')

@bp.route('/index')

@bp.route('/hello')
def hello():
    return 'Welcome to cPRO Commons!'

