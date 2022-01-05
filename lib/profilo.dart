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
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Nome: ",
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "${doc.get('Nome')}",
                    style: const TextStyle(fontSize: 24),
                  ),
                ],
              ),
            ),
            SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "E-mail: ",
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "${doc.get('Email')}",
                    style: const TextStyle(fontSize: 24),
                  ),
                ],
              ),
            ),
            SizedBox(height: 12),
          ],
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
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
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const <Widget>[
                    Text(
                      "Profilo",
                      style: TextStyle(color: Colors.white, fontSize: 60),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20),
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
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            children: [
                              Container(
                                width: 175,
                                height: 175,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.grey[300],
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.all(5),
                                  child: Icon(Icons.person, size: 160, color: Colors.white),
                                ),
                              ),
                              const SizedBox(height: 30),
                              StreamBuilder <QuerySnapshot> (
                                stream: db.collection('Utenti').where('Email', isEqualTo: 'aa@bb.com').snapshots(),
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
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


