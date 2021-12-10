import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todoapp_1/constant.dart';

String nama = "Yoga Bayu";

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      physics: ClampingScrollPhysics(),
      child: Column(
        children: <Widget>[
          Stack(
            children: [
              //isi backgroundnanati
              Padding(
                padding: padding,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.1,
                        ),
                        Padding(
                          padding: paddingCol,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: () => print("sukses"),
                                child: CircleAvatar(
                                  backgroundColor: Colors.greenAccent[400],
                                  radius: 30,
                                  child: Text(
                                    'user',
                                    style: TextStyle(
                                        fontSize: 25, color: Colors.white),
                                  ), //Text
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                "Hi " + nama,
                                style: TextStyle(
                                    fontFamily: "RobotoMono",
                                    fontSize: 26,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.none),
                              ),
                              defaultSeparator,
                              Icon(Icons.health_and_safety)
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    ));
  }
}
