import 'package:flutter_prct_yt/ContactManager.dart';

class Overseer {
  Map<dynamic, dynamic> repository = {};

  Overseer() {
    register(ContactManager, ContactManager());
  }

  register(name, object) {
    repository[name] = object;
  }

  fetch(name) => repository[name];
}