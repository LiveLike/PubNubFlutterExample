import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'messages.dart';

class NewMessageWidget extends StatefulWidget {
  final String spaceId;

  NewMessageWidget(this.spaceId);

  @override
  _NewMessageWidgetState createState() => _NewMessageWidgetState();
}

class _NewMessageWidgetState extends State<NewMessageWidget> {
  final _controller = TextEditingController();
  MessageProvider? messageProvider;
  DateTime? typingTimestamp;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    messageProvider = Provider.of<MessageProvider>(context, listen: false);

    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 5, left: 15, right: 15),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(35.0),
                    boxShadow: const [
                      BoxShadow(
                          offset: Offset(1, 3),
                          blurRadius: 5,
                          color: Colors.grey)
                    ],
                  )
                ),
              ),
              const SizedBox(width: 5)
            ],
          ),
        ),
      ],
    );
  }
}
