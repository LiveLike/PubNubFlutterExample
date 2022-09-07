import 'package:flutter/material.dart';
import 'app_state.dart';
import 'message_left.dart';
import 'message_right.dart';
import 'models.dart';

class Message extends StatelessWidget {
  final ChatMessage message;

  Message(this.message);
  @override
  Widget build(BuildContext context) {
    final bool me = false;

    //  Change the alignment and look of messages from myself
    if (me) {
      return MessageRight(message);
    } else {
      return MessageLeft(message);
    }
  }
}
