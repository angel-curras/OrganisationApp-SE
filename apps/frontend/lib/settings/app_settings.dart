import 'package:flutter/material.dart';
import 'package:organisation_app/model/app_user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSettings with ChangeNotifier {
  static final AppSettings _instance = AppSettings._internal();
  late SharedPreferences _storedSettings;
  AppUser _user = AppUser();

  factory AppSettings() {
    return _instance;
  } // factory AppSettings

  AppSettings._internal() {
    _loadSettings();
  } // AppSettings._internal

  // Settings.

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
    await loadLoginInfos();
  } // _loadSettings

  Future<void> saveSettings() async {
    await saveLoginInfos();
    notifyListeners();
  } // _saveSettings

  bool isUserLoggedIn() {
    return _user.userName != '';
  } // end of isUserLoggedIn()

  Future<void> loadLoginInfos() async {
    String userName = _storedSettings.getString('user_name') ?? '';
    String fullName = _storedSettings.getString('full_name') ?? '';
    String userType = _storedSettings.getString('user_type') ?? '';
    _user = AppUser(userName: userName, fullName: fullName, userType: userType);
    notifyListeners();
  } // _loadSettings

  Future<void> saveLoginInfos() async {
    await _storedSettings.setString('user_name', _user.userName);
    await _storedSettings.setString('full_name', _user.fullName);
    await _storedSettings.setString('user_type', _user.userType);
    notifyListeners();
  } // _saveSettings
} // class AppSettings
