import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:todoapp_1/constant.dart';
import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:todoapp_1/helper/sql_helper.dart';
import 'package:intl/intl.dart';

//page
import 'radar.dart';
import 'user.dart';
import 'appinfo.dart';
import 'gempa.dart';

String nama = "Yoga Bayu";
final GlobalKey<FabCircularMenuState> fabKey = GlobalKey();

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
// All journals
  List<Map<String, dynamic>> _journals = [];

  bool _isLoading = true;
  // This function is used to fetch all data from the database
  void _refreshJournals() async {
    final data = await SQLHelper.getItems();
    setState(() {
      _journals = data;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();

    _refreshJournals(); // Loading the diary when the app starts
  }

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  // This function will be triggered when the floating button is pressed
  // It will also be triggered when you want to update an item
  void _showForm(int? id) async {
    if (id != null) {
      // id == null -> create new item
      // id != null -> update an existing item
      final existingJournal =
          _journals.firstWhere((element) => element['id'] == id);
      _titleController.text = existingJournal['title'];
      _descriptionController.text = existingJournal['description'];
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Add Todo :"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.all(15),
                width: double.infinity,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      TextField(
                        controller: _titleController,
                        decoration: const InputDecoration(hintText: 'Judul'),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextField(
                        controller: _descriptionController,
                        decoration:
                            const InputDecoration(hintText: 'Deskripsi'),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          // Save new journal
                          if (id == null) {
                            await _addItem();
                          }

                          if (id != null) {
                            await _updateItem(id);
                          }

                          // Clear the text fields
                          _titleController.text = '';
                          _descriptionController.text = '';

                          // Close the bottom sheet
                          Navigator.of(context).pop();
                        },
                        child: Text(id == null ? 'Tambah Baru' : 'Update'),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

// Insert a new journal to the database
  Future<void> _addItem() async {
    await SQLHelper.createItem(
        _titleController.text, _descriptionController.text);
    _refreshJournals();
  }

  // Update an existing journal
  Future<void> _updateItem(int id) async {
    await SQLHelper.updateItem(
        id, _titleController.text, _descriptionController.text);
    _refreshJournals();
  }

  // Delete an item
  void _deleteItem(int id) async {
    await SQLHelper.deleteItem(id);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Successfully deleted a journal!'),
    ));
    _refreshJournals();
  }

  //pilih tanggal
  DateTime selectedDate = DateTime.now();
  DateFormat dateFormat = DateFormat("yyyy-MM-dd");

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
                          Padding(
                            padding: paddingCol,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                GestureDetector(
                                  onTap: () => Get.to(() => User()),
                                  child: CircleAvatar(
                                    backgroundColor: Colors.greenAccent[400],
                                    radius: 30,
                                    child: Image.asset("assets/icon/user1.png"),
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  "Hi. " + nama,
                                  style: TextStyle(
                                      fontFamily: "RobotoMono",
                                      fontSize: 26,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      decoration: TextDecoration.none),
                                ),
                                defaultSeparator,
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
                                      onTap: () => Get.to(() => Gempa()),
                                      child: Card(
                                        child: Padding(
                                          padding: EdgeInsets.all(10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              FittedBox(
                                                  fit: BoxFit.contain,
                                                  child: Image.asset(
                                                      "assets/icon/earthquake.png",
                                                      width: 30,
                                                      height: 30)),
                                              FittedBox(
                                                  fit: BoxFit.scaleDown,
                                                  child: Text(
                                                    "Info Gempa",
                                                    style: TextStyle(
                                                        fontFamily:
                                                            "Merriweather-Bold"),
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
                                      onTap: () => Get.to(() => Radar()),
                                      child: Card(
                                        child: Padding(
                                          padding: EdgeInsets.all(10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              FittedBox(
                                                  fit: BoxFit.contain,
                                                  child: Image.asset(
                                                      "assets/icon/cloudy-day.png",
                                                      width: 30,
                                                      height: 30)),
                                              FittedBox(
                                                  fit: BoxFit.fitWidth,
                                                  child: Text(
                                                    "Radar Cuaca",
                                                    style: TextStyle(
                                                        fontFamily:
                                                            "Merriweather-Bold"),
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
                              "ToDo's " +
                                  "${selectedDate.toLocal()}".split(' ')[0] +
                                  " : ",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: paddingCol,
                            child: Container(
                              // decoration: BoxDecoration(
                              //     border: Border.all(color: Colors.blueAccent)),
                              height: MediaQuery.of(context).size.height * 0.52,
                              child: _isLoading
                                  ? const Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : SingleChildScrollView(
                                      child: ListView.builder(
                                        padding: EdgeInsets.zero,
                                        scrollDirection: Axis.vertical,
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemCount: _journals.length,
                                        itemBuilder: (context, index) => Card(
                                          color: Colors.orange[200],
                                          margin: const EdgeInsets.all(15),
                                          child: ListTile(
                                              title: Text(
                                                  _journals[index]['title']),
                                              subtitle: Text(_journals[index]
                                                  ['description']),
                                              trailing: SizedBox(
                                                width: 100,
                                                child: Row(
                                                  children: [
                                                    IconButton(
                                                      icon: const Icon(
                                                          Icons.edit),
                                                      onPressed: () =>
                                                          _showForm(
                                                              _journals[index]
                                                                  ['id']),
                                                    ),
                                                    IconButton(
                                                      icon: const Icon(
                                                          Icons.delete),
                                                      onPressed: () =>
                                                          _deleteItem(
                                                              _journals[index]
                                                                  ['id']),
                                                    ),
                                                  ],
                                                ),
                                              )),
                                        ),
                                      ),
                                    ),
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
      ),
      floatingActionButton: Builder(
        builder: (context) => FabCircularMenu(
          key: fabKey,
          // Cannot be `Alignment.center`
          alignment: Alignment.bottomRight,
          ringColor: Colors.blue,
          ringDiameter: 270.0,
          ringWidth: MediaQuery.of(context).size.width * 0.15,
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
                _showForm(null);
                fabKey.currentState!.close();
              },
              shape: CircleBorder(),
              padding: const EdgeInsets.all(24.0),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.11,
                child: CircleAvatar(
                  backgroundColor: Colors.orangeAccent[400],
                  radius: 30,
                  child: Image.asset("assets/icon/new-task.png"),
                ),
              ),
            ),
            RawMaterialButton(
              onPressed: () {
                Get.to(() => User());
                fabKey.currentState!.close();
              },
              shape: CircleBorder(),
              padding: const EdgeInsets.all(24.0),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.11,
                child: CircleAvatar(
                  backgroundColor: Colors.greenAccent[400],
                  radius: 30,
                  child: Image.asset("assets/icon/user1.png"),
                ),
              ),
            ),
            RawMaterialButton(
              onPressed: () {
                Get.to(() => Appinfo());
                fabKey.currentState!.close();
              },
              shape: CircleBorder(),
              padding: const EdgeInsets.all(24.0),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.11,
                child: CircleAvatar(
                  backgroundColor: Colors.greenAccent[400],
                  radius: 30,
                  child: Image.asset("assets/icon/info.png"),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
