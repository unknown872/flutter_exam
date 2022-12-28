import 'dart:convert';

import 'package:crud_api/views/ajouter.dart';
import 'package:crud_api/views/modifier.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'details.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<dynamic> listElements = [];

  @override
  void initState() {
    super.initState();
    getListElements();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Courses"),
          centerTitle: true,
          automaticallyImplyLeading: false),
      body: Center(
        child: ListView.separated(
          separatorBuilder: (context, index) => const Divider(
            height: 5,
            color: Colors.black,
          ),
          itemCount: listElements.length,
          itemBuilder: (context, index) {
            return ListTile(
              onTap: () {
                Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DetailsCourses(
                                coursesData: listElements[index],
                                type: listElements[index]["type"])))
                    .then((value) => setState(() {}));
              },
              title: InkWell(
                child: Text("${listElements[index]["id"]}"),
              ),
              subtitle: Text("${listElements[index]["type"]}"),
              trailing: Text("${listElements[index]["description"]}"),
              leading: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          Modifier(courseData: listElements[index]),
                    ),
                  );
                },
                icon: const Icon(Icons.brush),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Ajouter()))
              .then((value) => setState(() {}));
        },
      ),
    );
  }

  Future getListElements() async {
    var url = 'http://74.208.37.86:9088/textprixdist';
    print(url);
    var reponse = await http.get(Uri.parse(url));
    setState(() {
      print("La reponse  ${reponse.statusCode}");
      print("Le body  ${reponse.body}");
      if (reponse.statusCode == 200) {
        listElements = json.decode(reponse.body);
        // listElements.reversed.toList();
      }
    });
  }
}

// class MySearchDelegate extends SearchDelegate {
//   @override
//   List<Widget>? buildActions(BuildContext context) {
//     // TODO: implement buildActions
//     throw UnimplementedError();
//   }

//   @override
//   Widget? buildLeading(BuildContext context) {
//     // TODO: implement buildLeading
//     throw UnimplementedError();
//   }

//   @override
//   Widget buildResults(BuildContext context) {
//     // TODO: implement buildResults
//     throw UnimplementedError();
//   }

//   @override
//   Widget buildSuggestions(BuildContext context) {
//     // TODO: implement buildSuggestions
//     throw UnimplementedError();
//   }
// }
