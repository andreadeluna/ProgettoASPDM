import 'package:flutter/material.dart';
import 'package:progettoaspdm/services/authentication.dart';
import 'package:provider/provider.dart';

class AppDrawer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final authService = Provider.of<Authentication>(context);

    return Drawer(
      child: ListView(
        children: [
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
            onTap: () async {
              await authService.signOut();
            },
          )
        ],
      ),
    );
  }
}
