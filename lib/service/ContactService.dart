import 'dart:convert';

import 'package:flutter_prct_yt/model/Contact.dart';
import 'package:http/http.dart' as http;

class ContactService {
  // static String _url = 'https://jsonplaceholder.typicode.com/users';
  static String _url = 'https://secure-garden-21188.herokuapp.com/contacts';
  
  static Future<List<Contact>> browse({query}) async {
    http.Response response = await http.get(_url);
    String content = response.body;

    List collection = json.decode(content);

    Iterable<Contact> _contacts = collection.map((_)=>Contact.fromJson(_));

    if (query != null && query.isNotEmpty) {
      _contacts = _contacts.where((contact) => contact.name.toLowerCase().contains(query));
    }

    return _contacts.toList();
  }
}