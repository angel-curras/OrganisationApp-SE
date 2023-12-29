import 'package:flutter/material.dart';
import 'package:organisation_app/model/app_user.dart';
import 'package:shared_preferences/shared_preferences.dart';

// App preferences as a provider
class AppSettings with ChangeNotifier {
  /* Fields */
  AppUser _user;
  final SharedPreferences _prefs;

  /* Constructor */
  AppSettings(SharedPreferences prefs)
      : _prefs = prefs,
        _user = AppUser.fromJsonString(prefs.getString('user') ?? '{}');

  /* Getters */
  AppUser get user => _user;

  /* Setters */
  Future<void> saveUser(AppUser user) async {
    _user = user;
    await _prefs.setString('user', user.toJsonString());
    notifyListeners();
  } // end of saveUser()

  /* Methods */
  bool hasValidUser() {
    return _user.userName.isNotEmpty;
  } // end of hasValidUser()

  Future<void> clearUser() async {
    await saveUser(AppUser());
  } // end of clearUser()

  static Future<SharedPreferences> getPreferences() async {
    return await SharedPreferences.getInstance();
  } // end of getPreferences()
} // end of class Preferences
