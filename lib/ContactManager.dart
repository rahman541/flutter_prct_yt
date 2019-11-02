import 'dart:async';

import 'package:flutter_prct_yt/model/Contact.dart';
import 'package:flutter_prct_yt/service/ContactService.dart';
import 'package:rxdart/rxdart.dart';

class ContactManager {
  final BehaviorSubject<int> _contactCount = BehaviorSubject<int>();

  Stream<int> get count$ => _contactCount.stream;
  Stream<List<Contact>> browse$({filter}) => Stream.fromFuture(ContactService.browse(query: filter));

  ContactManager() {
    browse$().listen((list) => _contactCount.add(list.length));
  }

  void dispose() {
    _contactCount.close();
  }
}