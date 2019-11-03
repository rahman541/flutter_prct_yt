import 'package:flutter/material.dart';
import 'package:flutter_prct_yt/Message.dart';
import 'package:flutter_prct_yt/Provider.dart';
import 'package:flutter_prct_yt/RxTextField.dart';
import 'package:flutter_prct_yt/manager/MessageFormManager.dart';

class MessageCompose extends StatefulWidget {
  @override
  _MessageComposeState createState() => _MessageComposeState();
}

class _MessageComposeState extends State<MessageCompose> {
  @override
  Widget build(BuildContext context) {
    MessageFormManager manager = Provider.of(context).fetch(MessageFormManager);
    // var [email$, setEmail] = manager.useEmail();

    return Scaffold(
      appBar: AppBar(
        title: Text('Compose New Message')
      ),
      body: SingleChildScrollView(
        child: Form(
          child: Column(
            children: <Widget>[
              ListTile(
                title: RxTextField(
                  subscribe: manager.email$,
                  dispatch: manager.setEmail,
                  decoration: InputDecoration(
                    labelText: 'TO',
                    labelStyle: TextStyle(fontWeight: FontWeight.bold),
                  ),
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