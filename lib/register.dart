import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:progettoaspdm/net/firebase.dart';
import 'package:progettoaspdm/pannello_admin.dart';
import 'package:progettoaspdm/services/authentication.dart';
import 'package:provider/provider.dart';

class Register extends StatefulWidget {
  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  late String id;

  final db = FirebaseFirestore.instance;

  final _formKey = GlobalKey<FormState>();

  late String name;

  String? tipoUtente = 'User';

  final items = ["User", "Admin"];

  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    final authService = Provider.of<Authentication>(context);

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
                        "Registrazione",
                        style: TextStyle(color: Colors.white, fontSize: 55),
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
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          children: [
                            const SizedBox(height: 5),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.purple[100]!,
                                    blurRadius: 20,
                                    offset: const Offset(0, 10),
                                  )
                                ],
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      border: Border(
                                        bottom:
                                        BorderSide(color: Colors.grey[200]!),
                                      ),
                                    ),
                                    child: Form(
                                      key: _formKey,
                                      child: Center(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Icon(Icons.settings, color: Colors.grey[500]),
                                                  Text('Tipo utente', style: TextStyle(fontSize: 20, color: Colors.grey[700])),
                                                  DropdownButton<String>(
                                                    items: items.map(buildMenuItem).toList(),
                                                    hint: const Text("User", style: TextStyle(fontSize: 20)),
                                                    value: tipoUtente,
                                                    onChanged: (valore) => setState(() {
                                                      this.tipoUtente = valore;
                                                    }),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: TextFormField(
                                                style: const TextStyle(fontSize: 20),
                                                controller: nameController,
                                                validator: validateNome,
                                                decoration: const InputDecoration(
                                                  labelText: "Nome",
                                                  icon: Icon(Icons.person),
                                                ),
                                                onSaved: (value) => name = value!,
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: TextFormField(
                                                style: const TextStyle(fontSize: 20),
                                                controller: emailController,
                                                validator: validateEmail,
                                                decoration: const InputDecoration(
                                                  labelText: "Email",
                                                  icon: Icon(Icons.mail),
                                                ),
                                                onSaved: (value) => name = value!,
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: TextFormField(
                                                style: const TextStyle(fontSize: 20),
                                                obscureText: true,
                                                controller: passwordController,
                                                validator: validatePassword,
                                                decoration: const InputDecoration(
                                                  labelText: "Password",
                                                  icon: Icon(Icons.lock),
                                                ),
                                              ),
                                            ),
                                            // Center(
                                            //   child: Text(errorMessage),
                                            // ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 50),
                            GestureDetector(
                              onTap: () async {
                                if (_formKey.currentState!.validate()) {
                                  // try{

                                  _formKey.currentState!.save();
                                  DocumentReference ref = await db
                                      .collection('Utenti')
                                      .add(
                                    {
                                      'Email': emailController.text,
                                      'Nome': nameController.text,
                                      'TipoUtente': tipoUtente,
                                    },
                                  );

                                  await authService.createUserWithEmailAndPassword(
                                      emailController.text, passwordController.text);
                                  debugPrint('Registrazione effettuata');

                                  setState(() {
                                    id = ref.id;
                                    debugPrint(ref.id);
                                    debugPrint('Campo database creato');
                                  });

                                  if (tipoUtente == "Admin") {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => PannelloAdmin()));
                                  }

                                  //Navigator.pop(context);
                                  // errorMessage = '';
                                  // } on FirebaseAuthException catch (error){
                                  //   errorMessage = error.message!;
                                  // }
                                }
                              },
                              child: Container(
                                height: 50,
                                margin: const EdgeInsets.symmetric(horizontal: 50),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: Colors.purple[900]),
                                child: const Center(
                                  child: Text(
                                    "Registrati",
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
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(
          item,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      );
}

String? validateNome(String? formNome) {
  if (formNome == null || formNome.isEmpty) {
    return "Il nome è richiesto";
  }

  return null;
}

String? validateEmail(String? formEmail) {
  if (formEmail == null || formEmail.isEmpty) {
    return "L'indirizzo e-mail è richiesto";
  }

  String pattern = r'\w+@\w+\.\w+';
  RegExp regex = RegExp(pattern);

  if (!regex.hasMatch(formEmail)) {
    return "Formato indirizzo e-mail non valido";
  }

  return null;
}

String? validatePassword(String? formPassword) {
  if (formPassword == null || formPassword.isEmpty) {
    return "La password è richiesta";
  }

  String pattern =
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
  RegExp regex = RegExp(pattern);

  if (!regex.hasMatch(formPassword)) {
    return "La password deve essere di almeno 8 caratteri e deve contenere una lettera maiuscola, un numero e un simbolo";
  }

  return null;
}
