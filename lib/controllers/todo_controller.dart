import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:todoapp_1/helper/sql_helper.dart';

class TodoController extends GetxController {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final datacount = GetStorage();
  String formatted = "";
  String name = "";
  DateTime datePicked = DateTime.now();

  Future<void> addItem(title, desc, formatted) async {
    await SQLHelper.createItem(title, desc, formatted);
  }

  Future<void> updateItem(int id, title, desc, formatted) async {
    await SQLHelper.updateItem(id, title, desc, formatted);
  }

  void deleteItem(BuildContext context, int id) async {
    await SQLHelper.deleteItem(id);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Sukses menghapus Jadwal!'),
    ));
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
              controller: nameController,
              decoration: const InputDecoration(
                  labelText: 'Enter User Name', border: OutlineInputBorder()),
            ),
            ElevatedButton(
                onPressed: () {
                  datacount.write("name", nameController.text);
                  Get.back();
                },
                child: const Text('Confirm'))
          ],
        ));
  }
}
