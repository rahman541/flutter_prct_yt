import 'dart:convert';

import 'package:flutter_prct_yt/model/Contact.dart';
import 'package:http/http.dart' as http;

class ContactService {
  // static String _url = 'https://jsonplaceholder.typicode.com/users';
  static String _url = 'https://secure-garden-21188.herokuapp.com/contacts';
  
  static Future<List<Contact>> browse({filter}) async {
    http.Response response = await http.get("$_url?q=$filter");
    String content = response.body;

    List collection = json.decode(content);

    Iterable<Contact> _contacts = collection.map((_)=>Contact.fromJson(_));

    // if (filter != null && filter.isNotEmpty) { // Filtering on server
    //   _contacts = _contacts.where((contact) => contact.name.toLowerCase().contains(filter));
    // }

    return _contacts.toList();
  }
}