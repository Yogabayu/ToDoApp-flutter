import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:todoapp_1/constant.dart';

class User extends StatefulWidget {
  const User({Key? key}) : super(key: key);

  @override
  _UserState createState() => _UserState();
}

class _UserState extends State<User> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Column(
          children: <Widget>[
            Stack(
              children: [
                Image.asset(
                  "assets/bg_image.jpg",
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                ),
                Padding(
                  padding: padding,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.1,
                          ),
                          Center(
                            child: GestureDetector(
                              onTap: () => {},
                              child: CircleAvatar(
                                backgroundColor: Colors.greenAccent[400],
                                radius: 70,
                                child: Image.asset("assets/icon/user1.png"),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Center(
                              child: AutoSizeText(
                            "User Profile",
                            style: TextStyle(fontSize: 20),
                            maxLines: 2,
                          )),
                          Padding(
                            padding: paddingCol,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [],
                            ),
                          ),
                          SizedBox(
                            height: 30,
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
      ),
    );
  }
}
