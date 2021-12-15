import 'package:flutter/foundation.dart';
import "package:flutter/material.dart";
import 'dart:async';
import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class Gempa extends StatefulWidget {
  const Gempa({Key? key}) : super(key: key);

  @override
  _GempaState createState() => _GempaState();
}

class _GempaState extends State<Gempa> {
  List data = []; //edited line

  Future<String> getSWData() async {
    var res = await http.get(
      Uri.parse("http://cuaca-gempa-rest-api.vercel.app/quake"),
    );
    // if (res.statusCode == 200) {

    // } else {}
    var resBody = json.decode(res.body);

    setState(() {
      data = resBody["data"];
      print(data);
    });
    return "Sucess";
  }

  @override
  void initState() {
    super.initState();
    // this.getSWData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: new BoxDecoration(color: Colors.white),
        child: Stack(children: <Widget>[
          Image.asset(
            "assets/bg_image.jpg",
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 30.0, right: 16.0, bottom: 20.0, top: 10.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 90,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Info Gempa Terakhir",
                          style: TextStyle(
                              fontFamily: "RobotoMono",
                              fontSize: 26,
                              color: Colors.black,
                              decoration: TextDecoration.none),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Icon(Icons.health_and_safety)
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
          Scaffold(
            //resizeToAvoidBottomInset: false,
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 0.0, right: 16.0, bottom: 20.0, top: 29.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Row(),
                        Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 120,
                              ),
                              ElevatedButton(
                                child: const Text('test'),
                                onPressed: () {
                                  getSWData();
                                },
                              )
                              // Padding(
                              //     padding: const EdgeInsets.only(
                              //         left: 20, right: 20),
                              //     child: ListTileTheme(
                              //       contentPadding: EdgeInsets.all(15),
                              //       iconColor: Colors.blue,
                              //       textColor: Colors.black,
                              //       tileColor: Colors.yellow[100],
                              //       style: ListTileStyle.list,
                              //       dense: true,
                              //       child: ListView.builder(
                              //         shrinkWrap: true,
                              //         itemCount: data.length,
                              //         itemBuilder: (_, index) => Card(
                              //             margin: EdgeInsets.all(10),
                              //             child: GestureDetector(
                              //               onTap: () => {},
                              //               child: ListTile(
                              //                 title:
                              //                     Text(data[index]["wilayah"]),
                              //                 trailing: Row(
                              //                   mainAxisSize: MainAxisSize.min,
                              //                   children: [],
                              //                 ),
                              //               ),
                              //             )),
                              //       ),
                              //     ))
                            ])
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ]));
  }
}
