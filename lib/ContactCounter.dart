import 'package:flutter/material.dart';
import 'package:flutter_prct_yt/Observer.dart';

import 'ContactManager.dart';
import 'Provider.dart';

class ContactCounter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ContactManager manager = Provider.of(context).fetch(ContactManager);
    
    return Observer<int>(
      stream: manager.count$,
      onSuccess: (context, data) {
        return Chip(
          label: Text(
            (data ?? 0).toString(),
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            )
          ),
          backgroundColor: Colors.red,
        );
      },
    );
  }
}