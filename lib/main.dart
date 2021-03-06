import 'package:flutter/material.dart';
import 'package:shared_preferrences/model.dart';
import 'package:shared_preferrences/sharedServices.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool? _theme;

  get() async {
    Setting obj = await PreferencesServices().getSettings();
    setState(() {
      _theme = obj.theme;
    });
  }

  @override
  void initState() {
    get();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _theme != null
        ? MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Shared Preference',
            theme: _theme! ? ThemeData.dark() : ThemeData.light(),
            home: Scaffold(
              appBar: AppBar(
                title: Text('Shared Preference'),
              ),
              body: MyData(
                thememode: (value) {
                  setState(() {
                    _theme = value;
                  });
                },
              ),
            ),
          )
        : SingleChildScrollView();
  }
}

class MyData extends StatefulWidget {
  final ValueSetter thememode;
  const MyData({
    Key? key,
    required this.thememode,
  }) : super(key: key);

  @override
  _MyDataState createState() => _MyDataState();
}

class _MyDataState extends State<MyData> {
  var _preference = PreferencesServices();

  TextEditingController _controller = TextEditingController();
  Gender? _gender;
  Set<Programming>? _programming;
  bool? _theme;

  Future<void> getData() async {
    final setting = await _preference.getSettings();
    setState(() {
      _controller.text = setting.controller;
      _gender = setting.gender;
      _programming = setting.programming;
      _theme = setting.theme;
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return _theme != null
        ? SingleChildScrollView(
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
                        _gender = value as Gender;
                      });
                    }),
                RadioListTile(
                    title: Text('Female'),
                    value: Gender.Female,
                    groupValue: _gender,
                    onChanged: (value) {
                      setState(() {
                        _gender = value as Gender;
                      });
                    }),
                RadioListTile(
                    title: Text('Others'),
                    value: Gender.Others,
                    groupValue: _gender,
                    onChanged: (value) {
                      setState(() {
                        _gender = value as Gender;
                      });
                    }),
                CheckboxListTile(
                    title: Text('Dart'),
                    value: _programming!.contains(Programming.Dart),
                    onChanged: (_) {
                      setState(() {
                        _programming!.contains(Programming.Dart)
                            ? _programming!.remove(Programming.Dart)
                            : _programming!.add(Programming.Dart);
                      });
                    }),
                CheckboxListTile(
                    title: Text('Java'),
                    value: _programming!.contains(Programming.Java),
                    onChanged: (_) {
                      setState(() {
                        _programming!.contains(Programming.Java)
                            ? _programming!.remove(Programming.Java)
                            : _programming!.add(Programming.Java);
                      });
                    }),
                CheckboxListTile(
                    title: Text('Json'),
                    value: _programming!.contains(Programming.Json),
                    onChanged: (_) {
                      setState(() {
                        _programming!.contains(Programming.Json)
                            ? _programming!.remove(Programming.Json)
                            : _programming!.add(Programming.Json);
                      });
                    }),
                CheckboxListTile(
                    title: Text('Python'),
                    value: _programming!.contains(Programming.Python),
                    onChanged: (_) {
                      setState(() {
                        _programming!.contains(Programming.Python)
                            ? _programming!.remove(Programming.Python)
                            : _programming!.add(Programming.Python);
                      });
                    }),
                SwitchListTile(
                    title: Text('Theme Mode'),
                    value: _theme!,
                    onChanged: (value) {
                      setState(() {
                        _theme = value;
                        widget.thememode(_theme);
                      });
                    }),
                TextButton(onPressed: _onPressed, child: Text('Save settings'))
              ],
            ),
          )
        : Center(child: CircularProgressIndicator());
  }

  Future<void> _onPressed() async {
    var setting = Setting(
      controller: _controller.text,
      gender: _gender!,
      programming: _programming!,
      theme: _theme!,
    );

    await _preference.setting(setting);
  }
}
