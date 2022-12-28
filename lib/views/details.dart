import 'package:crud_api/views/home.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class DetailsCourses extends StatelessWidget {
  dynamic coursesData;
  String? type;
  DetailsCourses({this.coursesData, this.type});
  TextEditingController typeController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController dateFinController = TextEditingController();
  TextEditingController idController = TextEditingController();
  //const DetailsCourses({super.key});

  @override
  Widget build(BuildContext context) {
    typeController.text = coursesData["type"].toString();
    descriptionController.text = coursesData["description"].toString();
    dateController.text = coursesData["date"].toString();
    dateFinController.text = coursesData["dateFin"].toString();
    idController.text = coursesData["id"].toString();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Details"),
      ),
      body: Center(
        child: Container(
          color: Colors.grey,
          width: double.infinity,
          height: double.infinity,
          child: Card(
            elevation: 10,
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 50.0,
                  width: 1000.0,
                  child: ListTile(
                    title: Text("Type"),
                    trailing: Text("${typeController.text}"),
                  ),
                ),
                Container(
                  height: 50.0,
                  width: 1000.0,
                  child: ListTile(
                    title: Text("Description"),
                    trailing: Text("${descriptionController.text}"),
                  ),
                ),
                Container(
                  height: 50.0,
                  width: 1000.0,
                  child: ListTile(
                    title: Text("Date"),
                    trailing: Text("${dateController.text}"),
                  ),
                ),
                Container(
                  height: 50.0,
                  width: 1000.0,
                  child: ListTile(
                    title: Text("Date fin"),
                    trailing: Text("${dateFinController.text}"),
                  ),
                ),
                Container(
                  height: 50.0,
                  width: 1000.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          child: Text("Annuler"),
                          onPressed: () {
                            print("Annuler ");

                            Navigator.pop(context);
                          }),
                      SizedBox(width: 10.0),
                      ElevatedButton(
                        child: Text("Supprimer"),
                        onPressed: () {
                          print("Supprimer");
                          // print("${idController.text }");
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Home()));

                          Fluttertoast.showToast(
                              msg: "Elements supprimé",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 5,
                              backgroundColor: Colors.blue,
                              textColor: Colors.white,
                              fontSize: 16.0);
                          supprimerElement(
                              int.parse(idController.text.toString()));
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
    );
  }

  Future supprimerElement(int id) async {
    print(id);
    var url = 'http://74.208.37.86:9088/textprixdist/${id}';
    print(url);
    var reponse = await http.delete(Uri.parse(url));

    print("La reponse  ${reponse.statusCode}");
    print("Le body  ${reponse.body}");
    if (reponse.statusCode == 200) {}
  }
}
