""" Sends and receives messages to and from whatsApp """

from flask import Flask
from flask import request
from flask import jsonify
import os
import json

from .message import verify
from .message import handle_message

app = Flask(__name__)

WEBHOOK_VERIFY_TOKEN = os.environ["WEBHOOK_VERIFY_TOKEN"]
GRAPH_API_TOKEN = os.environ["GRAPH_API_TOKEN"]


@app.route("/")
def hello_world():
    return WEBHOOK_VERIFY_TOKEN + GRAPH_API_TOKEN


@app.route("/webhook", methods=["POST", "GET"])
def webhook():

    if request.method == "POST":
        return handle_message(request)

    if request.method == "GET":
        return verify(request)
        
if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
