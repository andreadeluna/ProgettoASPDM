
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:progettoaspdm/AppDrawer.dart';
import 'package:progettoaspdm/services/authentication.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final _formKey = GlobalKey<FormState>();
  final db = FirebaseFirestore.instance;

  GetOptions? documentId;


  Card buildItem(DocumentSnapshot doc) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget> [
            Text(
              "Nome: ${doc.get('name')}",
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 12),
            Text(
              "Descrizione: ${doc.get('descrizione')}",
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 12),
            Text(
              "Orario: ${doc.get('orario')}",
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                /*FlatButton(
                  onPressed: () => updateData(doc),
                  child: Text('Update'),
                  color: Colors.green,
                ),*/
                FlatButton(
                  onPressed: () => {
                    updateData(doc),
                  },
                  child: Text('Iscriviti'),
                  color: Colors.green,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }



  @override
  Widget build(BuildContext context) {

    final authService = Provider.of<Authentication>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      drawer: AppDrawer(),
      body: ListView(
          padding: EdgeInsets.all(8),
          children: <Widget>[
            Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                StreamBuilder <QuerySnapshot> (
                  stream: db.collection('Eventi').snapshots(),
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
        ]
      ),
    );
  }

  void updateData(DocumentSnapshot doc) async {
    await db.collection('Eventi').doc(doc.id)
        .update({'iscritto': FieldValue.arrayUnion([{'nome': '${doc.get('name')}', 'ciaociao': 'prova3'}])});

    QuerySnapshot querySnap = await FirebaseFirestore.instance.collection('CRUD').where('email', isEqualTo: 'aa@bb.com').get();

    QueryDocumentSnapshot documentSnap = querySnap.docs[0];  // Assumption: the query returns only one document, THE doc you are looking for.

    DocumentReference docRef = documentSnap.reference;

    await docRef.update({'provautente': FieldValue.arrayUnion([{'evento': '${doc.get('name')}'}])});


    debugPrint('DOCUMENTO: ${doc}');

    debugPrint('DOCUMENTO ID: ${doc.id}');

    debugPrint('DOCUMENTO UTENTE: ${docRef.id}');
  }

}
