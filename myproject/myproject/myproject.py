from flask import Flask, render_template, request, redirect
from sqlalchemy.orm import sessionmaker
from sqlalchemy import create_engine
from .models import ToDo
from .settings import CONNECTION_STRING
application = Flask(__name__)

engine = create_engine(CONNECTION_STRING)

@application.route('/')
def hello():
    Session = sessionmaker(bind=engine)
    session = Session()
    todos = session.query(ToDo).all()
    session.close()
    return render_template('index.html', todos=todos)

@application.route('/newtodo', methods=['POST', ])
def new_todo():
    title = request.form.get('todoTitle', 'You didnt enter a title!')
    todo = ToDo(title=title)
    Session = sessionmaker(bind=engine)
    session = Session()
    session.add(todo)
    session.commit()
    session.close()
    return redirect('/', code=302)

if __name__ == '__main__':
    application.run(host='0.0.0.0')
