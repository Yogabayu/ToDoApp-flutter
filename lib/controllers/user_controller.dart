import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:todoapp_1/model/user_model.dart';

class UserController extends GetxController {
  final user = User().obs;
  final editingController = TextEditingController();

  updateUser() {
    user.update((val) {
      val?.userName = editingController.text;
    });
  }
}
