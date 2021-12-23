import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'splashscreen.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // Inizializzazione schermata iniziale dell'app
  runApp(App());

}