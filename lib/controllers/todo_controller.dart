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
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(const SnackBar(
        content: Text('Sukses menghapus Jadwal!'),
      ));
  }
}
