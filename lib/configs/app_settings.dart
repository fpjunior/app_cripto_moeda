import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSettings extends ChangeNotifier {
  late SharedPreferences _prefs;
  Map<String, String> locale = {
    'local': 'pt_BR',
    'name': 'R\$',
  };

  AppSettings() {
    _startSettings();
  }

  _startSettings() async {
    await _startPreferences();
    await _readLocale();
  }

  Future<void> _startPreferences() async {
    _prefs = await SharedPreferences.getInstance();
  }

  _readLocale() async {
    final locale = _prefs.getString('local') ?? 'pt_BR';
    final name = _prefs.getString('name') ?? 'R\$';
    this.locale = {'local': locale, 'name': name};

    notifyListeners();
  }

  Future<void> setLocale(String local, String name) async {
    await _prefs.setString('local', local);
    await _prefs.setString('name', name);
    await _readLocale();
  }
}
