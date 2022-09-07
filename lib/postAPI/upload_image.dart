import 'dart:io';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class UploadImageScreen extends StatefulWidget {
  const UploadImageScreen({Key? key}) : super(key: key);

  @override
  State<UploadImageScreen> createState() => _UploadImageScreenState();
}

class _UploadImageScreenState extends State<UploadImageScreen> {
  File? image;
  final _picker = ImagePicker();
  bool showSpinner = false;
  Future getImage() async {
    final pickedFile =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    if (pickedFile != null) {
      image = File(pickedFile.path);
      setState(() {});
    } else {
      print("no image selected");
    }
  }

  Future<void> UploadImage() async {
    setState(() {
      showSpinner = true;
    });
    var stream = new http.ByteStream(image!.openRead());
    stream.cast();
    var length = await image!.length();
    var uri = Uri.parse('https://fakestoreapi.com/products');
    var request = new http.MultipartRequest("POST", uri);
    request.fields['title'] = 'static title';
    var multiport = new http.MultipartFile("image", stream, length);
    request.files.add(multiport);
    var response = await request.send();
    print(response.stream.toString());
    if (response.statusCode == 200) {
      setState(() {
        showSpinner = false;
      });
      print("image uploaded");
    } else {
      print("failed");
      setState(() {
        showSpinner = false;
        //
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
        appBar: AppBar(
          title: Text("UploadImageScreen"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  getImage();
                },
                child: Container(
                  child: image == null
                      ? Center(
                          child: Text("pick image"),
                        )
                      : Container(
                          child: Center(
                            child: Image.file(
                              File(image!.path).absolute,
                              height: 100,
                              width: 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                ),
              ),
              SizedBox(
                height: 150,
              ),
              InkWell(
                onTap: () {
                  UploadImage();
                },
                child: Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.deepPurple[300],
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(child: Text("upload")),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
