import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Mappa extends StatefulWidget {
  String posizione;

  Mappa(this.posizione);

  @override
  _MappaState createState() => _MappaState(posizione);
}

late double latitudine;
late double longitudine;

class _MappaState extends State<Mappa> {
  String posizione;

  _MappaState(this.posizione);

  Set<Marker> marker = {};

  @override
  Widget build(BuildContext context) {
    List coordinate = posizione.split(",");

    latitudine = double.parse(coordinate[0]);
    longitudine = double.parse(coordinate[1]);

    debugPrint('LATITUDINE: $latitudine');
    debugPrint('LONGITUDINE: $longitudine');

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

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      marker.add(Marker(
        flat: true,
        markerId: MarkerId('id-1'),
        position: LatLng(latitudine, longitudine),
      ));
    });
  }
}
