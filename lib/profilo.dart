import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Profilo extends StatefulWidget {

  String email;

  Profilo(this.email);

  @override
  _ProfiloState createState() => _ProfiloState(email);
}

class _ProfiloState extends State<Profilo> {

  String email;

  late String id;
  final db = FirebaseFirestore.instance;
  final _formKey = GlobalKey<FormState>();
  late String name;

  List eventi = [];



  _ProfiloState(this.email);

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
              "E-mail: ${doc.get('email')}",
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


