import 'package:flutter/material.dart';
import 'package:progettoaspdm/home.dart';
import 'package:progettoaspdm/login.dart';
import 'package:progettoaspdm/models/user.dart';
import 'package:progettoaspdm/services/authentication.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<Authentication>(context);
    return StreamBuilder<User?>(
      stream: authService.user,
      builder: (_, AsyncSnapshot<User?> snapshot) {
        if(snapshot.connectionState == ConnectionState.active){
          final User? user = snapshot.data;
          return user == null ? Login() : Home();
        }
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
