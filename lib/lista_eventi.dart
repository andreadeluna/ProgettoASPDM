import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ListaEventi extends StatefulWidget {

  @override
  _ListaEventiState createState() => _ListaEventiState();
}

class _ListaEventiState extends State<ListaEventi> {

  List<Widget> textWidgetList = <Widget>[];

  final db = FirebaseFirestore.instance;

  List eventi = [];



  Card buildItem(DocumentSnapshot doc) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget> [
            Builder(
                builder: (context) {

                  if(List.from(doc['eventi']).length > 0){

                    debugPrint('NUMERO EVENTI ${List.from(doc['eventi']).length}');

                    for(int i = 0; i < List.from(doc['eventi']).length; i++){

                      debugPrint('STAMPA EVENTO');
                      debugPrint("Eventi: ${doc['eventi'][i]['evento'].toString()}");


                      /*return Text(
                      "Eventi: ${doc['eventi'][i]['evento'].toString()}",
                      style: TextStyle(fontSize: 24),
                    );*/

                      textWidgetList.add(
                          Container(
                            margin: EdgeInsets.all(5.0),
                              child: Text(
                                  "Evento: ${doc['eventi'][i]['evento']}\nCodice: ${doc['eventi'][i]['codice']}\n",
                                style: TextStyle(fontSize: 20),
                              ),
                          ),
                      );

                    }

                    debugPrint('$textWidgetList');

                    return Column(
                      children: textWidgetList,
                    );

                  }
                  else{
                    return Text('Non sono presenti eventi');
                  }

                }
            ),
            //SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                /*FlatButton(
                  onPressed: () => updateData(doc),
                  child: Text('Update'),
                  color: Colors.green,
                ),*/

              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Prova Database'),
      ),
      body: ListView(
        padding: EdgeInsets.all(8),
        children: <Widget>[
          StreamBuilder <QuerySnapshot> (
            stream: db.collection('CRUD').where('email', isEqualTo: 'aa@bb.com').snapshots(),
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
    );
  }
}
