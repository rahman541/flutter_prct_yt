import 'package:flutter/material.dart';
import 'package:flutter_prct_yt/CounterManager.dart';
import 'package:flutter_prct_yt/Observer.dart';

import 'Provider.dart';

class Counter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CounterManager manager = Provider.of(context).fetch(CounterManager);

    return Center(
      child: Observer<int>(
        stream: manager.counter$,
        onSuccess: (context, data) {
          return Text('Calendar: $data');
        }
      ),
    );
  }
}