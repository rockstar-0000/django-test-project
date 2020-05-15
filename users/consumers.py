# chat/consumers.py
import json
from channels.layers import get_channel_layer
from channels.generic.websocket import WebsocketConsumer
from users.models import Profile, Conversation, Message, Socket
from datetime import datetime
from asgiref.sync import async_to_sync


# serializes the message to a dictionary
def message_to_dict(message):
    msg = {}
    msg['content'] = message.content
    msg['has_read'] = message.has_read
    msg['timestamp'] = message.timestamp.timestamp()
    msg['convo_id'] = message.convo_id
    msg['from_user_id'] = message.from_user_id
    return msg


# Consumes the websocket
class ChatConsumer(WebsocketConsumer):

    # channel name is a unique string that is stored in the database whenever a use connects
    # This string is set to '' when user disconnects. We use this to detect if user is currently connected and whether
    # to push realtime updates to
    def connect(self):
        try:
            socket = Socket.objects.get_or_create(user=self.scope["user"])[0]
            socket.channel_name = self.channel_name
            # TODO fix timestamp maybe add connected | disconnected timestamps
            # socket.last_timestamp
            socket.save()
            self.accept()
        except Exception as e:
            print(e)

    # When disconnecting we set the channel name to ''
    def disconnect(self, close_code):
        try:
            user_id = self.scope["user"].id
            socket = Socket.objects.get(user_id=user_id)
            socket.channel_name = ''
            socket.is_connected = False
            # TODO add last_timestamp
            # socket.last_timestamp =
            socket.save()
        except Exception as e:
            print(e)

    def receive(self, text_data):
        try:
            text_data_json = json.loads(text_data)

            cid = text_data_json['cid']
            command = text_data_json['command']

            if command == 'load_conversation':
                messages = list(Message.objects.filter(convo_id=cid))
                sorted_messages = sorted(messages, key=lambda x: x.timestamp, reverse=False)
                for i in range(0, len(sorted_messages)):
                    sorted_messages[i] = message_to_dict(sorted_messages[i])
                self.send(text_data=json.dumps({
                    'command': 'load_messages',
                    'messages': sorted_messages
                }))

            elif command == 'send_message':
                content = text_data_json['message']
                cid = text_data_json['cid']
                user_id = self.scope["user"].id
                cur_time = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
                msg = Message(convo_id=int(cid), from_user_id=user_id, content=content,
                              has_read=False)
                msg.save()

                C = Conversation.objects.get(pk=int(cid))
                C.last_update = cur_time
                C.last_message_id = msg.id
                C.save()

                c_users = list(C.users.all())

                for user in c_users:
                    channel_name = Socket.objects.get(user_id=user.id).channel_name
                    if channel_name != '' and channel_name is not None:
                        channel_layer = get_channel_layer()
                        msg_to_send = message_to_dict(msg)
                        msg_to_send['command'] = 'load_message'
                        msg_to_send['cid'] = cid
                        async_to_sync(channel_layer.send)(channel_name, {"type": "chat.message", "message": msg_to_send})
            else:
                pass
        except Exception as e:
            print(e)

    def chat_message(self, event):
        try:
            self.send(text_data=json.dumps(event["message"]))
        except Exception as e:
            print(e)