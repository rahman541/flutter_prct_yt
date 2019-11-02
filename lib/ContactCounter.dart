import 'package:flutter/material.dart';

import 'ContactManager.dart';
import 'Provider.dart';

class ContactCounter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ContactManager manager = Provider.of(context);
    
    return StreamBuilder<int>(
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
    );
  }
}