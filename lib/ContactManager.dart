import 'dart:async';

import 'package:flutter_prct_yt/model/Contact.dart';
import 'package:flutter_prct_yt/service/ContactService.dart';
import 'package:rxdart/rxdart.dart';

class ContactManager {
  final BehaviorSubject<int> _contactCount = BehaviorSubject<int>();
  Stream<int> get contactCount => _contactCount.stream;

  Stream<List<Contact>> get contactListView => Stream.fromFuture(ContactService.browse());

  Stream<List<Contact>> filteredCollection({query}) => Stream.fromFuture(ContactService.browse(query: query));

  ContactManager() {
    contactListView.listen((list) => _contactCount.add(list.length));
  }
}