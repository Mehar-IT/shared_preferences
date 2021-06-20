import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferrences/model.dart';

class PreferencesServices {
  Future<void> setting(Setting setting) async {
    final pref = await SharedPreferences.getInstance();

    await pref.setBool('theme', setting.theme);
    await pref.setString('controller', setting.controller);
    await pref.setInt('gender', setting.gender.index);
    await pref.setStringList('programming',
        setting.programming.map((e) => e.index.toString()).toList());
  }

  Future<Setting> getSettings() async {
    final pref = await SharedPreferences.getInstance();

    final _theme = pref.getBool('theme');
    final _controller = pref.getString('controller');
    final _gender = Gender.values[pref.getInt('gender') ?? 0];
    final _programming = pref
        .getStringList('programming')!
        .map((e) => Programming.values[int.parse(e)])
        .toSet();

    return Setting(
      controller: _controller!,
      gender: _gender,
      programming: _programming,
      theme: _theme!,
    );
  }
}
