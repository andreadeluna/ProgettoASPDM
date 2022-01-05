import 'package:flutter/material.dart';
import 'package:progettoaspdm/initial_page.dart';
import 'package:progettoaspdm/lista_eventi.dart';
import 'package:progettoaspdm/login.dart';
import 'package:progettoaspdm/profilo.dart';
import 'package:progettoaspdm/services/authentication.dart';
import 'package:provider/provider.dart';

class AppDrawerAdmin extends StatelessWidget {

  String email;

  AppDrawerAdmin(this.email);

  @override
  Widget build(BuildContext context) {

    final authService = Provider.of<Authentication>(context);

    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.purple[700],
            ),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey[300],
              ),
              child: const Padding(
                padding: EdgeInsets.all(5),
                child: Icon(Icons.person, size: 100, color: Colors.white),
              ),
            ),
          ),
          ListTile(
            title: Text('Profilo', style: TextStyle(fontSize: 20)),
            onTap: () async {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Profilo(email)));
            },
          ),
          ListTile(
            title: Text('Logout', style: TextStyle(fontSize: 20)),
            onTap: () async {
              await authService.signOut();
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => InitialPage()));
            },
          )
        ],
      ),
    );
  }
}
