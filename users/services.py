from twilio.rest import Client

from django_site.settings import TWILIO_CREDS

twilio_rest_client = Client(TWILIO_CREDS['SID'], TWILIO_CREDS['TOKEN'])
