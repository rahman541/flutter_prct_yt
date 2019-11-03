import 'package:flutter/material.dart';
import 'package:flutter_prct_yt/Message.dart';
import 'package:flutter_prct_yt/Provider.dart';
import 'package:flutter_prct_yt/manager/MessageFormManager.dart';
import 'package:rxdart/rxdart.dart';

import '../Observer.dart';

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
    MessageFormManager manager = Provider.of(context).fetch(MessageFormManager);

    return Scaffold(
      appBar: AppBar(title: Text('Compose New Message')),
      body: SingleChildScrollView(
        child: Form(
          key: key,
          child: Column(
            children: <Widget>[
              ListTile(
                title: Observer<String> (
                  stream: manager.email$,
                  onSuccess: (context, data) {
                    return TextField (
                      onChanged: manager.inEmail.add,
                      // onChanged: (value) {
                      //   manager.inEmail.add(value);
                      // },
                      decoration: InputDecoration (
                        labelText: 'TO',
                        labelStyle: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    );
                  },
                  onError: (context, error) {
                    return TextField (
                      onChanged: manager.inEmail.add,
                      decoration: InputDecoration (
                        labelText: 'TO',
                        labelStyle: TextStyle(fontWeight: FontWeight.bold),
                        errorText: error,
                      )
                    );
                  },
                ),
              ),
              ListTile(
                title: TextFormField(
                  validator: (val) {
                    int len = val.length;
                    if (len == 0) return '`SUBJECT` cannot be empty.';
                    else if (len < 4) {
                      return '`SUBJECT` mus be longer than 4 character';
                    }
                    return null;
                  },
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
                    if (this.key.currentState.validate()) {
                      this.key.currentState.save();
                      Message message = Message(subject, body);
                      Navigator.pop(context, message);
                    }
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