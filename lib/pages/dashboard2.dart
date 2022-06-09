import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todoapp_1/constant.dart';
import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:todoapp_1/controllers/todo_controller.dart';
import 'package:todoapp_1/helper/sql_helper.dart';
import 'package:intl/intl.dart';
import 'package:todoapp_1/constants/theme.dart';
import 'package:todoapp_1/controllers/theme_controller.dart';
import 'appinfo.dart';

List<Map<String, dynamic>> _journals = [];
bool _isLoading = true;

class Dashboard2 extends StatefulWidget {
  Dashboard2({Key? key}) : super(key: key);

  @override
  _Dashboard2State createState() => _Dashboard2State();
}

class _Dashboard2State extends State<Dashboard2> {
  TodoController todoController = Get.put(TodoController());
  final themeController = Get.find<ThemeController>();
  GlobalKey<FabCircularMenuState> fabKey = GlobalKey<FabCircularMenuState>();
  List<String> _image = ["assets/bg_image.jpg", "assets/bg_dark.jfif"];
  var _index = 0;

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
    _refreshJournals();
    if (todoController.datacount.read('_name') != null) {
      todoController.name = todoController.datacount.read('_name');
    }
  }

  void showname() {
    Get.defaultDialog(
        title: "Tambah User Name",
        titleStyle: TextStyle(color: Colors.white),
        middleTextStyle: TextStyle(color: Colors.white),
        // textConfirm: "Simpan",
        cancelTextColor: Colors.white,
        confirmTextColor: Colors.white,
        buttonColor: Colors.red,
        barrierDismissible: false,
        radius: 50,
        content: Column(
          children: [
            TextField(
              controller: todoController.nameController,
              decoration: const InputDecoration(
                  labelText: 'Enter User Name', border: OutlineInputBorder()),
            ),
            ElevatedButton(
                onPressed: () {
                  todoController.datacount
                      .write("name", todoController.nameController.text);

                  _refreshJournals();
                  Get.back();
                },
                child: const Text('Confirm'))
          ],
        ));
  }

  void _showForm(int? id) async {
    if (id != null) {
      final existingJournal =
          _journals.firstWhere((element) => element['id'] == id);
      todoController.titleController.text = existingJournal['title'];
      todoController.descriptionController.text =
          existingJournal['description'];
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
            todoController.formatted = serverFormater.format(displayDate);
            return todoController.formatted;
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
                todoController.datePicked = value;
                convertDateTimeDisplay(todoController.datePicked.toString());
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
                          controller: todoController.titleController,
                          decoration: const InputDecoration(hintText: 'Judul'),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextField(
                          controller: todoController.descriptionController,
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
                        Text(todoController.formatted),
                        const SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            // Save new journal
                            if (id == null) {
                              await todoController.addItem(
                                  todoController.titleController.text,
                                  todoController.descriptionController.text,
                                  todoController.formatted);
                              _refreshJournals();
                            }

                            if (id != null) {
                              await todoController.updateItem(
                                  id,
                                  todoController.titleController.text,
                                  todoController.descriptionController.text,
                                  todoController.formatted);
                              _refreshJournals();
                            }

                            // Clear the text fields
                            todoController.titleController.text = '';
                            todoController.descriptionController.text = '';

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
        body: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                Stack(
                  children: [
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
                                height: height * 0.05,
                              ),
                              Padding(
                                padding: paddingCol,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    GestureDetector(
                                      onTap: () => {showname()},
                                      child: CircleAvatar(
                                        backgroundColor:
                                            Colors.greenAccent[400],
                                        radius: 30,
                                        child: Image.asset(
                                            "assets/icon/user1.png"),
                                      ),
                                    ),
                                    defaultSeparator2,
                                    if (todoController.datacount.read('name') ==
                                        null)
                                      Text(
                                        "Hi. " + todoController.name,
                                        style: TextStyle(
                                            fontFamily: "RobotoMono",
                                            fontSize: 26,
                                            fontWeight: FontWeight.bold,
                                            decoration: TextDecoration.none),
                                      )
                                    else
                                      Text(
                                        "Hi. " +
                                            todoController.datacount
                                                .read('name'),
                                        style: TextStyle(
                                            fontFamily: "RobotoMono",
                                            fontSize: 26,
                                            fontWeight: FontWeight.bold,
                                            decoration: TextDecoration.none),
                                      ),
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
                                  height: height * 0.52,
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
                                                            onPressed: () {
                                                              todoController
                                                                  .deleteItem(
                                                                      context,
                                                                      _journals[
                                                                              index]
                                                                          [
                                                                          'id']);
                                                              _refreshJournals();
                                                            }),
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
            ringWidth: width * 0.15,
            fabSize: 64.0,
            fabElevation: 8.0,
            fabIconBorder: CircleBorder(),

            fabColor: Colors.white,
            fabOpenIcon: Icon(Icons.add, color: primaryColor),
            fabCloseIcon: Icon(Icons.close, color: primaryColor),
            fabMargin: const EdgeInsets.all(16.0),
            animationDuration: const Duration(milliseconds: 300),
            animationCurve: Curves.easeInOutCirc,
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
                  Get.to(() => Appinfo());
                  fabKey.currentState!.close();
                },
                shape: CircleBorder(),
                padding: const EdgeInsets.all(24.0),
                child: Container(
                  width: width * 0.11,
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
