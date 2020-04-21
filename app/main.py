from flask import Flask
from flask import render_template

app = Flask(__name__)


@app.route('/', methods=['GET'])
def webapp():
    message = "Hello World"
    return render_template('main.html', message=message)
