import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'model.dart';
import 'sharedServices.dart';

class DataController extends GetxController {
  var gender = Gender.Male.obs;
  var programming = Set<Programming>().obs;
  var theme = false.obs;
  var controller = TextEditingController().obs;
  var preference = PreferencesServices();

  void getData() async {
    final setting = await preference.getSettings();

    controller.value.text = setting.controller;
    gender.value = setting.gender;
    // ignore: invalid_use_of_protected_member
    programming.value = setting.programming;
    theme.value = setting.theme;
  }

  @override
  void onInit() {
    getData();
    super.onInit();
  }

  void valueSetter() {
    var setting = Setting(
      controller: controller.value.text,
      gender: gender.value,
      // ignore: invalid_use_of_protected_member
      programming: programming.value,
      theme: theme.value,
    );

    preference.setting(setting);
  }
}
