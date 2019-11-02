import 'package:flutter/material.dart';

import 'MessageCompose.dart';

class ComposeButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: () async {
        String intention = await Navigator.push(context, MaterialPageRoute(builder: (ctx) => MessageCompose()));

        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text('You message has been sent with $intention'),
          backgroundColor: Colors.green,
        ));
      },
    );
  }
}