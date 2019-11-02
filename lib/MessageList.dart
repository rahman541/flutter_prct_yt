import 'package:flutter/material.dart';
import 'package:flutter_prct_yt/ComposeButton.dart';
import 'package:flutter_prct_yt/MessageCompose.dart';
import 'package:flutter_prct_yt/MessageDetail.dart';

import 'Message.dart';

class MessageList extends StatefulWidget {

  final String title;

  const MessageList({Key key, this.title}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MessageList();
}

class _MessageList extends State<MessageList> {
  Future<List<Message>> messages;

  @override
  void initState() {
    super.initState();
    // loadMessageList();
    messages = Message.browse();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.refresh), onPressed: () {
            var _messages = Message.browse();
            setState(() {
             messages = _messages; 
            });
          }),
        ],
      ),
      body: FutureBuilder(
        future: messages,
        builder: (BuildContext ctx, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
            case ConnectionState.active:
              return Center(child: CircularProgressIndicator(),);
            case ConnectionState.done:
            if (snapshot.hasError) return Text('There was an error: ${snapshot.error}');
              var messages = snapshot.data;
              return ListView.separated(
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
                    onTap: () {
                      Navigator.push(ctx, MaterialPageRoute(
                        builder: (ctx) => MessageDetail(message.subject, message.body)
                      ));
                    },
                  );
                },
              );
          }
        },
      ),
      floatingActionButton: ComposeButton(),
    );
  }
}
