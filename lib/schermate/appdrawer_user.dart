import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:progettoaspdm/schermate/pagina_iniziale.dart';
import 'package:progettoaspdm/schermate/lista_eventi.dart';
import 'package:progettoaspdm/schermate/profilo.dart';
import 'package:progettoaspdm/servizi/authentication.dart';
import 'package:provider/provider.dart';

// App Drawer User: visualizza il drawer per l'utente di tipo user,
// permette di visualizzare il profilo e gli eventi a cui l'utente è
// iscritto e di effettuare il logout
class AppDrawerUser extends StatelessWidget {
  // *** Dichiarazione variabili ***
  String email;

  AppDrawerUser(this.email);

  // Definizione drawer
  @override
  Widget build(BuildContext context) {

    final authService = Provider.of<Autenticazione>(context);

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
              title: const Text('Iscrizioni', style: TextStyle(fontSize: 20)),
              onTap: () async {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ListaEventi(email)));
              },
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
                        builder: (context) => PaginaIniziale()));

                // Toast di avvenuto logout
                Fluttertoast.showToast(
                  msg: "Logout effettuato",
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.blueGrey,
                  textColor: Colors.white,
                  fontSize: 16.0,
                );
              },
            )
          ],
        ),
      );
  }
}
