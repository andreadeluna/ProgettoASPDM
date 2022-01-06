import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:progettoaspdm/home.dart';
import 'package:progettoaspdm/initial_page.dart';
import 'package:progettoaspdm/models/user.dart';
import 'package:progettoaspdm/pannello_admin.dart';
import 'package:progettoaspdm/services/authentication.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {

  int check = 1;

  @override
  Widget build(BuildContext context) {

    final authService = Provider.of<Authentication>(context);

    return StreamBuilder<User?>(
      stream: authService.user,
      builder: (_, AsyncSnapshot<User?> snapshot) {
        if(snapshot.connectionState == ConnectionState.active){
          final User? user = snapshot.data;
          if (user == null) {
            return InitialPage();
          } else {
            debugPrint('USER: ${user.email.toString()}');
            FirebaseFirestore.instance
              .collection('Utenti')
              .where('Email',
              isEqualTo:
              user.email)
              .get()
              .then((docs) {
              if (docs.docs[0]
                  .get('TipoUtente') ==
                  'Admin') {
                debugPrint('UTENTE ADMIN');
                //check = 0;
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PannelloAdmin(user.email.toString())));
                //PannelloAdmin(authService.user.toString());
              } else {
                debugPrint('UTENTE USER');
                //check = 1;
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Home(user.email.toString())));
                //Home(authService.user.toString());
              }
          }
          );
            //return PannelloAdmin(authService.user.toString());

            return check == 0
                ? PannelloAdmin(user.email.toString())
                : Scaffold(
              backgroundColor: Colors.purple[700],
              body: Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              ),
            );
          }}
        else {
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
