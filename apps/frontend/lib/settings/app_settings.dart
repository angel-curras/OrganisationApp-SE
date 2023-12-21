import 'package:flutter/material.dart';
import 'package:organisation_app/model/app_user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSettings with ChangeNotifier {
  // Singleton
  static final AppSettings _instance = AppSettings._internal();

  // Settings.
  AppUser _user = AppUser();

  // Getters
  AppUser get user => _user;

  // Setters
  set user(AppUser user) {
    _user = user;
    notifyListeners();
  } // end of user setter

  // Singleton constructor
  factory AppSettings() {
    return _instance;
  } // factory AppSettings

  // Instance constructor
  AppSettings._internal(); // AppSettings._internal

  // Getters
  Future<bool> hasUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    AppUser user = AppUser.fromJsonString(prefs.getString('user') ?? '{}');
    this.user = user;
    notifyListeners();
    return user.userName.isNotEmpty;
  } // end of isUserLoggedIn()

  Future<void> rememberUser(AppUser user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('user', user.toJsonString());
    this.user = user;
    saveAllSettings();
  } // end of rememberUser()

  Future<void> forgetUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('user', '{}');
    _user = AppUser();
    saveAllSettings();
  } // end of forgetUser()

  Future<void> saveAllSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('user', _user.toJsonString());
    notifyListeners();
  } // end of saveAllSettings()
} // class AppSettings
