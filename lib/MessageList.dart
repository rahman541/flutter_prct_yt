import 'package:flutter/material.dart';
import 'package:flutter_prct_yt/MessageDetail.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'Message.dart';

class MessageList extends StatefulWidget {
  final String title;
  final String status;

  const MessageList({Key key, this.title, this.status='important'}) : super(key: key);

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
    future = Message.browse(status: widget.status);
    messages = await future;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
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

              return Slidable(
                actionPane: SlidableDrawerActionPane(),
                actionExtentRatio: 0.25,
                child: ListTile(
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
                ),
                actions: <Widget>[
                  IconSlideAction(
                    caption: 'Archive',
                    color: Colors.blue,
                    icon: Icons.archive,
                    onTap: () => {},
                  ),
                  IconSlideAction(
                    caption: 'Share',
                    color: Colors.indigo,
                    icon: Icons.share,
                    onTap: () => {},
                  ),
                ],
                secondaryActions: <Widget>[
                  IconSlideAction(
                    caption: 'More',
                    color: Colors.black45,
                    icon: Icons.more_horiz,
                    onTap: () => {},
                  ),
                  IconSlideAction(
                    caption: 'Delete',
                    color: Colors.red,
                    icon: Icons.delete,
                    onTap: () {
                      setState(() {
                        messages.removeAt(index);
                      });
                    },
                  ),
                ],
                key: ObjectKey(message),
              );
            },
          );
        }
      },
    );
  }
}
