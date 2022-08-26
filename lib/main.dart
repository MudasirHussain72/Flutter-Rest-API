// import 'package:api/screens/get_api_custom_model.dart';
import 'package:api/screens/complex_api_with_custom_model.dart';
import 'package:api/screens/user_api.dart';
// import 'package:api/screens/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home:
          // HomeScreen()
          // GetApiEx2(),
          // GetUsersAPI(),
          ComplexAPIWithCustomModel(),
    );
  }
}
