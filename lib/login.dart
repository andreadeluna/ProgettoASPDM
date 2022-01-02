import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:progettoaspdm/home.dart';
import 'package:progettoaspdm/pannello_admin.dart';
import 'package:progettoaspdm/services/authentication.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {

    int currentIndex = 0;

    String gestisci;

    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    final authService = Provider.of<Authentication>(context);

    return Scaffold(
      body: Form(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: emailController,
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
                  decoration: const InputDecoration(
                    labelText: "Password",
                    icon: Icon(Icons.lock),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: (){
                  authService.signInWithEmailAndPassword(
                      emailController.text,
                      passwordController.text);

                  FirebaseFirestore.instance.collection('CRUD')
                  .where('email', isEqualTo: '${emailController.text}')
                  .get()
                  .then((docs) {

                    if(docs.docs[0].exists){
                      if(docs.docs[0].get('utente') == 'Admin'){
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PannelloAdmin()));
                      }
                      else{
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Home(emailController.text)));
                      }
                    }

                  }


                  );



                  // gestisci = gestisciAccesso();

                },
                child: const Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
