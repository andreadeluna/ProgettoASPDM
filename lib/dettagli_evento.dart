import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DettagliEvento extends StatefulWidget {

  String nomeEvento;

  DettagliEvento(this.nomeEvento);

  @override
  _DettagliEventoState createState() => _DettagliEventoState(nomeEvento);
}


Card buildItem(DocumentSnapshot doc) {
  return Card(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30),
    ),
    child: Padding(
      padding: EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget> [
          Padding(
            padding: const EdgeInsets.all(3),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${doc.get('NomeEvento')}",
                  style: const TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.all(3),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Orario: ",
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        Icon(Icons.access_time),
                        SizedBox(width: 3),
                        Text(
                          "${doc.get('Orario')}",
                          style: TextStyle(fontSize: 22),
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Giorno: ",
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        Icon(Icons.calendar_today_sharp),
                        SizedBox(width: 3),
                        Text(
                          "${doc.get('Data')}",
                          style: TextStyle(fontSize: 22),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(3),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Luogo: ",
                      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        Icon(Icons.location_on),
                        SizedBox(width: 3),
                        Text(
                          "${doc.get('Luogo')}",
                          style: TextStyle(fontSize: 22),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(3),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Telefono: ",
                      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        Icon(Icons.phone),
                        SizedBox(width: 3),
                        Text(
                          "Da inserire",
                          style: TextStyle(fontSize: 22),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(3),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Descrizione: ",
                      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "${doc.get('Descrizione')}",
                      style: TextStyle(fontSize: 22),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}


class _DettagliEventoState extends State<DettagliEvento> {

  final db = FirebaseFirestore.instance;

  String nomeEvento;

  _DettagliEventoState(this.nomeEvento);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dettagli evento',
            style: TextStyle(fontSize: 40, color: Colors.white)),
        backgroundColor: Colors.purple[700],
      ),
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 0),
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            colors: [
              Colors.purple[800]!,
              Colors.purple[700]!,
              Colors.purple[300]!,
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(60),
                    topRight: Radius.circular(60),
                    bottomLeft: Radius.circular(0),
                    bottomRight: Radius.circular(0),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: ListView(
                    padding: EdgeInsets.all(0),
                    children: [
                      StreamBuilder <QuerySnapshot> (
                        stream: db.collection('Eventi').where('NomeEvento', isEqualTo: '$nomeEvento').snapshots(),
                        builder: (context, snapshot){
                          if(snapshot.hasData){
                            return Column(
                              children:
                              snapshot.data!.docs.map((doc) => buildItem(doc)).toList(),
                            );
                          }
                          else {
                            return SizedBox();
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
