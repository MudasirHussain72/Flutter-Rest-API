import 'dart:convert';

import 'package:api/models/UserModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class GetUsersAPI extends StatefulWidget {
  const GetUsersAPI({Key? key}) : super(key: key);

  @override
  State<GetUsersAPI> createState() => _GetUsersAPIState();
}

class _GetUsersAPIState extends State<GetUsersAPI> {
  List<UserModel> userList = [];
  Future<List<UserModel>> getUserAPi() async {
    final response =
        await http.get(Uri.parse("https://jsonplaceholder.typicode.com/users"));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      for (Map i in data) {
        userList.add(UserModel.fromJson(i));
      }
      return userList;
    } else {
      return userList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("complex API"),
        ),
        body: Column(
          children: [
            Expanded(
              child: FutureBuilder(
                  future: getUserAPi(),
                  builder: (context, AsyncSnapshot<List<UserModel>> snapshot) {
                    if (!snapshot.hasData) {
                      return const CircularProgressIndicator();
                    } else {
                      return ListView.builder(
                          itemCount: userList.length,
                          itemBuilder: (context, index) {
                            return Card(
                              child: Column(
                                children: [
                                  ReUsableRow(
                                    title: "name",
                                    value:
                                        snapshot.data![index].name.toString(),
                                  ),
                                  ReUsableRow(
                                    title: "email",
                                    value:
                                        snapshot.data![index].email.toString(),
                                  ),
                                  ReUsableRow(
                                    title: "address",
                                    value: snapshot.data![index].address!.city
                                        .toString(),
                                  ),
                                  ReUsableRow(
                                    title: "geo",
                                    value: snapshot
                                        .data![index].address!.geo!.lat
                                        .toString(),
                                  ),
                                  ReUsableRow(
                                    title: "",
                                    value: snapshot
                                        .data![index].address!.geo!.lng
                                        .toString(),
                                  ),
                                ],
                              ),
                            );
                          });
                    }
                  }),
            ),
          ],
        ));
  }
}

// ignore: must_be_immutable
class ReUsableRow extends StatelessWidget {
  String title;
  String value;

  ReUsableRow({Key? key, 
    required this.title,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(title),
        Text(value),
      ]),
    );
  }
}
