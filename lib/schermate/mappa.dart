import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// Mappa: permette di visualizzare la posizione del locale in cui
// si svolge l'evento all'interno di una mappa
class Mappa extends StatefulWidget {
  // *** Dichiarazione variabili ***
  String posizione;

  Mappa(this.posizione, {Key? key}) : super(key: key);

  @override
  _MappaState createState() => _MappaState(posizione);
}

// *** Dichiarazione variabili ***
late double latitudine;
late double longitudine;

// Definizione pagina di visualizzazione della mappa
class _MappaState extends State<Mappa> {
  // *** Dichiarazione variabili ***
  String posizione;

  _MappaState(this.posizione);

  Set<Marker> marker = {};

  // Widget di costruzione della schermata di visualizzazione della mappa
  @override
  Widget build(BuildContext context) {
    // *** Dichiarazione variabili ***
    List coordinate = posizione.split(",");

    latitudine = double.parse(coordinate[0]);
    longitudine = double.parse(coordinate[1]);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Posizione',
            style: TextStyle(fontSize: 40, color: Colors.white)),
        backgroundColor: Colors.purple[700],
      ),
      body: GoogleMap(
          onMapCreated: _onMapCreated,
          markers: marker,
          initialCameraPosition: CameraPosition(
              target: LatLng(latitudine, longitudine), zoom: 20)),
    );
  }

  // Inizializzazione della schermata
  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      marker.add(Marker(
        flat: true,
        markerId: const MarkerId('id-1'),
        position: LatLng(latitudine, longitudine),
      ));
    });
  }
}
