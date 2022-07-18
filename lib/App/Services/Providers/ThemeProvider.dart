import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier{

  final String key = "theme";
  SharedPreferences? prefs;
  bool? _darkTheme;
  bool? get darkTheme => _darkTheme;

  ThemeProvider(){
    _darkTheme = true;
    _loadFromPrefs();
  }
  light(){
    _darkTheme = false;
    _saveToPrefs();
    notifyListeners();
  }
  dark(){
    _darkTheme = true;
    _saveToPrefs();
    notifyListeners();
  }

  _initPrefs() async{
    if(prefs == null)
      prefs = await SharedPreferences.getInstance();
  }

  _loadFromPrefs() async{
    await _initPrefs();
    _darkTheme = prefs?.getBool(key) ?? true;
    notifyListeners();
  }

  _saveToPrefs() async{
    await _initPrefs();
    prefs?.setBool(key, _darkTheme!);
  }
}