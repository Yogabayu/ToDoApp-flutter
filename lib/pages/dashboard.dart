import 'package:flutter/material.dart';
// import 'package:get/get.dart';
import 'package:todoapp_1/constant.dart';
import 'package:fab_circular_menu/fab_circular_menu.dart';

String nama = "Yoga Bayu";
final GlobalKey<FabCircularMenuState> fabKey = GlobalKey();
final List<String> _todoList = <String>[];
// text field
final TextEditingController _textFieldController = TextEditingController();
final TextEditingController _namaFieldController = TextEditingController();

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
                    children: [
                      Row(),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                                    // child: Text(
                                    //   'user',
                                    //   style: TextStyle(
                                    //       fontSize: 25, color: Colors.white),
                                    // ), //Text
                                    child: Image.asset(
                                        "assets/images/user/user1.png"),
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
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: paddingCol,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 2 -
                                            30,
                                    height: MediaQuery.of(context).size.height *
                                        0.12,
                                    child: GestureDetector(
                                      onTap: () => print("kalender"),
                                      child: Card(
                                        child: Padding(
                                          padding: EdgeInsets.all(10),
                                          child: Row(
                                            children: [
                                              FittedBox(
                                                  fit: BoxFit.scaleDown,
                                                  child: Text(
                                                    "Kalender",
                                                    style:
                                                        TextStyle(fontSize: 12),
                                                  )),
                                            ],
                                          ),
                                        ),
                                        elevation: 8,
                                        shadowColor: Colors.green,
                                        margin: EdgeInsets.only(
                                            left: 20,
                                            right: 0,
                                            top: 20,
                                            bottom: 0),
                                        shape: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: BorderSide(
                                                color: Colors.green, width: 1)),
                                      ),
                                    )),
                                SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 2 -
                                            30,
                                    height: MediaQuery.of(context).size.height *
                                        0.12,
                                    child: GestureDetector(
                                      onTap: () => print("cuaca"),
                                      child: Card(
                                        child: Padding(
                                          padding: EdgeInsets.all(10),
                                          child: Row(
                                            children: [
                                              FittedBox(
                                                  fit: BoxFit.scaleDown,
                                                  child: Text(
                                                    "Cuaca",
                                                    style:
                                                        TextStyle(fontSize: 12),
                                                  )),
                                            ],
                                          ),
                                        ),
                                        elevation: 8,
                                        shadowColor: Colors.green,
                                        margin: EdgeInsets.only(
                                            left: 20,
                                            right: 0,
                                            top: 20,
                                            bottom: 0),
                                        shape: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: BorderSide(
                                                color: Colors.green, width: 1)),
                                      ),
                                    )),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Padding(
                            padding: paddingCol,
                            child: Text(
                              "ToDo : ",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          // Padding(
                          //   padding: const EdgeInsets.all(8.0),
                          //   child: Expanded(
                          //       child: SizedBox(
                          //           height: 50,
                          //           child: ListView(children: _getItems()))),
                          // )
                          Padding(
                              padding: paddingCol,
                              child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Expanded(
                                        child: ListView(children: _getItems()))
                                  ]))
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
      floatingActionButton: Builder(
        builder: (context) => FabCircularMenu(
          key: fabKey,
          // Cannot be `Alignment.center`
          alignment: Alignment.bottomRight,
          ringColor: Colors.blue,
          ringDiameter: 500.0,
          ringWidth: 150.0,
          fabSize: 64.0,
          fabElevation: 8.0,
          fabIconBorder: CircleBorder(),

          fabColor: Colors.white,
          fabOpenIcon: Icon(Icons.add, color: primaryColor),
          fabCloseIcon: Icon(Icons.close, color: primaryColor),
          fabMargin: const EdgeInsets.all(16.0),
          animationDuration: const Duration(milliseconds: 300),
          animationCurve: Curves.easeInOutCirc,
          // onDisplayChange: (isOpen) {
          //   _showSnackBar(context, "The menu is ${isOpen ? "open" : "closed"}");
          // },
          children: <Widget>[
            RawMaterialButton(
              onPressed: () {
                _displayDialog(context);
              },
              shape: CircleBorder(),
              padding: const EdgeInsets.all(24.0),
              child: Icon(Icons.add_box_rounded, color: Colors.white),
            ),
            // RawMaterialButton(
            //   onPressed: () {
            //     _showSnackBar(context, "You pressed 2");
            //   },
            //   shape: CircleBorder(),
            //   padding: const EdgeInsets.all(24.0),
            //   child: Icon(Icons.looks_two, color: Colors.white),
            // ),
            // RawMaterialButton(
            //   onPressed: () {
            //     _showSnackBar(context, "You pressed 3");
            //   },
            //   shape: CircleBorder(),
            //   padding: const EdgeInsets.all(24.0),
            //   child: Icon(Icons.looks_3, color: Colors.white),
            // ),
            RawMaterialButton(
              onPressed: () {
                print("1212");
                fabKey.currentState!.close();
              },
              shape: CircleBorder(),
              padding: const EdgeInsets.all(24.0),
              child: Icon(Icons.looks_4, color: Colors.white),
            )
          ],
        ),
      ),
    );
  }

  // void _showSnackBar(BuildContext context, String message) {
  //   // ignore: deprecated_member_use
  //   Scaffold.of(context).showSnackBar(SnackBar(
  //     content: Text(message),
  //     duration: const Duration(milliseconds: 1000),
  //   ));
  // }

  void _addTodoItem(String title) async {
    // Wrapping it inside a set state will notify
    // the app that the state has changed
    setState(() {
      _todoList.add(title);
    });
    _textFieldController.clear();
  }

  // this Generate list of item widgets
  Widget _buildTodoItem(String title) {
    return ListTile(title: Text(title));
  }

  // display a dialog for the user to enter items
  Future<void> _displayDialog(BuildContext context) async {
    // alter the app state to show a dialog
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Add a task to your list'),
            content: TextField(
              controller: _textFieldController,
              decoration: const InputDecoration(hintText: 'Enter task here'),
            ),
            actions: <Widget>[
              // add button
              TextButton(
                child: const Text('ADD'),
                onPressed: () {
                  Navigator.of(context).pop();
                  _addTodoItem(_textFieldController.text);
                },
              ),
              // Cancel button
              TextButton(
                child: const Text('CANCEL'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  // iterates through our todo list title
  List<Widget> _getItems() {
    final List<Widget> _todoWidgets = <Widget>[];
    for (String title in _todoList) {
      _todoWidgets.add(_buildTodoItem(title));
    }
    return _todoWidgets;
  }
}
