import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:progettoaspdm/schermate/home.dart';
import 'package:progettoaspdm/schermate/pagina_iniziale.dart';
import 'package:progettoaspdm/modelli/user.dart';
import 'package:progettoaspdm/schermate/pannello_admin.dart';
import 'package:progettoaspdm/servizi/authentication.dart';
import 'package:provider/provider.dart';

// Wrapper: se l'utente è di tipo user indirizza alla homepage,
// se l'utente è di tipo admin indirizza al pannello di gestione
class Wrapper extends StatelessWidget {
  Wrapper({Key? key}) : super(key: key);

  // *** Dichiarazione variabili ***
  int checkUser = 1;

  // Definizione wrapper
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<Autenticazione>(context);

    return StreamBuilder<User?>(
      stream: authService.user,
      builder: (_, AsyncSnapshot<User?> snapshot) {
        // Se l'utente è connesso
        if (snapshot.connectionState == ConnectionState.active) {
          final User? user = snapshot.data;
          if (user == null) {
            return const PaginaIniziale();
          } else {
            FirebaseFirestore.instance
                .collection('Utenti')
                .where('Email', isEqualTo: user.email)
                .get()
                .then(
              (docs) {
                // Se l'utente è di tipo admin
                if (docs.docs[0].get('TipoUtente') == 'Admin') {
                  // Apre il pannello di gestione
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              PannelloAdmin(user.email.toString())));
                } else {
                  // Apre la homepage
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Home(user.email.toString())));
                }
              },
            );
            // Gestione schermata
            return checkUser == 0
                ? PannelloAdmin(user.email.toString())
                : Scaffold(
                    backgroundColor: Colors.purple[700],
                    body: const Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    ),
                  );
          }
        } else {
          // Schermata di caricamento
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
