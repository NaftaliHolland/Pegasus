""" Handles messages including verification sending and manipulation """

from flask import request
from flask import jsonify


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

def handle_message(request):
    """ parse request in json """
    body = request.get_json()
    message_body = body["entry"][0]["changes"][0]["value"]["messages"][0]["text"]["body"]
    is_valid = check_message_body(message_body)
    print ("Valid message") if is_valid else print("Not valid")

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


