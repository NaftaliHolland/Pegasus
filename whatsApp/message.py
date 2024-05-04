""" Handles messages including verification sending and manipulation """

from flask import request
from flask import jsonify
import os
import requests
import json


WEBHOOK_VERIFY_TOKEN = os.environ["WEBHOOK_VERIFY_TOKEN"]
GRAPH_API_TOKEN = os.environ["GRAPH_API_TOKEN"]
PHONE_NUMBER_ID = os.environ["PHONE_NUMBER_ID"]
VERSION = os.environ["VERSION"]

def verify(request):
    """ get webhook verification request parameters """

    mode = request.args["hub.mode"]
    token = request.args["hub.verify_token"]
    challenge = request.args["hub.challenge"]

    if mode and token:
        if mode == "subscribe" and token == WEBHOOK_VERIFY_TOKEN:
            print("Verified")
            return challenge, 200
        else:
            print("Verification failed")
            return jsonify({"status": "error", "message": "Verification failed"}), 403
    else:
        print("Missing parameter")
        return jsonify({"status": "error", "message": "Verifcation failed"}), 400


def create_send_message_body(sender, message):
    """ Creates json response for the message to be sent """

    return json.dumps(
            {
                "messaging_product": "whatsapp",
                "recepient_type": "individual",
                "to": sender,
                "type": "text",
                "text": {"preview_url": False, "body": message},
            }
        )


def get_sender(request):
    """ returns the sender's phone number """
    body = request.get_json()
    sender = body["entry"][0]["changes"][0]["value"]["contacts"][0]["wa_id"]

    return sender

def handle_sent_message(request):
    """ Handle response to message sent to customer """
    pass    

def handle_message(request):
    """ parse request in json """
    body = request.get_json()

    # Variable that will help distinguish a sent message from a received message
    sub_body = body["entry"][0]["changes"][0]["value"]

    if list(sub_body.keys())[-1] == "messages":
        message_body = body["entry"][0]["changes"][0]["value"]["messages"][0]["text"]["body"]

        is_valid = check_message_body(message_body)
        print ("Valid message") if is_valid else print("Not valid")
        send_message(message_body)

    #print("request body: {}".format(body))

    #body_object = json.loads(body)

    #print(body_object)
    return jsonify({"status": "ok"}), 200

def check_message_body(message_body):
    """ Checks the type of response user sends
        and sends valid response
    """
    try:
        amount = int(message_body)
        return True
    except:
        return False


def send_message(message="Hello"):
    """ Sends a message to the user """

    print("Here \n\n")
    sender = get_sender(request)
    data = create_send_message_body(sender, message)

    headers = {
            "Content-Type": "application/json",
            "Authorization": f"Bearer {GRAPH_API_TOKEN}"
            }
    url = f"https://graph.facebook.com/{VERSION}/{PHONE_NUMBER_ID}/messages"

    response = requests.post(
            url, data=data, headers=headers
        )
    print(response)
