import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'model.dart';
import 'sharedServices.dart';

class DataController extends GetxController {
  var gender = Gender.Male.obs;
  var programming = <Programming>{}.obs;
  var theme = false.obs;
  var controller = TextEditingController().obs;

  var preference = PreferencesServices();

  @override
  void onInit() {
    super.onInit();
    valuesGetter();
  }

  Future<void> valuesSetter() async {
    var setting = Setting(
      controller: controller.value.text,
      gender: gender.value,
      programming: programming,
      theme: theme.value,
    );

    await preference.setSetting(setting);
  }

  Future<void> valuesGetter() async {
    final setting = await preference.getSettings();
    controller.value.text = setting.controller;
    gender.value = setting.gender;
    // ignore: invalid_use_of_protected_member
    programming.value = setting.programming;
    theme.value = setting.theme;
  }
}
