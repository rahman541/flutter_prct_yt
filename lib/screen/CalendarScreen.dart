import 'package:flutter/material.dart';
import 'package:flutter_prct_yt/FabButton.dart';

import '../AppDrawer.dart';
import '../Counter.dart';


class CalendarScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Calendar')),
      drawer: AppDrawer(),
      body: Counter(),
      floatingActionButton: FabButton(),
    );
  }
}