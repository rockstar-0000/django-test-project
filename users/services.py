from twilio.rest import Client

from django_site.settings import TWILIO_CREDS, DEBUG


def get_twilio_client():
    return Client(TWILIO_CREDS['SID'], TWILIO_CREDS['TOKEN'])


def send_twilio_message(to, body):
    if DEBUG:
        return None
    return get_twilio_client().messages.create(to, from_=TWILIO_CREDS['FROM'], body=body)
