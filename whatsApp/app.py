""" Sends and receives messages to and from whatsApp """

from flask import Flask
from flask import request
from flask import jsonify
import os

app = Flask(__name__)

WEBHOOK_VERIFY_TOKEN = os.environ["WEBHOOK_VERIFY_TOKEN"]
GRAPH_API_TOKEN = os.environ["GRAPH_API_TOKEN"]


def verify(request):
    # get webhook verification request parameters

    mode = request.args["hub.mode"]
    token = request.args["hub.verify_token"]
    challenge = request.args["hub.challenge"]

    if mode and token:
        if mode == "subscribe" and token == WEBHOOK_VERIFY_TOKEN:
            print(mode)
            print(token)
            print(challenge)
            print("Verified")
            return challenge, 200
        else:
            print("Verification failed")
            return jsonify({"status": "error", "message": "Verification failed"}), 403
    else:
        print("Missing parameter")
        return jsonify({"status": "error", "message": "Verifcation failed"}), 400

def handle_message(request):
    # parse request in json
    body = request.get_json()
    print("requst body: {}".format(body))
    return jsonify({"status": "ok"}), 200

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
