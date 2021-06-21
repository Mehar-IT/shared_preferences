import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferrences/controller.dart';
import 'package:shared_preferrences/model.dart';

DataController obj = Get.put(DataController());
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Obx(() => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Shared Preference',
          theme: obj.theme.value ? ThemeData.dark() : ThemeData.light(),
          home: Scaffold(
            appBar: AppBar(
              title: Text('Shared Preference'),
            ),
            body: MyData(),
          ),
        ));
  }
}

class MyData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Obx(
      () => Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: obj.controller.value,
            ),
          ),
          RadioListTile(
              title: Text('Male'),
              value: Gender.Male,
              groupValue: obj.gender.value,
              onChanged: (value) {
                obj.gender.value = value as Gender;
              }),
          RadioListTile(
              title: Text('Female'),
              value: Gender.Female,
              groupValue: obj.gender.value,
              onChanged: (value) {
                obj.gender.value = value as Gender;
              }),
          RadioListTile(
              title: Text('Others'),
              value: Gender.Others,
              groupValue: obj.gender.value,
              onChanged: (value) {
                obj.gender.value = value as Gender;
              }),
          CheckboxListTile(
              title: Text('Dart'),
              value: obj.programming.contains(Programming.Dart),
              onChanged: (_) {
                obj.programming.contains(Programming.Dart)
                    ? obj.programming.remove(Programming.Dart)
                    : obj.programming.add(Programming.Dart);
              }),
          CheckboxListTile(
              title: Text('Java'),
              value: obj.programming.contains(Programming.Java),
              onChanged: (_) {
                obj.programming.contains(Programming.Java)
                    ? obj.programming.remove(Programming.Java)
                    : obj.programming.add(Programming.Java);
              }),
          CheckboxListTile(
              title: Text('Json'),
              value: obj.programming.contains(Programming.Json),
              onChanged: (_) {
                obj.programming.contains(Programming.Json)
                    ? obj.programming.remove(Programming.Json)
                    : obj.programming.add(Programming.Json);
              }),
          CheckboxListTile(
              title: Text('Python'),
              value: obj.programming.contains(Programming.Python),
              onChanged: (_) {
                obj.programming.contains(Programming.Python)
                    ? obj.programming.remove(Programming.Python)
                    : obj.programming.add(Programming.Python);
              }),
          SwitchListTile(
              title: Text('Theme Mode'),
              value: obj.theme.value,
              onChanged: (value) {
                obj.theme.value = value;
              }),
          TextButton(
              onPressed: () => obj.valuesSetter(), child: Text('Save settings'))
        ],
      ),
    ));
  }
}
