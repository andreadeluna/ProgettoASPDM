import 'dart:async';
import 'package:flutter/material.dart';

// Schermata iniziale: visualizzazione splash screen
class App extends StatelessWidget {

  // Definizione schermata iniziale
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(),
    );
  }
}

// Implementazione splash screen
class SplashScreen extends StatefulWidget {

  SplashScreen();

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
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => Login()));
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
                Image.asset('images/icon.png', height: 150),
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
