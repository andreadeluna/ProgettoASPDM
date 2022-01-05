
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:progettoaspdm/AppDrawerUser.dart';
import 'package:random_string/random_string.dart';

class Home extends StatefulWidget {

  String email;

  Home(this.email);

  @override
  State<Home> createState() => _HomeState(email);
}

class _HomeState extends State<Home> {

  String email;
  final db = FirebaseFirestore.instance;

  GetOptions? documentId;

  _HomeState(this.email);


  Card buildItem(DocumentSnapshot doc) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      child: Padding(
        padding: const EdgeInsets.all(0),
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.purple[50],
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget> [
              Text(
                "${doc.get('NomeEvento')}",
                style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 12),
              /*Text(
                "Descrizione: ${doc.get('Descrizione')}",
                style: TextStyle(fontSize: 24),
              ),
              SizedBox(height: 12),*/
              Text(
                "Orario: ${doc.get('Orario')}",
                style: TextStyle(fontSize: 24),
              ),
              SizedBox(height: 12),
              GestureDetector(
                onTap: () => {
                  updateData(doc),

                  Fluttertoast.showToast(
                  msg: "Iscrizione effettuata",
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.blueGrey,
                  textColor: Colors.white,
                  fontSize: 16.0,
                ),

                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                  backgroundColor: Colors.grey[50],
                  shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                  ),
                  content: Stack(
                  overflow: Overflow.visible,
                  alignment: Alignment.topCenter,
                  children: [
                  Container(
                  height: 220,
                  child: Padding(
                  padding:
                  EdgeInsets.fromLTRB(10, 70, 10, 10),
                  child: Column(
                  children: const [
                  Text(
                  "Iscrizione effettuata!",
                  style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 23),
                  ),
                  SizedBox(height: 30),
                  Text(
                  "Vai nelle tue iscrizioni per visualizzare il tuo codice personale! 🥳",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20),
                  ),

                  ],
                  ),
                  ),
                  ),
                  Positioned(
                  top: -60,
                  child: CircleAvatar(
                  backgroundColor: Colors.purple[700],
                  radius: 60,
                  child: Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 50,
                  ),
                  ),
                  )
                  ],
                  ),
                  actions: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        height: 50,
                        margin: const EdgeInsets.symmetric(horizontal: 50),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.purple[900]),
                        child: const Center(
                          child: Text(
                            "Chiudi",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ],
                  ),
                ),

                },
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.purple[900]),
                  child: const Center(
                    child: Text(
                      "Iscriviti",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }



  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: () async => false,
      child: MaterialApp(
        home: Center(
          child: Scaffold(
            appBar: AppBar(
              title: const Text('Eventi',
                style: TextStyle(fontSize: 50, color: Colors.white)),
              backgroundColor: Colors.purple[700],
            ),
            drawer: AppDrawerUser(email),
            body: Container(
              padding: EdgeInsets.symmetric(vertical: 30),
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  colors: [
                    Colors.purple[500]!,
                    Colors.purple[400]!,
                    Colors.purple[200]!,
                  ],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: Colors.purple[900]!,
                            style: BorderStyle.solid,
                            width: 2,
                          ),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                            bottomLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListView(
                              padding: const EdgeInsets.all(8),
                              children: <Widget>[
                                Column(
                                  //mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    StreamBuilder <QuerySnapshot> (
                                      stream: db.collection('Eventi').snapshots(),
                                      builder: (context, snapshot){
                                        if(snapshot.hasData){
                                          return Column(
                                            crossAxisAlignment: CrossAxisAlignment.stretch,
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
                            ]
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }



  void updateData(DocumentSnapshot doc) async {

    QuerySnapshot querySnap = await FirebaseFirestore.instance.collection('Utenti').where('Email', isEqualTo: 'aa@bb.com').get();

    QueryDocumentSnapshot documentSnap = querySnap.docs[0];  // Assumption: the query returns only one document, THE doc you are looking for.

    DocumentReference docRef = documentSnap.reference;

    String codice;

    codice = randomAlphaNumeric(8);


    await db.collection('Eventi').doc(doc.id)
        .update({'Iscritti': FieldValue.arrayUnion([{'Nome': '${doc.get('NomeEvento')}', 'Codice': '${codice}'}])});

    await docRef.update({'Eventi': FieldValue.arrayUnion([{'Evento': '${doc.get('NomeEvento')}', 'Codice': '${codice}'}])});

  }

}
