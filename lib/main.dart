import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'splashscreen.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  try{
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyAQPYrQwL84Vmj9skmMP7PLwIfTi6XWuMU",
        appId: "1:570175095212:web:aa794f83263479414f3a09",
        messagingSenderId: "570175095212",
        projectId: "letsmeet-67ecf",
      ),
    );
  }
  catch(e){
    Scaffold(
      body: Container(
        child: Text('$e'),
      ),
    );
  }

  // Inizializzazione schermata iniziale dell'app
  runApp(App());

}