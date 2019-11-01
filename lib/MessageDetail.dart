import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MessageDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Message Details')),
      body: Center(
        child: Text('Message details'),
      ),
    );
  }
}