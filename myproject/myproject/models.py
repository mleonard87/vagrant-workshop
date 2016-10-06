from sqlalchemy import Column, Integer, String
from sqlalchemy.ext.declarative import declarative_base


Model = declarative_base()


class ToDo(Model):
    __tablename__ = 'todo'
    id = Column(Integer, primary_key=True, index=True)
    title = Column(String)
