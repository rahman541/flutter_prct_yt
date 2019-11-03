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
  @override
  Widget build(BuildContext context) {
    MessageFormManager manager = Provider.of(context).fetch(MessageFormManager);

    return Scaffold(
      appBar: AppBar(title: Text('Compose New Message')),
      body: SingleChildScrollView(
        child: Form(
          child: Column(
            children: <Widget>[
              ListTile(
                title: StreamBuilder<String> (
                  stream: manager.email$,
                  builder: (context, snapshot) {
                    return TextField (
                      onChanged: manager.inEmail.add,
                      // onChanged: (value) {
                      //   manager.inEmail.add(value);
                      // },
                      decoration: InputDecoration (
                        labelText: 'TO',
                        labelStyle: TextStyle(fontWeight: FontWeight.bold),
                        errorText: snapshot.error,
                      ),
                    );
                  },
                ),
              ),
              ListTile(
                title: StreamBuilder<Object>(
                  stream: manager.subject$,
                  builder: (context, snapshot) {
                    return TextField(
                      onChanged: manager.inSubject.add,
                      decoration: InputDecoration(
                        labelText: 'SUBJECT',
                        labelStyle: TextStyle(fontWeight: FontWeight.bold),
                        errorText: snapshot.error,
                      ),
                    );
                  }
                ),
              ),
              Divider(),
              ListTile(
                title: TextField(
                  onChanged: manager.inBody.add,
                  decoration: InputDecoration(
                    labelText: 'BODY',
                    labelStyle: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  maxLines: 9,
                ),
              ),
              ListTile(
                title: StreamBuilder<Object>(
                  stream: manager.isFormValid$,
                  builder: (context, snapshot) {
                    return RaisedButton(
                      child: Text('Send'),
                      onPressed: () {
                        if (snapshot.hasData) {
                          Message message = manager.submit();
                          Navigator.pop(context, message);
                        }
                      },
                    );
                  }
                ),
              ),
            ]
          ),
        ),
      ),
    );
  }
}