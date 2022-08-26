import 'dart:convert';
import 'package:api/getAPI/user_api.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ComplexAPIWithoutModel extends StatefulWidget {
  const ComplexAPIWithoutModel({Key? key}) : super(key: key);

  @override
  State<ComplexAPIWithoutModel> createState() => _ComplexAPIWithoutModelState();
}

class _ComplexAPIWithoutModelState extends State<ComplexAPIWithoutModel> {
  var data;
  Future<void> getUserAPI() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    if (response.statusCode == 200) {
      data = jsonDecode(response.body.toString());
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Complex Json using custom model"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
                future: getUserAPI(),
                builder: ((context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Text("loading");
                  } else {
                    // return Text(data[0]['name'].toString());
                    return ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          return Card(
                            child: Column(
                              children: [
                                ReUsableRow(
                                    title: "name",
                                    value: data[index]['name'].toString()),
                                ReUsableRow(
                                    title: "username",
                                    value: data[index]['username'].toString()),
                                ReUsableRow(
                                    title: "email",
                                    value: data[index]['email'].toString()),
                                ReUsableRow(
                                    title: "address",
                                    value: data[index]['address']['city']
                                        .toString()),
                                // ReUsableRow(
                                //     title: "geo",
                                //     value: data[index]['address']['geo']
                                //         .toString()),
                                ReUsableRow(
                                    title: "geo",
                                    value: 'lat ' +
                                        data[index]['address']['geo']['lat']
                                            .toString()),
                                ReUsableRow(
                                    title: "",
                                    value: 'lng ' +
                                        data[index]['address']['geo']['lng']
                                            .toString()),
                              ],
                            ),
                          );
                        });
                  }
                })),
          )
        ],
      ),
    );
  }
}
