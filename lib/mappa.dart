import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Mappa extends StatefulWidget {
  const Mappa({Key? key}) : super(key: key);

  @override
  _MappaState createState() => _MappaState();
}

class _MappaState extends State<Mappa> {

  Set<Marker> marker = {};

  void _onMapCreated(GoogleMapController controller){
    setState(() {
      marker.add(
          Marker(
            markerId: MarkerId('id-1'),
            position: LatLng(43.72565219999999, 12.63764),
          )
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        onMapCreated: _onMapCreated,
          markers: marker,
          initialCameraPosition: CameraPosition(
              target: LatLng(43.72565219999999, 12.63764),
              zoom: 20
          )),
    );
  }
}
