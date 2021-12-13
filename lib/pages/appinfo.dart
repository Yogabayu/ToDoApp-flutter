import 'package:flutter/material.dart';

class Appinfo extends StatefulWidget {
  const Appinfo({Key? key}) : super(key: key);

  @override
  _AppinfoState createState() => _AppinfoState();
}

class _AppinfoState extends State<Appinfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('App info'),
      ),
      body: Container(),
    );
  }
}
