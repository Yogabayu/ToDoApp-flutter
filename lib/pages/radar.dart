import 'dart:io';
// import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Radar extends StatefulWidget {
  const Radar({Key? key}) : super(key: key);

  @override
  _RadarState createState() => _RadarState();
}

class _RadarState extends State<Radar> {
  @override
  void initState() {
    super.initState();
    // Enable virtual display.
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
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
        body: WebView(
          initialUrl: 'https://juanda.jatim.bmkg.go.id/radar/',
        ));
  }
}
