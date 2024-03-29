import 'package:flutter/material.dart';
import 'package:flutter_prct_yt/AppDrawer.dart';
import 'package:flutter_prct_yt/ContactCounter.dart';
import 'package:flutter_prct_yt/ContactListBuilder.dart';
import 'package:flutter_prct_yt/manager/ContactManager.dart';
import 'package:flutter_prct_yt/model/Contact.dart';

import '../Provider.dart';
import 'ContactSearchDelegate.dart';

class ContactsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ContactManager manager = Provider.of(context).fetch(ContactManager);

    manager.inFilter.add('');

    return DefaultTabController(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Contacts'),
          actions: <Widget>[
            ContactCounter(),
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: ContactSearchDelegate(),
                );
              },
            ),
            Padding(padding: EdgeInsets.only(right: 16)),
          ],
        ),
        drawer: AppDrawer(),
        body: ContactListBuilder(
          stream: manager.browse$,
          builder: (context, contacts) {
            return ListView.separated(
              itemCount: contacts?.length ?? 0,
              itemBuilder: (BuildContext context, int index){
                Contact _contact = contacts[index];
                return ListTile(
                  title: Text(_contact.name),
                  subtitle: Text(_contact.email),
                  leading: CircleAvatar(),
                );
              },
              separatorBuilder: (context, index) => Divider(),
            );
          },
        ),
      ),
      length: 2,
    );
  }
}