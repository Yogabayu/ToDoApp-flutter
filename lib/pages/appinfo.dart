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
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Container(
              color: Colors.red,
              height: 300,
              width: double.infinity,
              child: Image.asset(
                "assets/bg_image.jpg",
                fit: BoxFit.cover,
              ),
            ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(top: 240),
              padding: const EdgeInsets.only(top: 30),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(60),
                    topRight: Radius.circular(60),
                  )),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(
                      left: 30,
                    ),
                    child: const Text(
                      "ToDo App",
                      style:
                          TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                      left: 35,
                      top: 10,
                    ),
                    child: const Text(
                      "dibuat oleh: ",
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 35, top: 20),
                    child: const Text(
                      "Yoga Bayu Anggana Pratama",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    margin: const EdgeInsets.only(right: 20, left: 30),
                    width: double.infinity,
                    child: const Text(
                      "versi : 1.1.0",
                      style: TextStyle(fontSize: 19, color: Color(0xFF5C5C5C)),
                    ),
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
