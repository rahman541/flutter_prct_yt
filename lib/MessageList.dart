import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MessageList extends StatefulWidget {

  final String title;

  const MessageList({Key key, this.title}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MessageList();
}

class _MessageList extends State<MessageList> {
  var messages = const[];

  Future loadMessageList() async {
    var content = await rootBundle.loadString('data/message.json');
    var collection = json.decode(content);
    setState((){
      messages = collection;
    });
    print(content);
  }

  @override
  void initState() {
    super.initState();
    loadMessageList();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: ListView.separated(
        separatorBuilder: (ctx, i) => Divider(),
        itemCount: messages.length,
        itemBuilder: (BuildContext context, int index) {
          var message = messages[index];

          return ListTile(
            title: Text(message['subject']),
            isThreeLine: true,
            leading: CircleAvatar(
              child: Text('PJ'),
            ),
            subtitle: Text(
              message['body'],
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          );
        },
      ),
    );
  }
}
