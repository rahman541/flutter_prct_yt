import 'package:flutter/material.dart';

import 'Message.dart';
import 'screen/MessageCompose.dart';

class ComposeButton extends StatelessWidget {
  final List<Message> messages;

  ComposeButton(this.messages);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: () async {
        Message message = await Navigator.push(context, MaterialPageRoute(builder: (ctx) => MessageCompose()));

        if (message != null) {
          messages.add(message);
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text('You message has been sent with $message'),
            backgroundColor: Colors.green,
          ));
        };
      },
    );
  }
}