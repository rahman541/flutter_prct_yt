import 'package:flutter/material.dart';
import 'package:flutter_prct_yt/ContactListBuilder.dart';
import 'package:flutter_prct_yt/manager/ContactManager.dart';
import 'package:flutter_prct_yt/model/Contact.dart';

import '../Provider.dart';

class ContactSearchDelegate extends SearchDelegate {
  final manager;

  ContactSearchDelegate({this.manager});

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    ContactManager manager = Provider.of(context).fetch(ContactManager);
    if (query.length < 3) {
      return Center(
        child: Text('Type at least 3 letter to search.'),
      );
    }

    manager.inFilter.add(query);

    return ContactListBuilder(
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
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    ContactManager manager = Provider.of(context).fetch(ContactManager);
    manager.inFilter.add(query);

    return ContactListBuilder(
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
    );
  }

}