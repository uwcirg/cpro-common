# coding: utf-8

# from contextlib import contextmanager
# from flask import g, current_app
from flask_sqlalchemy import SQLAlchemy 
from sqlalchemy import inspect

db = SQLAlchemy()

class SerializeMixin(object):
    # def __repr__(self):
    #     return json.dumps(self.serialize)

    @property
    def serialize(self):
       """Return object data in easily serializeable format"""

       serialized = {}

       for key in inspect(self.__class__).columns.keys():
           serialized[key] = getattr(self, key)

       return serialized
