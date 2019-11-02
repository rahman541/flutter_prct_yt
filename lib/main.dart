import 'package:flutter/material.dart';
import 'package:flutter_prct_yt/Overseer.dart';
import 'App.dart';
import 'Provider.dart';

void main() => runApp(EmailApp());

class EmailApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider(
      data: Overseer(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.indigo, accentColor: Colors.red
        ),
        // home: MessageList(title: 'Flutter Demo Home Page'),
        home: App(),
      ),
    );
  }
}