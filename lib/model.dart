enum Gender { Male, Female, Others }
enum Programming { Dart, Java, Json, Python }
// enum ThemeValue { Light, Dark }

class Setting {
  String controller;
  Gender gender;
  Set<Programming> programming;
  bool theme;

  Setting({
    required this.controller,
    required this.gender,
    required this.programming,
    required this.theme,
  });
}
