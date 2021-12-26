import 'package:flutter/material.dart';
import 'package:progettoaspdm/AppDrawer.dart';
import 'package:progettoaspdm/services/authentication.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final authService = Provider.of<Authentication>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      drawer: AppDrawer(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const Text("Sei nell'HomePage"),
          Center(
            child: ElevatedButton(
              child: const Text('Logout'),
              onPressed: () async {
                await authService.signOut();
              },
            ),
          )
        ],
      ),
    );
  }
}
