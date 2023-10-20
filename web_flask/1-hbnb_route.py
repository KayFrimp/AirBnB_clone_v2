#!/usr/bin/python3
"""Hello Flask Module"""

from flask import Flask

app = Flask(__name__)


@app.route('/', strict_slashes=False)
def hello_flask():
    """Starting Function"""
    return "Hello HBNB!"


@app.route('/hbnb', strict_slashes=False)
def hello_hbnb():
    """Display HBNB"""
    return "HBNB"


if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
