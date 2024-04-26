""" Sends and receives messages to and from whatsApp """

from flask import Flask
from flask import request
import os

app = Flask(__name__)

WEBHOOK_VERIFY_TOKEN = os.environ["WEBHOOK_VERIFY_TOKEN"]
GRAPH_API_TOKEN = os.environ["GRAPH_API_TOKEN"]


def verify(request):
    mode = request.args["hub.mode"]
    token = request.args["hub.verify_token"]
    challenge = request.args["hub.challenge"]
    if mode == "subscribe" and token == WEBHOOK_VERIFY_TOKEN:
    print(mode)
    print(token)
    print(challenge)
    print("Verified")
    return 200
else:
    abort(403)




@app.route("/")
def hello_world():
    return WEBHOOK_VERIFY_TOKEN + GRAPH_API_TOKEN


@app.route("/webhook", methods=["POST", "GET"])
def webhook():
    #if not request.json:
    #    abort(400)

    if request.method == "POST":
        return request.json

    if request.method == "GET":
        
    if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
