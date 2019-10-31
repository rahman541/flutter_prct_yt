import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import 'Message.dart';

class MessageList extends StatefulWidget {

  final String title;

  const MessageList({Key key, this.title}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MessageList();
}

class _MessageList extends State<MessageList> {
  List<Message> messages = const[];

  Future loadMessageList() async {
    // String content = await rootBundle.loadString('data/message.json');
    http.Response response = await http.get('http://www.mocky.io/v2/5dbb06fe300000560e02940b');
    String content = response.body;

    List collection = json.decode(content);
    List<Message> _messages = collection.map((json)=>Message.fromJson(json)).toList();

    setState((){
      messages = _messages;
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
          Message message = messages[index];

          return ListTile(
            title: Text(message.subject),
            isThreeLine: true,
            leading: CircleAvatar(
              child: Text('PJ'),
            ),
            subtitle: Text(
              message.body,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          );
        },
      ),
    );
  }
}
