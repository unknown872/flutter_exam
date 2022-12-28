import 'dart:convert';

import 'package:crud_api/views/home.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class Modifier extends StatelessWidget {
  // const ModifierEtudiant({Key? key}) : super(key: key);

  dynamic courseData;
  final formKey = GlobalKey<FormState>();
  Modifier({this.courseData});
  TextEditingController typeController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController dateFinController = TextEditingController();
  TextEditingController idController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    print(courseData);
    typeController.text = courseData["type"].toString();
    descriptionController.text = courseData["description"].toString();
    dateController.text = courseData["date"].toString();
    dateFinController.text = courseData["dateFin"].toString();
    idController.text = courseData["id"].toString();

    return Scaffold(
      appBar: AppBar(
        title: Text("Modifier"),
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => Home()));
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Form(
        key: formKey,
        child: ListView(children: [
          Padding(
            padding: const EdgeInsets.only(
                top: 16.0, left: 16.0, right: 16.0, bottom: 8.0),
            child: TextFormField(
              controller: typeController,
              decoration: const InputDecoration(
                  labelText: 'Type',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)))),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Champs obligatoire';
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                top: 16.0, left: 16.0, right: 16.0, bottom: 8.0),
            child: TextFormField(
              controller: descriptionController,
              decoration: const InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)))),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Champs obligatoire';
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                top: 16.0, left: 16.0, right: 16.0, bottom: 8.0),
            child: TextFormField(
              controller: dateController,
              decoration: const InputDecoration(
                labelText: "Date début",
                // hintText: "Ex. Insert your dob",
              ),
              onTap: () async {
                DateTime? date = DateTime(1900);
                FocusScope.of(context).requestFocus(new FocusNode());

                date = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime(2100));

                dateController.text = date!.toIso8601String();
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                top: 16.0, left: 16.0, right: 16.0, bottom: 8.0),
            child: TextFormField(
              controller: dateFinController,
              decoration: const InputDecoration(
                labelText: "Date fin",
                // hintText: "Ex. Insert your dob",
              ),
              onTap: () async {
                DateTime? date = DateTime(1900);
                FocusScope.of(context).requestFocus(new FocusNode());

                date = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime(2100));

                dateFinController.text = date!.toIso8601String();
              },
            ),
          ),
          SizedBox(height: 8.0),
          Center(
            child: ElevatedButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  // etudiant.add(nomController.text);
                  // etudiant.add( prenomController.text);
                  // etudiant.add(matriculeController.text);

                  modifierEtudiant(
                          typeController.text,
                          descriptionController.text,
                          dateController.text,
                          dateFinController.text,
                          int.parse(idController.text.toString()))
                      .then((value) {
                    print(value);
                    if (value == 200) {
                      print("in if ");
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Home()));

                      Fluttertoast.showToast(
                          msg: "Etudiant ajouté avec succès",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 5,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    }
                  });

                  // Navigator.pop(context);
                }
              },
              child: Text('Ajouter'),
            ),
          ),
          SizedBox(height: 8.0),
          Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Annuler'),
            ),
          ),
        ]),
      ),
    );
    ;
  }

  Future modifierEtudiant(String type, String description, String date,
      String dateFin, int id) async {
    var url = 'http://74.208.37.86:9088/textprixdist/${id}';
    print(url);
    var reponse = await http.put(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'type': type,
        'description': description,
        'date': date,
        'dateFin': dateFin,
      }),
    );
    print("La reponse  ${reponse.statusCode}");
    print("Le body  ${reponse.body}");
    if (reponse.statusCode == 200) {
      //listEtudiant = json.decode(reponse.body) ;
      print("Etudiant crée avec succès !");
      return reponse.statusCode;
    }
  }
}
