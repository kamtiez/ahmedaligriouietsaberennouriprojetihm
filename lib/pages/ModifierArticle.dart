import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ModifierArticle extends StatelessWidget {
  ModifierArticle({
    Key? key,
    required this.docId,
    required this.oldRef,
    required this.oldDes,
    required this.oldPrix,
    required this.oldImage,
  }) : super(key: key);
  final String docId;
  final String oldRef;
  final String oldDes;
  final String oldPrix;
  final String oldImage;

  TextEditingController controller_ref = TextEditingController();
  TextEditingController controller_des = TextEditingController();
  TextEditingController controller_pri = TextEditingController();
  TextEditingController controller_img = TextEditingController();

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    controller_ref.text = this.oldRef;
    controller_des.text = this.oldDes;
    controller_pri.text = this.oldPrix;
    controller_img.text = this.oldImage;
    return Scaffold(
      appBar: AppBar(title: Text(docId)),
      body: Column(mainAxisSize: MainAxisSize.min, children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            decoration: InputDecoration(labelText: "reference"),
            controller: controller_ref,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            decoration: InputDecoration(labelText: "designation"),
            controller: controller_des,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            decoration: InputDecoration(labelText: "prix"),
            controller: controller_pri,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            decoration: InputDecoration(labelText: "image_path"),
            controller: controller_img,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: isLoading
              ? CircularProgressIndicator()
              : ElevatedButton(
                  onPressed: () async {
                    await firestore.collection("articles").doc(docId).update(
                      {
                        "reference": controller_ref.text,
                        "designation": controller_des.text,
                        "prix": controller_pri.text,
                        "image_path": controller_img.text
                      },
                    );
                    controller_des.clear();
                    controller_ref.clear();
                    controller_img.clear();
                    controller_pri.clear();
                  },
                  child: Text("Modifier"),
                ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: isLoading
              ? CircularProgressIndicator()
              : ElevatedButton(
                  onPressed: () async {
                    await firestore.collection("articles").doc(docId).delete();
                    controller_des.clear();
                    controller_ref.clear();
                    controller_img.clear();
                    controller_pri.clear();
                  },
                  child: Text("supprimer"),
                ),
        )
      ]),
    );
  }
}
