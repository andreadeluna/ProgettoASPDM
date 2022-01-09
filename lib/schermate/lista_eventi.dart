import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// Lista eventi: permette di visualizzare gli eventi a cui
// è iscritto l'utente loggato all'interno dell'app
class ListaEventi extends StatefulWidget {
  // *** Dichiarazione variabili ***
  String email;

  ListaEventi(this.email, {Key? key}) : super(key: key);

  @override
  _ListaEventiState createState() => _ListaEventiState(email);
}

// Widget per la visualizzazione delle iscrizioni
class _ListaEventiState extends State<ListaEventi> {
  // *** Dichiarazione variabili ***
  String email;
  List<Widget> textWidgetList = <Widget>[];
  final db = FirebaseFirestore.instance;

  _ListaEventiState(this.email);

  // Widget per la visualizzazione dei dati del singolo evento
  Card buildItem(DocumentSnapshot doc) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Builder(builder: (context) {
              // Se sono presenti eventi
              if (List.from(doc['Eventi']).isNotEmpty) {
                for (int i = 0; i < List.from(doc['Eventi']).length; i++) {
                  textWidgetList.add(
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(3),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Evento ${i + 1}",
                                style: const TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Nome: ",
                                style: TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "${doc['Eventi'][i]['Evento']}",
                                style: const TextStyle(fontSize: 22),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Codice: ",
                                style: TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "${doc['Eventi'][i]['Codice']}",
                                style: const TextStyle(fontSize: 22),
                              ),
                            ],
                          ),
                        ),
                        Builder(builder: (context) {
                          if ((i + 1) < List.from(doc['Eventi']).length) {
                            return const Divider(color: Colors.grey);
                          } else {
                            return const SizedBox(height: 1);
                          }
                        })
                      ],
                    ),
                  );
                }

                return Column(children: [
                  Column(
                    children: textWidgetList,
                  )
                ]);
              } else {
                return Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          'Non sei iscritto a nessun evento ☹️',
                          style: TextStyle(fontSize: 21),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                );
              }
            }),
          ],
        ),
      ),
    );
  }

  // Widget di costruzione della schermata di visualizzazione delle iscrizioni
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Iscrizioni',
            style: TextStyle(fontSize: 50, color: Colors.white)),
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
                    children: <Widget>[
                      // Visualizzazione iscrizioni
                      StreamBuilder<QuerySnapshot>(
                        stream: db
                            .collection('Utenti')
                            .where('Email', isEqualTo: email)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Column(
                              children: snapshot.data!.docs
                                  .map((doc) => buildItem(doc))
                                  .toList(),
                            );
                          } else {
                            return const SizedBox();
                          }
                        },
                      )
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
