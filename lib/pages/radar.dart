import 'dart:convert';
import 'dart:io';
// import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Radar extends StatefulWidget {
  const Radar({Key? key}) : super(key: key);

  @override
  _RadarState createState() => _RadarState();
}

class _RadarState extends State<Radar> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // // Set landscape orientation
    // SystemChrome.setPreferredOrientations([
    //   DeviceOrientation.landscapeLeft,
    //   DeviceOrientation.landscapeRight,
    // ]);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Title'),
        ),
        body: Container());
  }
}
