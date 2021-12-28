import 'package:flutter/material.dart';
import 'package:progettoaspdm/login.dart';
import 'package:progettoaspdm/register.dart';
import 'package:progettoaspdm/services/authentication.dart';
import 'package:provider/provider.dart';

class InitialPage extends StatefulWidget {

  @override
  State<InitialPage> createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {

    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    final authService = Provider.of<Authentication>(context);

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          //debugPrint("Tab $index selected");
          setState(() {
            currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.login), label: "Login"),
          BottomNavigationBarItem(
              icon: Icon(Icons.person), label: "Registrazione"),
        ],
      ),
      body: Builder(
        builder: (context) {
          switch (currentIndex) {
            case 1:
              return Register();

            case 0:
            default:
              return Login();
          }
        },
      )
    );
  }
}


class _IncreasingButton extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _IncreasingButtonState();
}

class _IncreasingButtonState extends State<_IncreasingButton> {
  int counter = 1;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Text("Counter: $counter + 1"),
      onPressed: () {
        setState(() {
          counter++;
        });
      },
    );
  }
}
