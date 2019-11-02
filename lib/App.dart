import 'package:flutter/material.dart';
import 'package:flutter_prct_yt/AppDrawer.dart';
import 'package:flutter_prct_yt/MessageList.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      child: Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            IconButton(icon: Icon(Icons.refresh), onPressed: () async {
            }),
          ],
          bottom: TabBar(tabs: <Widget>[
            Tab(text: "Important"),
            Tab(text: "Others"),
          ]),
        ),
        drawer: AppDrawer(),
        body: TabBarView(children: <Widget>[
          MessageList(status: 'important'),
          MessageList(status: 'other'),
        ]),
      ),
      length: 2,
    );
  }
}