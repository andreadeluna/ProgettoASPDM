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

  String? valore;

  final items = ["User", "Admin"];

  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    final authService = Provider.of<Authentication>(context);

    return Scaffold(
      body: Form(
        key: _formKey,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButton <String>(
                  items: items.map(buildMenuItem).toList(),
                  hint: Text("Tipo utente"),
                  value: valore,
                  onChanged: (valore) => setState(() {
                    this.valore = valore;
                  }),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: nameController,
                  validator: validateNome,
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
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    // try{

                    _formKey.currentState!.save();
                    DocumentReference ref = await db.collection('CRUD').add({'email': '${emailController.text}'});
                    await db.collection('CRUD').doc(ref.id).update({'name': '${nameController.text}'});
                    await db.collection('CRUD').doc(ref.id).update({'utente': '${valore}'});

                    await authService.createUserWithEmailAndPassword(
                          emailController.text, passwordController.text);
                    debugPrint('Registrazione effettuata');

                    setState(() {
                      id = ref.id;
                      debugPrint(ref.id);
                      debugPrint('Campo database creato');
                    });

                    if(valore == "Admin"){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => PannelloAdmin()));
                    }

                    //Navigator.pop(context);
                      // errorMessage = '';
                    // } on FirebaseAuthException catch (error){
                    //   errorMessage = error.message!;
                    // }
                  }
                },
                child: const Text('Registrati'),
              ),
            ],
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


String? validateNome(String? formNome){
  if(formNome == null || formNome.isEmpty){
    return "Il nome è richiesto";
  }

  return null;
}

String? validateEmail(String? formEmail){
  if(formEmail == null || formEmail.isEmpty){
    return "L'indirizzo e-mail è richiesto";
  }

  String pattern = r'\w+@\w+\.\w+';
  RegExp regex = RegExp(pattern);

  if(!regex.hasMatch(formEmail)){
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



