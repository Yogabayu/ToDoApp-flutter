import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'pages/dashboard.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(fontFamily: 'Merriweather'),
      home: Dashboard(),
    );
  }
}
