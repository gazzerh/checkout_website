import os
from flask import Flask
from flask import render_template

app = Flask(__name__)


@app.route('/', methods=['GET'])
def webapp():
    try:    
        version_file = open('./app_version.txt', 'r')
        version = version_file.read()
    except OSError:
        version = "No version available"

    message = 'Hello World'
    return render_template('main.html', message=message, version=version)
