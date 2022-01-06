import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ListaIscritti extends StatefulWidget {

  String nome;

  ListaIscritti(this.nome);

  @override
  _ListaIscrittiState createState() => _ListaIscrittiState(nome);
}

class _ListaIscrittiState extends State<ListaIscritti> {

  List<Widget> textWidgetList = <Widget>[];

  final db = FirebaseFirestore.instance;

  List eventi = [];

  String nome;

  _ListaIscrittiState(this.nome);



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
            Builder(
                builder: (context) {

                  if(List.from(doc['Iscritti']).length > 0){

                    debugPrint('NUMERO EVENTI ${List.from(doc['Iscritti']).length}');

                    for(int i = 0; i < List.from(doc['Iscritti']).length; i++){

                      debugPrint('STAMPA EVENTO');
                      debugPrint("Eventi: ${doc['Iscritti'][i]['Nome'].toString()}");


                      /*return Text(
                      "Eventi: ${doc['eventi'][i]['evento'].toString()}",
                      style: TextStyle(fontSize: 24),
                    );*/

                      textWidgetList.add(
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(3),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Iscritto ${i+1}",
                                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Nome:",
                                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
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
                                  Text(
                                    "Codice:",
                                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "${doc['Iscritti'][i]['Codice']}",
                                    style: const TextStyle(fontSize: 22),
                                  ),
                                ],
                              ),
                            ),
                            Builder(builder: (context){
                              if((i+1) < List.from(doc['Iscritti']).length){
                                return Divider(color: Colors.grey);
                              }
                              else{
                                return SizedBox(height: 1);
                              }
                            })
                          ],
                        ),
                      );
                    }

                    debugPrint('$textWidgetList');

                    return Column(
                        children: [
                          Container(
                            child: Column(
                              children: textWidgetList,
                            ),
                          )
                        ]
                    );

                  }
                  else{
                    return Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Text('Non sono presenti iscritti 😢',
                                style: const TextStyle(fontSize: 21),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                }
            ),
          ],
        ),
      ),
    );
  }

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
                    children: <Widget>[
                      StreamBuilder <QuerySnapshot> (
                        stream: db.collection('Eventi').where('NomeEvento', isEqualTo: nome).snapshots(),
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
