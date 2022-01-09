import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// Lista iscritti: permette di visualizzare gli utenti iscritti
// all'evento selezionato
class ListaIscritti extends StatefulWidget {
  // *** Dichiarazione variabili ***
  String nome;

  ListaIscritti(this.nome, {Key? key}) : super(key: key);

  @override
  _ListaIscrittiState createState() => _ListaIscrittiState(nome);
}

// Widget per la visualizzazione degli iscritti
class _ListaIscrittiState extends State<ListaIscritti> {
  // *** Dichiarazione variabili ***
  List<Widget> textWidgetList = <Widget>[];
  final db = FirebaseFirestore.instance;
  String nome;

  _ListaIscrittiState(this.nome);

  // Widget per la visualizzazione dei dati del singolo iscritto
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
              // Se sono presenti iscritti
              if (List.from(doc['Iscritti']).isNotEmpty) {
                for (int i = 0; i < List.from(doc['Iscritti']).length; i++) {
                  textWidgetList.add(
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(3),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Iscritto ${i + 1}",
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
                                "Nome:",
                                style: TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "${doc['Iscritti'][i]['Nome']}",
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
                                "Codice:",
                                style: TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "${doc['Iscritti'][i]['Codice']}",
                                style: const TextStyle(fontSize: 22),
                              ),
                            ],
                          ),
                        ),
                        Builder(builder: (context) {
                          if ((i + 1) < List.from(doc['Iscritti']).length) {
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
                          'Non sono presenti iscritti 😢',
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

  // Widget di costruzione della schermata di visualizzazione degli iscritti
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Iscritti',
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
                      // Visualizzazione iscritti
                      StreamBuilder<QuerySnapshot>(
                        stream: db
                            .collection('Eventi')
                            .where('NomeEvento', isEqualTo: nome)
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
