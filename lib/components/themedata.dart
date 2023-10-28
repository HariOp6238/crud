import 'package:crud/components/theme.dart';
import 'package:flutter/material.dart';

class Themeprovider with ChangeNotifier {
  ThemeData _themedata = lightmode;

  ThemeData get themedata => _themedata;

  set themedata(ThemeData themeData) {
    _themedata = themeData;
    notifyListeners();
  }

  void toggletheme() {
    if (_themedata == lightmode) {
      themedata = darkmode;
    } else {
      themedata = lightmode;
    }
  }
}
