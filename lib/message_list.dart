import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'message.dart';
import 'messages.dart';
import 'models.dart';

class MessageList extends StatelessWidget {
  final String spaceId;
  MessageList(this.spaceId);

  @override
  Widget build(BuildContext context) {
    final List<ChatMessage> spaceMessages =
        Provider.of<MessageProvider>(context).getMessagesById(spaceId);

    return ListView.builder(
        itemCount: spaceMessages.length,
        reverse: true,
        shrinkWrap: true,
        itemBuilder: (_, index) => Message(spaceMessages[index]));
  }
}
