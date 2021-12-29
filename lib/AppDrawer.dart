import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: const [
          /*DrawerHeader(
            child: Text('Menu'),
          ),*/
          ListTile(
            title: Text('Eventi'),
          ),
          ListTile(
            title: Text('Profilo'),
          ),
          ListTile(
            title: Text('Logout'),
          )
        ],
      ),
    );
  }
}
