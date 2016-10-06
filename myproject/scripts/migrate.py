import sys
sys.path.insert(0, r'/vagrant/myproject')

from myproject.models import *
from myproject.settings import CONNECTION_STRING
from sqlalchemy import create_engine

if __name__ == "__main__":
    engine = create_engine(CONNECTION_STRING)
    Model.metadata.create_all(engine)
