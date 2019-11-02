import 'package:flutter/material.dart';
import 'package:flutter_prct_yt/Message.dart';

class MessageCompose extends StatefulWidget {
  @override
  _MessageComposeState createState() => _MessageComposeState();
}

class _MessageComposeState extends State<MessageCompose> {
  String to ="";
  String subject = "";
  String body = "";

  final key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Compose New Message')),
      body: SingleChildScrollView(
        child: Form(
          key: key,
          child: Column(
            children: <Widget>[
              ListTile(
                title: TextFormField(
                  onSaved: (value) => to = value,
                  decoration: InputDecoration(
                    labelText: 'TO',
                    labelStyle: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  maxLines: 5,
                ),
              ),
              ListTile(
                title: TextFormField(
                  onSaved: (value) => subject = value,
                  decoration: InputDecoration(
                    labelText: 'SUBJECT',
                    labelStyle: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  maxLines: 5,
                ),
              ),
              Divider(),
              ListTile(
                title: TextFormField(
                  onSaved: (value) => body = value,
                  decoration: InputDecoration(
                    labelText: 'BODY',
                    labelStyle: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  maxLines: 8,
                ),
              ),
              ListTile(
                title: RaisedButton(
                  child: Text('Send'),
                  onPressed: () {
                    this.key.currentState.save();
                    Message message = Message(subject, body);
                    Navigator.pop(context, message);
                  },
                ),
              ),
            ]
          ),
        ),
      ),
    );
  }
}