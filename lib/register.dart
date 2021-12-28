import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:progettoaspdm/initial_page.dart';
import 'package:progettoaspdm/services/authentication.dart';
import 'package:provider/provider.dart';

class Register extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    final authService = Provider.of<Authentication>(context);

    final GlobalKey<FormState> _key = GlobalKey<FormState>();

    String errorMessage = '';

    return Scaffold(
      body: Form(
        key: _key,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: emailController,
                  validator: validateEmail,
                  decoration: const InputDecoration(
                    labelText: "Email",
                    icon: Icon(Icons.mail),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  obscureText: true,
                  controller: passwordController,
                  validator: validatePassword,
                  decoration: const InputDecoration(
                    labelText: "Password",
                    icon: Icon(Icons.lock),
                  ),
                ),
              ),
              // Center(
              //   child: Text(errorMessage),
              // ),
              ElevatedButton(
                onPressed: () async {
                  if (_key.currentState!.validate()) {
                    // try{
                      await authService.createUserWithEmailAndPassword(
                          emailController.text, passwordController.text);
                      Navigator.pop(context);
                      // errorMessage = '';
                    // } on FirebaseAuthException catch (error){
                    //   errorMessage = error.message!;
                    // }
                  }
                },
                child: const Text('Registrati'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

String? validateEmail(String? formEmail){
  if(formEmail == null || formEmail.isEmpty){
    return "L'indirizzo e-mail è richiesto";
  }

  String pattern = r'\w+@\w+\.\w+';
  RegExp regex = RegExp(pattern);

  if(!regex.hasMatch(formEmail)){
    return "Formato indirizzo e-mail non valido";
  }

  return null;
}


String? validatePassword(String? formPassword) {
  if (formPassword == null || formPassword.isEmpty) {
    return "La password è richiesta";
  }

  String pattern =
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
  RegExp regex = RegExp(pattern);

  if (!regex.hasMatch(formPassword)) {
    return "La password deve essere di almeno 8 caratteri e deve contenere una lettera maiuscola, un numero e un simbolo";
  }

  return null;
}
