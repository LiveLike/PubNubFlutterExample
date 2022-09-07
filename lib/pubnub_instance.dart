import 'package:pubnub/pubnub.dart';

class PubNubInstance {
  late PubNub _pubnub;
  PubNub get instance => _pubnub;

  Subscription getSubscription(String channelName) {
    return _pubnub.subscribe(channels: {channelName}, withPresence: true);
  }

  PubNubInstance(String subscribeKey, String uuid) {
    //  Create PubNub configuration and instantiate the PubNub object, used to communicate with PubNub
    _pubnub = PubNub(
        defaultKeyset: Keyset(
            subscribeKey: subscribeKey,
            userId: UserId(uuid)));
  }

  dispose() async {}
}
