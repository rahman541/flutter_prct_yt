import 'package:flutter/material.dart';

import 'Provider.dart';
import 'manager/CounterManager.dart';

class FabButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CounterManager manager = Provider.of(context).fetch(CounterManager);
    
    return FloatingActionButton(
      onPressed: manager.increment,
    );
  }
}