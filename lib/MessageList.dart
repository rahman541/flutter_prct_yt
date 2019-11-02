import 'package:flutter/material.dart';
import 'package:flutter_prct_yt/ComposeButton.dart';
import 'package:flutter_prct_yt/MessageCompose.dart';
import 'package:flutter_prct_yt/MessageDetail.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'Message.dart';

class MessageList extends StatefulWidget {

  final String title;

  const MessageList({Key key, this.title}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MessageList();
}

class _MessageList extends State<MessageList> {
  Future<List<Message>> future;
  List<Message> messages;

  @override
  void initState() {
    super.initState();
    // loadMessageList();
    // messages = Message.browse();
    fetch();
  }

  void fetch() async {
    future = Message.browse();
    messages = await future;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.refresh), onPressed: () async {
            var _messages = await Message.browse();
            setState(() {
             messages = _messages; 
            });
          }),
        ],
      ),
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountEmail: Text('rahmanromli@gmail.com'),
              accountName: Text('Rahman Bin Romli'),
              currentAccountPicture: CircleAvatar(
                // child: Text('R'),
                backgroundImage: NetworkImage('https://lh3.googleusercontent.com/-FEacuMUXmxI/AAAAAAAAAAI/AAAAAAAAAAA/ACHi3rcAKk6i2f72oGgizyG-N5PrjVNhJw.CMID/s83-c/photo.jpg'),
              ),
              otherAccountsPictures: <Widget>[
                GestureDetector(
                  onTap: () {
                    showDialog(context: context, builder: (context) {
                      return AlertDialog(title: Text('Adding new account'));
                    });
                  },
                  child: CircleAvatar(
                    child: Icon(Icons.add),
                  ),
                )
              ],
            ),
            ListTile(
              leading: Icon(FontAwesomeIcons.inbox),
              title: Text('Inbox'),
              trailing: Chip(
                label: Text('11', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                backgroundColor: Colors.green[800],
              ),
            ),
            ListTile(
              leading: Icon(FontAwesomeIcons.edit),
              title: Text('Draft'),
            ),
            ListTile(
              leading: Icon(FontAwesomeIcons.archive),
              title: Text('Archive'),
            ),
            ListTile(
              leading: Icon(FontAwesomeIcons.paperPlane),
              title: Text('Sent'),
            ),
            ListTile(
              leading: Icon(FontAwesomeIcons.trash),
              title: Text('Trash'),
            ),
            Divider(),
            Expanded(
              child: Align(
                alignment: FractionalOffset.bottomCenter,
                child: ListTile(
                  leading: Icon(FontAwesomeIcons.cog),
                  title: Text('Settings'),
                ),
              ),
            ),
          ],
        ),
      ),
      body: FutureBuilder(
        future: future,
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
      floatingActionButton: ComposeButton(messages),
    );
  }
}
