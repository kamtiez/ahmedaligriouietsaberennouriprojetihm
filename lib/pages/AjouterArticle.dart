import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AjouterArticle extends StatefulWidget {
  AjouterArticle({Key? key}) : super(key: key);

  @override
  _AjouterArticleState createState() => _AjouterArticleState();
}

class _AjouterArticleState extends State<AjouterArticle> {
  PickedFile? _image;

  Future _getImage() async {
    final image =
        // ignore: invalid_use_of_visible_for_testing_member
        await ImagePicker.platform.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  final TextEditingController controller_ref = TextEditingController();
  final TextEditingController controller_des = TextEditingController();
  final TextEditingController controller_pri = TextEditingController();
  final TextEditingController controller_img = TextEditingController();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    String path = "";
    return Scaffold(
      appBar: AppBar(title: const Text('ajouter article')),
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
            child: Container(
                child: _image == null
                    ? Container(
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            RaisedButton(
                              color: Colors.greenAccent,
                              onPressed: () {
                                _getImage();
                                path = _image!.path;
                              },
                              child: const Text("PICK FROM GALLERY"),
                            ),
                          ],
                        ),
                      )
                    : Container(
                        child: Image.network(_image!.path, height: 200),
                      ))),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: isLoading
              ? CircularProgressIndicator()
              : ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      isLoading = true;
                    });
                    path = _image!.path;
                    await firestore.collection("articles").add(
                      {
                        "reference": controller_ref.text,
                        "designation": controller_des.text,
                        "prix": controller_pri.text,
                        "image_path": path
                      },
                    );
                    setState(() {
                      isLoading = false;
                    });
                    controller_des.clear();
                    controller_ref.clear();
                    controller_img.clear();
                    controller_pri.clear();
                  },
                  child: Text("Add"),
                ),
        )
      ]),
    );
  }
}
