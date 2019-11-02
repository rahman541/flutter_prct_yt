import 'package:flutter/material.dart';
import 'package:flutter_prct_yt/AppDrawer.dart';
import 'package:flutter_prct_yt/ContactListBuilder.dart';
import 'package:flutter_prct_yt/ContactManager.dart';
import 'package:flutter_prct_yt/ContactSearchDelegate.dart';

import 'model/Contact.dart';

class ContactsScreen extends StatelessWidget {
  ContactManager manager = ContactManager();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Contacts'),
          actions: <Widget>[
            StreamBuilder<int>(
              stream: manager.contactCount,
              builder: (context, snapshot) {
                return Chip(
                  label: Text(
                    (snapshot.data ?? 0).toString(),
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    )
                  ),
                  backgroundColor: Colors.red,
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: ContactSearchDelegate(manager: manager),
                );
              },
            ),
            Padding(padding: EdgeInsets.only(right: 16)),
          ],
        ),
        drawer: AppDrawer(),
        body: ContactListBuilder(
          stream: manager.contactListView,
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