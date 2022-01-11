import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:progettoaspdm/schermate/mappa.dart';

// Dettagli evento: permette di visualizzare i dettagli dell'evento
// e di visualizzare di conseguenza la posizione del locale
class DettagliEvento extends StatefulWidget {
  // *** Dichiarazione variabili ***
  String nomeEvento;
  String luogoEvento;

  DettagliEvento(this.nomeEvento, this.luogoEvento, {Key? key})
      : super(key: key);

  @override
  _DettagliEventoState createState() =>
      _DettagliEventoState(nomeEvento, luogoEvento);
}

// *** Dichiarazione variabili ***
int responseCode = 0;

// Widget per la visualizzazione dei dettagli
Card buildItem(DocumentSnapshot doc, String numeroTelefono, String posizione,
    String indirizzo, int responseCode) {
  return Card(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30),
    ),
    child: Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(3),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${doc.get('NomeEvento')}",
                  style: const TextStyle(
                      fontSize: 35, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
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
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        const Icon(Icons.access_time),
                        const SizedBox(width: 3),
                        Text(
                          "${doc.get('Orario')}",
                          style: const TextStyle(fontSize: 22),
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
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        const Icon(Icons.calendar_today_sharp),
                        const SizedBox(width: 3),
                        Text(
                          "${doc.get('Data')}",
                          style: const TextStyle(fontSize: 22),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(3),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Luogo: ",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        const Icon(Icons.location_on),
                        const SizedBox(width: 3),
                        Text(
                          "${doc.get('Luogo')}",
                          style: const TextStyle(fontSize: 22),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(3),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Telefono: ",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        const Icon(Icons.phone),
                        const SizedBox(width: 3),
                        Text(
                          numeroTelefono,
                          style: const TextStyle(fontSize: 22),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(3),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Indirizzo: ",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Text(
                  indirizzo,
                  maxLines: 8,
                  style: const TextStyle(fontSize: 22),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(3),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Descrizione: ",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "${doc.get('Descrizione')}",
                      style: const TextStyle(fontSize: 22),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(3),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Builder(builder: (context) {
                      if (responseCode == 200) {
                        // Visualizzazione posizzione del locale in una mappa
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Mappa(posizione)));
                          },
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.purple[900]),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(5),
                                child: Row(
                                  children: const [
                                    Icon(Icons.map, color: Colors.white),
                                    SizedBox(width: 3),
                                    Text(
                                      "Vai alla mappa!",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      } else {
                        return const SizedBox(height: 1);
                      }
                    }),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    ),
  );
}

// Definizione pagina di visualizzazione dettagli
class _DettagliEventoState extends State<DettagliEvento> {
  // *** Dichiarazione variabili ***
  final db = FirebaseFirestore.instance;
  String nomeEvento;
  String luogoEvento;
  late String numeroTelefono = '';
  late String indirizzo = '';
  late String posizione = '';

  _DettagliEventoState(this.nomeEvento, this.luogoEvento);

  // Inizializzazione pagina
  @override
  void initState() {
    super.initState();

    //  Caricamento dati da API
    Timer(
      const Duration(seconds: 2),
      () {
        recuperaDatiLocale();
      },
    );
  }

  // Caricamento dati da API
  Future recuperaDatiLocale() async {
    // *** Dichiarazione variabili ***
    String luogo = luogoEvento.replaceAll(' ', '');

    // Connessione al servizio
    final response = await http.get(
        Uri.parse(
            "https://findeatapi.herokuapp.com/?tipo=diretto&lista=${luogo}urbino"),
        headers: {
          HttpHeaders.acceptHeader: "application/json",
          HttpHeaders.userAgentHeader: "SampleApp/1.0"
        });

    responseCode = response.statusCode;

    // Se la connessione è andata a buon fine
    if (response.statusCode == 200) {

      Map<String, dynamic> dati = json.decode(response.body);
      List<dynamic> locale = dati["lista"];

      // Recupero dall'API il numero di telefono, l'indirizzo e la
      // posizione del locale in cui si svolgerà l'evento
      numeroTelefono = locale[0]["numtell"];
      indirizzo = locale[0]["indirizzo"];
      posizione = locale[0]["posizione"];

      setState(() {});
    } else {
      debugPrint(
          'IMPOSSIBILE CONNETTERSI AL SERVIZIO. STATUSCODE: ${response.statusCode}');
      numeroTelefono = " ";
      indirizzo = " ";
      posizione = " ";

      setState(() {});
    }
  }

  // Widget di costruzione della schermata di visualizzazione dettagli
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
        padding: const EdgeInsets.symmetric(vertical: 0),
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
                    padding: const EdgeInsets.all(0),
                    children: [
                      StreamBuilder<QuerySnapshot>(
                        stream: db
                            .collection('Eventi')
                            .where('NomeEvento', isEqualTo: nomeEvento)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Column(
                              children: snapshot.data!.docs
                                  .map((doc) => buildItem(doc, numeroTelefono,
                                      posizione, indirizzo, responseCode))
                                  .toList(),
                            );
                          } else {
                            return const SizedBox();
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
