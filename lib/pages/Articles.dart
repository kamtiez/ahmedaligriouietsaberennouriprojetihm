import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gestion_articles/pages/ModifierArticle.dart';

class Articles extends StatefulWidget {
  Articles({Key? key}) : super(key: key);

  @override
  _ArticlesState createState() => _ArticlesState();
}

class _ArticlesState extends State<Articles> {
  final TextEditingController controller = TextEditingController();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('articles')),
      body: FutureBuilder(
        future: firestore.collection("articles").get(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          } else if (snapshot.hasData) {
            // ignore: avoid_print
            print(snapshot.data);
            QuerySnapshot querySnapshot = snapshot.data as QuerySnapshot;
            List<QueryDocumentSnapshot> list = querySnapshot.docs;

            return ListView.builder(
                itemCount: list.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                      // When the child is tapped, do your work
                      onTap: () {
                        setState(() {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ModifierArticle(
                                      docId: list[index].id.toString(),
                                      oldDes: list[index].get("designation"),
                                      oldRef: list[index].get("reference"),
                                      oldPrix: list[index].get("prix"),
                                      oldImage: list[index].get("image_path"),
                                    )),
                          );
                        });
                      },
                      // Container
                      child: Container(
                        height: 50,
                        color: Colors.grey,
                        child: Card(
                            child: Text(
                          list[index].get("designation"),
                        )),
                      ));
                });
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }
}
