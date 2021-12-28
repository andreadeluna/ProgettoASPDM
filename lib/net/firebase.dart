/*
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> userSetup(String displayName) async {
  CollectionReference users = FirebaseFirestore.instance.collection('Users');
  FirebaseAuth auth = FirebaseAuth.instance;
  String uid = auth.currentUser!.uid.toString();

  users.add({
    'displayName': displayName,
    'uid': uid,
  });

  return;

}*/

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseProva extends StatefulWidget {

  @override
  _FirebaseProvaState createState() => _FirebaseProvaState();
}

class _FirebaseProvaState extends State<FirebaseProva> {

  late String id;
  final db = FirebaseFirestore.instance;
  final _formKey = GlobalKey<FormState>();
  late String name;

  Card buildItem(DocumentSnapshot doc) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget> [
            Text(
              "name: ${doc.get('name')}",
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                FlatButton(
                  onPressed: () => updateData(doc),
                  child: Text('Update'),
                  color: Colors.green,
                ),
                FlatButton(
                  onPressed: () => deleteData(doc),
                  child: Text('Delete'),
                  color: Colors.green,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  TextFormField buildTextFormField(){
    return TextFormField(
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: 'Name',
        fillColor: Colors.grey[300],
        filled: true
      ),
      validator: (value) {
        if(value!.isEmpty){
          return 'Inserisci del testo';
        }
      },
      onSaved: (value) => name = value!,
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
          Form(
            key: _formKey,
            child: buildTextFormField(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget> [
              RaisedButton(
                  onPressed: createData,
                child: Text('Crea'),
                color: Colors.blue,
              ),
              RaisedButton(
                onPressed: readData,
                child: Text('Crea'),
                color: Colors.blue,
              )
            ],
          ),
          StreamBuilder <QuerySnapshot> (
            stream: db.collection('CRUD').snapshots(),
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


  void createData() async {
    if(_formKey.currentState!.validate()){
      _formKey.currentState!.save();
      DocumentReference ref = await db.collection('CRUD').add({'name': '$name'});
      setState(() {
        id = ref.id;
        print(ref.id);
      });
    }
  }
  
  
  void readData() async {
    DocumentSnapshot snapshot = await db.collection('CRUD').doc(id).get();
    print(snapshot.data());
  }

  
  void updateData(DocumentSnapshot doc) async {
    await db.collection('CRUD').doc(doc.id).update({'todo': 'please'});
  }

  void deleteData(DocumentSnapshot doc) async {
    await db.collection('CRUD').doc(doc.id).delete();
    setState(() {
      id = 'null';
    });
  }
  
}


