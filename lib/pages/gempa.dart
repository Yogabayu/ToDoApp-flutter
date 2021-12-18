// import 'package:flutter/foundation.dart';
import "package:flutter/material.dart";
import 'dart:async';
import 'dart:convert';
// import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class Gempa extends StatefulWidget {
  const Gempa({Key? key}) : super(key: key);

  @override
  _GempaState createState() => _GempaState();
}

class _GempaState extends State<Gempa> {
  bool isLoading = true;
  List data = []; //edited line

  Future<String> getSWData() async {
    var res = await http.get(
      Uri.parse("http://myapps3.000webhostapp.com/API-main/list/bmkg"),
    );
    // if (res.statusCode == 200) {

    // } else {}
    var resBody = json.decode(res.body)["gempa"];

    setState(() {
      data = resBody;
      isLoading = false;
      print(data);
    });
    return "Sucess";
  }

  @override
  void initState() {
    super.initState();
    this.getSWData();
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
                        Container(
                          width: MediaQuery.of(context).size.width * 0.7,
                          child: FittedBox(
                            child: Text(
                              "Update Info Gempa Indonesia",
                              style: TextStyle(
                                  fontFamily: "RobotoMono",
                                  fontSize: 26,
                                  color: Colors.black,
                                  decoration: TextDecoration.none),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Icon(Icons.health_and_safety)
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Source: BMKG",
                          style: TextStyle(
                              fontFamily: "RobotoMono",
                              fontSize: 12,
                              color: Colors.black,
                              decoration: TextDecoration.none),
                        ),
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
              physics: ClampingScrollPhysics(),
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
                              isLoading
                                  ? Center(child: CircularProgressIndicator())
                                  : Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20, right: 20),
                                      child: ListTileTheme(
                                        contentPadding: EdgeInsets.all(15),
                                        iconColor: Colors.blue,
                                        textColor: Colors.black,
                                        tileColor: Colors.yellow[100],
                                        style: ListTileStyle.list,
                                        dense: true,
                                        child: ListView.builder(
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: data.length - 25,
                                          itemBuilder: (_, index) => Card(
                                              margin: EdgeInsets.all(10),
                                              child: GestureDetector(
                                                onTap: () => {},
                                                child: ListTile(
                                                  title: Text(
                                                    "Daerah: " +
                                                        data[index]["wilayah"],
                                                    style: TextStyle(
                                                        fontFamily:
                                                            "RobotoMono",
                                                        color: Colors.black,
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        decoration:
                                                            TextDecoration
                                                                .none),
                                                  ),
                                                  subtitle: Row(
                                                    children: [
                                                      Text(
                                                          "Waktu: " +
                                                              data[index][
                                                                  "waktu_gempa"] +
                                                              "\n" +
                                                              "Magnitudo: " +
                                                              data[index][
                                                                  "magnitudo"] +
                                                              " SR" +
                                                              "\n" +
                                                              "Kedalaman: " +
                                                              data[index]
                                                                  ["kedalaman"],
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  "RobotoMono",
                                                              color:
                                                                  Colors.black,
                                                              decoration:
                                                                  TextDecoration
                                                                      .none))
                                                    ],
                                                  ),
                                                ),
                                              )),
                                        ),
                                      ))
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
