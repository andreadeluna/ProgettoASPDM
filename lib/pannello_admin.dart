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
                style: const TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    "Descrizione: ",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "${doc.get('Descrizione')}",
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
              SizedBox(height: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    "Orario: ",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "${doc.get('Orario')}",
                    style: TextStyle(fontSize: 20),
                  ),
                ],
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
                  GestureDetector(
                    //onTap: () => deleteData(doc),
                    onTap: (){
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
                                  height: 150,
                                  child: Padding(
                                    padding:
                                    EdgeInsets.fromLTRB(10, 70, 10, 10),
                                    child: Column(
                                      children: const [
                                        Text(
                                          "Attenzione",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 23),
                                        ),
                                        SizedBox(height: 5),
                                        Text(
                                          "Vuoi eliminare l'evento?",
                                          style: TextStyle(fontSize: 18),
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
                                      Icons.delete,
                                      color: Colors.white,
                                      size: 50,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            actions: [
                              TextButton(
                                child: const Text('No',
                                    style: TextStyle(fontSize: 20, color: Colors.purpleAccent)),
                                onPressed: () {
                                  Navigator.pop(context, false);
                                },
                              ),
                              TextButton(
                                child: const Text('Si',
                                    style: TextStyle(fontSize: 20, color: Colors.purpleAccent)),
                                onPressed: () {
                                  deleteData(doc);
                                  Navigator.pop(context, false);
                                },
                              ),
                            ],
                          ));
                    },
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.purple[900]),
                      child: const Center(
                        child: Padding(
                          padding: EdgeInsets.all(5),
                          child: Text(
                            "Elimina",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {

    final TextEditingController nameEventoController = TextEditingController();
    final TextEditingController orarioController = TextEditingController();
    final TextEditingController descrizioneController = TextEditingController();


    return WillPopScope(
      onWillPop: () async => false,
      child: MaterialApp(
        theme: ThemeData(
            primarySwatch: Colors.deepPurple,
            inputDecorationTheme: const InputDecorationTheme(
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.purple,
                    )
                )
            )
        ),
        home: Center(
          child: Scaffold(
            //floatingActionButton: ,
            appBar: AppBar(
              title: const Text('Pannello Admin',
                  style: TextStyle(fontSize: 40, color: Colors.white)),
              backgroundColor: Colors.purple[700],
            ),
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
                              Column(
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
                              )
                            ],
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


  void deleteData(DocumentSnapshot doc) async {
    await db.collection('Eventi').doc(doc.id).delete();
    setState(() {
      id = 'null';
    });
  }

}






class FloatButton extends StatefulWidget {

  @override
  _FloatButtonState createState() => _FloatButtonState();
}

class _FloatButtonState extends State<FloatButton> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

























