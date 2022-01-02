import 'package:flutter/material.dart';
import 'package:progettoaspdm/lista_eventi.dart';
import 'package:progettoaspdm/profilo.dart';
import 'package:progettoaspdm/services/authentication.dart';
import 'package:provider/provider.dart';

class AppDrawer extends StatelessWidget {

  String email;

  AppDrawer(this.email);

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
            onTap: () async {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ListaEventi()));
            },
          ),
          ListTile(
            title: Text('Profilo'),
            onTap: () async {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Profilo(email)));
            },
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
