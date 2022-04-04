import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todoapp_1/constant.dart';
import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:todoapp_1/helper/sql_helper.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:todoapp_1/constants/theme.dart';
import 'package:todoapp_1/controllers/theme_controller.dart';

//page
import 'user.dart';
import 'appinfo.dart';
import 'gempa.dart';

//variables
String nama = "Yoga Bayu";
String formatted = "";
DateTime _datePicked = DateTime.now();
List<Map<String, dynamic>> _journals = [];
bool _isLoading = true;
final TextEditingController _titleController = TextEditingController();
final TextEditingController _descriptionController = TextEditingController();
final themeController = Get.find<ThemeController>();
final GlobalKey<FabCircularMenuState> fabKey = GlobalKey();

class Dashboard2 extends StatefulWidget {
  const Dashboard2({Key? key}) : super(key: key);

  @override
  _Dashboard2State createState() => _Dashboard2State();
}

class _Dashboard2State extends State<Dashboard2> {
  void _refreshJournals() async {
    final data = await SQLHelper.getItems();
    setState(() {
      _journals = data;
      _isLoading = false;
    });
  }

  _launchURL() async {
    const url = 'https://juanda.jatim.bmkg.go.id/radar/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'erorrrr slurr $url';
    }
  }

  @override
  void initState() {
    super.initState();
    _refreshJournals();
  }

  void _showForm(int? id) async {
    if (id != null) {
      final existingJournal =
          _journals.firstWhere((element) => element['id'] == id);
      _titleController.text = existingJournal['title'];
      _descriptionController.text = existingJournal['description'];
    }

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          String convertDateTimeDisplay(String date) {
            final DateFormat displayFormater =
                DateFormat('yyyy-MM-dd HH:mm:ss.SSS');
            final DateFormat serverFormater = DateFormat('dd-MM-yyyy');
            final DateTime displayDate = displayFormater.parse(date);
            formatted = serverFormater.format(displayDate);
            return formatted;
          }

          void _showDatePicker() {
            showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2050))
                .then((value) {
              if (value == null) {
                return;
              }
              setState(() {
                _datePicked = value;
                convertDateTimeDisplay(_datePicked.toString());
              });
            });
          }

          return AlertDialog(
            title: new Text("Tambahkan Jadwal :"),
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
                          height: 10,
                        ),
                        TextButton(
                          child: Text(
                            'Pilih Tanggal',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          onPressed: () => _showDatePicker(),
                        ),
                        Text(formatted),
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
        });
      },
    );
  }

  Future<void> _addItem() async {
    await SQLHelper.createItem(
        _titleController.text, _descriptionController.text, formatted);
    _refreshJournals();
  }

  Future<void> _updateItem(int id) async {
    await SQLHelper.updateItem(
        id, _titleController.text, _descriptionController.text, formatted);
    _refreshJournals();
  }

  // Delete an item
  void _deleteItem(int id) async {
    await SQLHelper.deleteItem(id);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Sukses menghapus Jadwal!'),
    ));
    _refreshJournals();
  }

  List<String> _image = ["assets/bg_image.jpg", "assets/bg_dark.jfif"];
  var _index = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(_image[_index % _image.length]),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        // appBar: AppBar(
        //   title: Text('News'),
        // ),
        body: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                Stack(
                  children: [
                    // Image.asset(
                    //   "assets/bg_image.jpg",
                    //   height: MediaQuery.of(context).size.height,
                    //   width: MediaQuery.of(context).size.width,
                    //   fit: BoxFit.cover,
                    // ),
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
                                height:
                                    MediaQuery.of(context).size.height * 0.1,
                              ),
                              Padding(
                                padding: paddingCol,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    GestureDetector(
                                      onTap: () => Get.to(() => User()),
                                      child: CircleAvatar(
                                        backgroundColor:
                                            Colors.greenAccent[400],
                                        radius: 30,
                                        child: Image.asset(
                                            "assets/icon/user1.png"),
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
                                          // color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          decoration: TextDecoration.none),
                                    ),
                                    // Padding(
                                    //   padding: paddingCol,
                                    //   child: Text(
                                    //     "ToDo's :",
                                    //     textAlign: TextAlign.left,
                                    //     style: TextStyle(
                                    //         fontSize: 20,
                                    //         fontWeight: FontWeight.bold),
                                    //   ),
                                    // ),
                                    IconButton(
                                      onPressed: () {
                                        setState(() {
                                          _index++;
                                        });
                                        if (Get.isDarkMode) {
                                          themeController
                                              .changeTheme(Themes.lightTheme);
                                          themeController.saveTheme(false);
                                        } else {
                                          themeController
                                              .changeTheme(Themes.darkTheme);
                                          themeController.saveTheme(true);
                                        }
                                      },
                                      icon: Get.isDarkMode
                                          ? const Icon(
                                              Icons.light_mode_outlined)
                                          : const Icon(
                                              Icons.dark_mode_outlined),
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
                                        width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                2 -
                                            30,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.12,
                                        child: GestureDetector(
                                          onTap: () => Get.to(() => Gempa()),
                                          child: Card(
                                            child: Padding(
                                              padding: EdgeInsets.all(10),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
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
                                                    color: Colors.green,
                                                    width: 1)),
                                          ),
                                        )),
                                    SizedBox(
                                        width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                2 -
                                            30,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.12,
                                        child: GestureDetector(
                                          onTap: () => _launchURL(),
                                          child: Card(
                                            child: Padding(
                                              padding: EdgeInsets.all(10),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
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
                                                    color: Colors.green,
                                                    width: 1)),
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
                                  "ToDo's :",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding: paddingCol,
                                child: Container(
                                  // decoration: BoxDecoration(
                                  //     border: Border.all(color: Colors.blueAccent)),
                                  height:
                                      MediaQuery.of(context).size.height * 0.52,
                                  child: _isLoading
                                      ? const Center(
                                          child: CircularProgressIndicator(),
                                        )
                                      : SingleChildScrollView(
                                          child: ListView.builder(
                                            padding: EdgeInsets.zero,
                                            scrollDirection: Axis.vertical,
                                            shrinkWrap: true,
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            itemCount: _journals.length,
                                            itemBuilder: (context, index) =>
                                                Card(
                                              color: Colors.orange[200],
                                              margin: const EdgeInsets.all(15),
                                              child: ListTile(
                                                  title: Text(_journals[index]
                                                      ['title']),
                                                  subtitle: Text(
                                                      _journals[index]
                                                              ['description'] +
                                                          "\n" +
                                                          _journals[index]
                                                              ['tanggal']),
                                                  trailing: SizedBox(
                                                    width: 100,
                                                    child: Row(
                                                      children: [
                                                        IconButton(
                                                          icon: const Icon(
                                                              Icons.edit),
                                                          onPressed: () =>
                                                              _showForm(
                                                                  _journals[
                                                                          index]
                                                                      ['id']),
                                                        ),
                                                        IconButton(
                                                          icon: const Icon(
                                                              Icons.delete),
                                                          onPressed: () =>
                                                              _deleteItem(
                                                                  _journals[
                                                                          index]
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
          ],
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
              // RawMaterialButton(
              //   onPressed: () {
              //     Get.to(() => User());
              //     fabKey.currentState!.close();
              //   },
              //   shape: CircleBorder(),
              //   padding: const EdgeInsets.all(24.0),
              //   child: Container(
              //     width: MediaQuery.of(context).size.width * 0.11,
              //     child: CircleAvatar(
              //       backgroundColor: Colors.greenAccent[400],
              //       radius: 30,
              //       child: Image.asset("assets/icon/user1.png"),
              //     ),
              //   ),
              // ),
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
      ),
    );
  }
}
