import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app_state.dart';
import 'chat_body.dart';
import 'chat_title.dart';
import 'messages.dart';

class Conversation extends StatefulWidget {
  @override
  _ConversationState createState() => _ConversationState();
}

class _ConversationState extends State<Conversation>
    with WidgetsBindingObserver {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  var messageProvider;

  @override
  Widget build(BuildContext context) {
    messageProvider = Provider.of<MessageProvider>(context, listen: false);

    //  Header to hold the current friendly name of the device along with other devices in the group chat
    //  The below logic will launch the settings activity when the option is selected
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: ChatTitle(AppState.appTitle),
          backgroundColor: Colors.white
        ),
        body: GestureDetector(
            onTap: () {
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus) {
                currentFocus.unfocus();
              }
            },
            child: Consumer<MessageProvider>(
                builder: (_, friendlyNames, __) =>
                    ChatBody(messageProvider.channelName))));
  }

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  //  This application is designed to "unsubscribe" from the channel when it goes to the background and "re-subscribe"
  //  when it comes to the foreground.  This is a fairly common design pattern.  In production, you would probably
  //  also use a native push message to alert the user whenever there are missed messages.  For more information
  //  see https://www.pubnub.com/tutorials/push-notifications/
  //  Note that the Dart API uses slightly different terminology / behaviour to unsubscribe / re-subscribe.
  //  Note: This getting started application is set up to unsubscribe from all channels when the app goes into the background.
  //  This is good to show the principles of presence but you don't need to do this in a production app if it does not fit your use case.
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      //  Mobile only: App has gone to the background
      messageProvider.pubnub.announceLeave(channels: {messageProvider.channelName});
      messageProvider.subscription.pause();
    } else if (state == AppLifecycleState.resumed) {
      //  Mobile only: App has returned to the foreground
      messageProvider.subscription.resume();
      messageProvider.pubnub
          .announceHeartbeat(channels: {messageProvider.channelName});
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    Provider.of<MessageProvider>(context, listen: false).dispose();
    super.dispose();
  }
}
