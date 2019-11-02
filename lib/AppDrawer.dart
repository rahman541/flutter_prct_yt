import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountEmail: Text('rahmanromli@gmail.com'),
            accountName: Text('Rahman Bin Romli'),
            currentAccountPicture: CircleAvatar(
              // child: Text('R'),
              backgroundImage: NetworkImage('https://lh3.googleusercontent.com/-FEacuMUXmxI/AAAAAAAAAAI/AAAAAAAAAAA/ACHi3rcAKk6i2f72oGgizyG-N5PrjVNhJw.CMID/s83-c/photo.jpg'),
            ),
            otherAccountsPictures: <Widget>[
              GestureDetector(
                onTap: () {
                  showDialog(context: context, builder: (context) {
                    return AlertDialog(title: Text('Adding new account'));
                  });
                },
                child: CircleAvatar(
                  child: Icon(Icons.add),
                ),
              )
            ],
          ),
          ListTile(
            leading: Icon(FontAwesomeIcons.inbox),
            title: Text('Inbox'),
            trailing: Chip(
              label: Text('11', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
              backgroundColor: Colors.green[800],
            ),
          ),
          ListTile(
            leading: Icon(FontAwesomeIcons.edit),
            title: Text('Draft'),
          ),
          ListTile(
            leading: Icon(FontAwesomeIcons.archive),
            title: Text('Archive'),
          ),
          ListTile(
            leading: Icon(FontAwesomeIcons.paperPlane),
            title: Text('Sent'),
          ),
          ListTile(
            leading: Icon(FontAwesomeIcons.trash),
            title: Text('Trash'),
          ),
          Divider(),
          Expanded(
            child: Align(
              alignment: FractionalOffset.bottomCenter,
              child: ListTile(
                leading: Icon(FontAwesomeIcons.cog),
                title: Text('Settings'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}