import 'dart:async';
import 'package:flutter/material.dart';
import 'package:progettoaspdm/net/firebase.dart';
import 'package:progettoaspdm/register.dart';
import 'package:progettoaspdm/services/authentication.dart';
import 'package:progettoaspdm/wrapper.dart';
import 'package:provider/provider.dart';

import 'home.dart';
import 'initial_page.dart';

// Schermata iniziale: visualizzazione splash screen
class App extends StatelessWidget {

  // Definizione schermata iniziale
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<Authentication>(
          create: (_) => Authentication(),
        ),
      ],
      child: MaterialApp(
        title: 'Progetto ASPDM',
        //home: SplashScreen(),
        initialRoute: '/',
        routes: {
          '/': (context) => SplashScreen(),
          '/login': (context) => InitialPage(),
          '/register': (context) => Register(),
        },
      ),
    );
  }
}

// Implementazione splash screen
class SplashScreen extends StatefulWidget {

  // Definizione della splash screen
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

// Implementazione della splash screen
class _SplashScreenState extends State<SplashScreen> {

  // Visualizzazione della splash screen per 3 secondi
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 3),
          () {
        // Apertura schermata di inserimento dati
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Wrapper()));
      },
    );
  }

  // Widget di costruzione della schermata di splash screen
  @override
  Widget build(BuildContext context) {
    // Impedisco di tornare alla schermata precedente
    return WillPopScope(
      onWillPop: () async => false,
      child: MaterialApp(
        home: Scaffold(
          backgroundColor: Colors.blue[800],
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('images/icona.png', height: 200),
                const SizedBox(height: 20),
                const Text(
                  "Let's Meet!",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 40),
                const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
