import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PannelloAdmin extends StatefulWidget {

  @override
  _PannelloAdminState createState() => _PannelloAdminState();
}

class _PannelloAdminState extends State<PannelloAdmin> {

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
              "Nome: ${doc.get('NomeEvento')}",
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 12),
            Text(
              "Descrizione: ${doc.get('Descrizione')}",
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 12),
            Text(
              "Orario: ${doc.get('Orario')}",
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

    final TextEditingController nameEventoController = TextEditingController();
    final TextEditingController orarioController = TextEditingController();
    final TextEditingController descrizioneController = TextEditingController();


    return Scaffold(
      appBar: AppBar(
        title: Text('Prova Database'),
      ),
      body: ListView(
        padding: EdgeInsets.all(8),
        children: <Widget>[
          Form(
            key: _formKey,
            // child: buildTextFormField(),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: nameEventoController,
                    validator: (value) {
                      if(value!.isEmpty){
                        return 'Inserisci del testo';
                      }
                      },
                    decoration: const InputDecoration(
                      labelText: "Nome",
                      icon: Icon(Icons.mail),
                    ),
                    onSaved: (value) => name = value!,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: orarioController,
                    validator: (value) {
                      if(value!.isEmpty){
                        return 'Inserisci del testo';
                      }
                    },
                    decoration: const InputDecoration(
                      labelText: "Orario",
                      icon: Icon(Icons.mail),
                    ),
                    onSaved: (value) => name = value!,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: descrizioneController,
                    validator: (value) {
                      if(value!.isEmpty){
                        return 'Inserisci del testo';
                      }
                    },
                    decoration: const InputDecoration(
                      labelText: "Descrizione",
                      icon: Icon(Icons.mail),
                    ),
                    onSaved: (value) => name = value!,
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget> [
              ElevatedButton(
                onPressed: () async {
                  if(_formKey.currentState!.validate()){
                    _formKey.currentState!.save();
                    DocumentReference ref = await db.collection('Eventi').add({'NomeEvento': '${nameEventoController.text}'});
                    await db.collection('Eventi').doc(ref.id).update({'Orario': '${orarioController.text}'});
                    await db.collection('Eventi').doc(ref.id).update({'Descrizione': '${descrizioneController.text}'});

                    setState(() {
                      id = ref.id;
                      print(ref.id);
                    });
                  }
                },
                child: Text('Crea'),
              ),
              /*RaisedButton(
                onPressed: readData,
                child: Text('Crea'),
                color: Colors.blue,
              )*/
            ],
          ),
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
          )
        ],
      ),
    );
  }


  void createData() async {
    if(_formKey.currentState!.validate()){
      _formKey.currentState!.save();
      DocumentReference ref = await db.collection('Eventi').add({'NomeEvento': '$name'});
      setState(() {
        id = ref.id;
        print(ref.id);
      });
    }
  }


  void readData() async {
    DocumentSnapshot snapshot = await db.collection('Eventi').doc(id).get();
    print(snapshot.data());
  }


  void updateData(DocumentSnapshot doc) async {
    await db.collection('Utenti').doc(doc.id).update({'todo': 'please'});
  }

  void deleteData(DocumentSnapshot doc) async {
    await db.collection('Eventi').doc(doc.id).delete();
    setState(() {
      id = 'null';
    });
  }

}


