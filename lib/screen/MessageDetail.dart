import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MessageDetail extends StatelessWidget {
  final String subject;
  final String body;

  const MessageDetail(this.subject, this.body);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(subject)),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Text(body),
      ),
    );
  }
}