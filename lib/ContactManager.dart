import 'dart:async';

import 'package:flutter_prct_yt/model/Contact.dart';
import 'package:flutter_prct_yt/service/ContactService.dart';
import 'package:rxdart/rxdart.dart';

class ContactManager {
  final PublishSubject<String> _filterSubject = PublishSubject<String>();
  final PublishSubject<int> _countSubject = PublishSubject<int>();
  final PublishSubject<List<Contact>> _collectionSubject = PublishSubject();

  Sink<String> get inFilter => _filterSubject.sink;

  Observable<int> get count$ => _countSubject.stream;
  Observable<List<Contact>> get browse$ => _collectionSubject.stream;

  ContactManager() {
    _filterSubject.listen((filter) async {
      var contacts = await ContactService.browse(query: filter);
      _collectionSubject.add(contacts);
    });
    _collectionSubject.listen((list) => _countSubject.add(list.length));
  }

  void dispose() {
    _countSubject.close();
    _filterSubject.close();
  }
}