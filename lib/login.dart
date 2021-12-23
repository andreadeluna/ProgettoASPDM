import 'package:flutter/material.dart';
import 'package:progettoaspdm/services/authentication.dart';
import 'package:provider/provider.dart';

class Login extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    final authService = Provider.of<Authentication>(context);

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: "Email",
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: passwordController,
              decoration: const InputDecoration(
                labelText: "Password",
              ),
            ),
          ),
          ElevatedButton(
            onPressed: (){
              authService.signInWithEmailAndPassword(
                  emailController.text,
                  passwordController.text);
            },
            child: const Text('Login'),
          ),
          ElevatedButton(
            onPressed: (){
              Navigator.pushNamed(context, '/register');
            },
            child: Text('Register'),
          )
        ],
      ),
    );
  }
}