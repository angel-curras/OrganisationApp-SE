import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:organisation_app/model/app_user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSettings with ChangeNotifier {
  late SharedPreferences _storedSettings;

  AppSettings() {
    _loadSettings();
  }

  // Settings.
  AppUser _user = AppUser();

  // Getters
  AppUser get user => _user;

  // Setters
  set user(AppUser value) {
    _user = value;
    saveSettings();
    notifyListeners();
  }

  Future<void> _loadSettings() async {
    _storedSettings = await SharedPreferences.getInstance();
    String json = _storedSettings.getString('user') ?? '';
    final Map<String, dynamic> jsonMap = jsonDecode(json);
    _user = AppUser.fromJson(jsonMap);
    notifyListeners();
  } // _loadSettings

  Future<void> saveSettings() async {
    await _storedSettings.setString('user', jsonEncode(_user.toJson()));
    notifyListeners();
  } // _saveSettings

  bool isUserLoggedIn() {
    return _user.userName != '';
  } // end of isUserLoggedIn()
} // class AppSettings
