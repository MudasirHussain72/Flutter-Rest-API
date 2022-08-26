import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class GetApiEx2 extends StatefulWidget {
  const GetApiEx2({Key? key}) : super(key: key);

  @override
  State<GetApiEx2> createState() => _GetApiEx2State();
}

class _GetApiEx2State extends State<GetApiEx2> {
  List<Photos> photosList = [];
  Future<List<Photos>> getPhotos() async {
    final responce = await http
        .get(Uri.parse("https://jsonplaceholder.typicode.com/photos"));
    var data = jsonDecode(responce.body.toString());
    if (responce.statusCode == 200) {
      for (Map i in data) {
        Photos photos = Photos(id: i['id'], title: i['title'], url: i['url']);
        photosList.add(photos);
      }
      return photosList;
    } else {
      return photosList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("get get using custom model"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
                future: getPhotos(),
                builder: (context, AsyncSnapshot<List<Photos>> snapshot) {
                  return ListView.builder(
                      itemCount: photosList.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: CircleAvatar(
                              backgroundImage: NetworkImage(
                                  snapshot.data![index].url.toString())),
                          title: Text(snapshot.data![index].title.toString()),
                          subtitle: Text(snapshot.data![index].id.toString()),
                        );
                      });
                }),
          )
        ],
      ),
    );
  }
}

class Photos {
  int id;
  String title, url;
  Photos({required this.id, required this.title, required this.url});
}
