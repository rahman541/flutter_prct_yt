import 'package:flutter/material.dart';

void main() => runApp(EmailApp());

class EmailApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey, accentColor: Colors.red
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatelessWidget {

  final String title;

  var messages = const [
    'My first message',
    'My second message',
    'You won lottery',
    'You should read this message',
    'You won lottery again',
  ];

  MyHomePage({this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(title),
      ),
      body: ListView.separated(
        separatorBuilder: (ctx, i) => Divider(),
        itemCount: messages.length,
        itemBuilder: (BuildContext context, int index) {
          var title = messages[index];

          return ListTile(
            title: Text(title),
            isThreeLine: true,
            leading: CircleAvatar(
              child: Text('PJ'),
            ),
            subtitle: Text('Another text which is very very long so everyone can read it see it.'),
          );
        },
      ),
    );
  }
}
