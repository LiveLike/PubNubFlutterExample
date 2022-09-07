import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:pubnub/pubnub.dart';
import 'package:pubnub_flutter_example/livelike_app_details.dart';
import 'package:pubnub_flutter_example/pubnub_instance.dart';
import 'app_state.dart';
import 'chat_room_details.dart';
import 'models.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

export 'models.dart';

class MessageProvider with ChangeNotifier {
  Subscription? subscription;
  PubNub? pubnub;
  String channelName = "";
  late List<ChatMessage> _messages;

  List<ChatMessage> get messages =>
      ([..._messages]..sort((m1, m2) => m2.timetoken.compareTo(m1.timetoken)))
          .toList();

  MessageProvider._() {

    _messages = [];
    //Fetch App details to get subscriber key
    fetchAppDetails().then((appDetails) {
      PubNubInstance pubNubInstance = PubNubInstance(appDetails.pubnubSubscribeKey, "");
      this.pubnub = pubNubInstance.instance;

      getChatRoomDetails().then((value) {
        this.subscription = pubNubInstance.getSubscription(value.channels!.chat!.pubnub);
        this.channelName = value.channels!.chat!.pubnub;
        //  Applications receive various types of information from PubNub through a 'listener'
        //  This application dynamically registers a listener when it comes to the foreground
        subscription?.messages.listen((m) {
          if (m.messageType == MessageType.normal) {
            //  A message is received from PubNub.  This is the entry point for all messages on all
            //  channels or channel groups, though this application only uses a single channel.
            _addMessage(ChatMessage(
                timetoken: '${m.publishedAt}',
                channel: m.channel,
                uuid: m.uuid.value,
                message: m.content.toString()));
          } else if (m.messageType == MessageType.objects) {
            //  Whenever Object meta data is changed, an Object event is received.
            //  See: https://www.pubnub.com/docs/chat/sdks/users/setup
            //  Use this to be notified when other users change their friendly names

          }
        });
      });
    });
  }

  Future<ChatRoomDetails> getChatRoomDetails() async {
    final response = await http
        .get(Uri.parse('https://cf-blast.livelikecdn.com/api/v1/chat-rooms/5b524a0a-9036-4647-a046-da042fb6c202/'));
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return ChatRoomDetails.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  Future<AppDetails> fetchAppDetails() async {
    final response = await http
        .get(Uri.parse('https://cf-blast.livelikecdn.com/api/v1/applications/vGgUtbZTQWW6C6ROKSqRAO9wdrZaGffXEzYIAxwQ/'));
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return AppDetails.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  MessageProvider() : this._();

  getMessagesById(String spaceId) =>
      messages.where((message) => message.channel == spaceId).toList();

  _addMessage(ChatMessage message) {
    _messages.add(message);
    notifyListeners();
  }

  @override
  void dispose() async {
    subscription?.cancel();
    super.dispose();
  }
}
