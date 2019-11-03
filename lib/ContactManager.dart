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
    _filterSubject.debounceTime(Duration(milliseconds: 500))
      .switchMap((filter) async* {
        yield await ContactService.browse(filter: filter);
      }).listen((contacts) async {
        _collectionSubject.add(contacts);
    });
    print(_filterSubject);
    _collectionSubject.listen((list) => _countSubject.add(list.length));
  }

  void dispose() {
    _countSubject.close();
    _filterSubject.close();
  }
}