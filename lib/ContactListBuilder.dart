import 'package:flutter/material.dart';
import 'Observer.dart';
import 'model/Contact.dart';

class ContactListBuilder extends StatelessWidget {
  @required
  final Function builder;
  final Stream stream;

  const ContactListBuilder({this.builder, this.stream});

  @override
  Widget build(BuildContext context) {
    return Observer<List<Contact>>(
      stream: stream,
      onSuccess: (BuildContext context, List<Contact> data) => builder(context, data),
      onWaiting: (context) => LinearProgressIndicator(),
    );
  }
}