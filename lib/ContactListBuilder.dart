import 'package:flutter/material.dart';
import 'model/Contact.dart';

class ContactListBuilder extends StatelessWidget {
  @required
  final Function builder;
  final Stream stream;

  const ContactListBuilder({this.builder, this.stream});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Contact>>(
      stream: stream,
      builder: (BuildContext context, AsyncSnapshot<List<Contact>> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
          case ConnectionState.active:
            return Center(child: CircularProgressIndicator(),);
          case ConnectionState.done:
            List<Contact> contacts = snapshot.data;

            return builder(context, contacts);
        }
      }
    );
  }
}