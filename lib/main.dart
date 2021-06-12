import 'package:flutter/material.dart';
import 'package:shared_preferrences/model.dart';
import 'package:shared_preferrences/sharedServices.dart';
import 'package:get/get.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Shared Preference',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Shared Preference'),
        ),
        body: MyData(),
      ),
    );
  }
}

class MyData extends StatefulWidget {
  @override
  _MyDataState createState() => _MyDataState();
}

class _MyDataState extends State<MyData> {
  @override
  void initState() {
    getData();
    super.initState();
  }

  var _preference = PreferencesServices();
  var _gender = Gender.Male;
  var _programming = Set<Programming>();
  var _theme = false;
  TextEditingController _controller = TextEditingController();

  void getData() async {
    final setting = await _preference.getSettings();
    setState(() {
      _controller.text = setting.controller;
      _gender = setting.gender;
      _programming = setting.programming;
      _theme = setting.theme;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _controller,
            ),
          ),
          RadioListTile(
              title: Text('Male'),
              value: Gender.Male,
              groupValue: _gender,
              onChanged: (value) {
                setState(() {
                  _gender = value;
                });
              }),
          RadioListTile(
              title: Text('Female'),
              value: Gender.Female,
              groupValue: _gender,
              onChanged: (value) {
                setState(() {
                  _gender = value;
                });
              }),
          RadioListTile(
              title: Text('Others'),
              value: Gender.Others,
              groupValue: _gender,
              onChanged: (value) {
                setState(() {
                  _gender = value;
                });
              }),
          CheckboxListTile(
              title: Text('Dart'),
              value: _programming.contains(Programming.Dart),
              onChanged: (_) {
                setState(() {
                  _programming.contains(Programming.Dart)
                      ? _programming.remove(Programming.Dart)
                      : _programming.add(Programming.Dart);
                });
              }),
          CheckboxListTile(
              title: Text('Java'),
              value: _programming.contains(Programming.Java),
              onChanged: (_) {
                setState(() {
                  _programming.contains(Programming.Java)
                      ? _programming.remove(Programming.Java)
                      : _programming.add(Programming.Java);
                });
              }),
          CheckboxListTile(
              title: Text('Json'),
              value: _programming.contains(Programming.Json),
              onChanged: (_) {
                setState(() {
                  _programming.contains(Programming.Json)
                      ? _programming.remove(Programming.Json)
                      : _programming.add(Programming.Json);
                });
              }),
          CheckboxListTile(
              title: Text('Python'),
              value: _programming.contains(Programming.Python),
              onChanged: (_) {
                setState(() {
                  _programming.contains(Programming.Python)
                      ? _programming.remove(Programming.Python)
                      : _programming.add(Programming.Python);
                });
              }),
          SwitchListTile(
              title: Text('Theme Mode'),
              value: _theme,
              onChanged: (value) {
                setState(() {
                  _theme = value;
                  _theme
                      ? Get.changeThemeMode(ThemeMode.dark)
                      : Get.changeThemeMode(ThemeMode.light);
                });
              }),
          TextButton(onPressed: _onPressed, child: Text('Save settings'))
        ],
      ),
    );
  }

  void _onPressed() {
    var setting = Setting(
        controller: _controller.text,
        gender: _gender,
        programming: _programming,
        theme: _theme);

    _preference.setting(setting);
  }
}
