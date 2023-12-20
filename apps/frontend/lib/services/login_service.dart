import 'package:organisation_app/controller/user_controller.dart';

import '../model/app_user.dart';
import '../settings/app_settings.dart';

class LoginService {
  UserController userController = UserController();
  AppSettings appSettings = AppSettings();

  Future<bool> login(String username) async {
    try {
      AppUser user = await userController.getUser(username);
      appSettings.user = user;
      await appSettings.saveSettings();
      return true;
    } catch (e) {
      return false;
    } // end of try-catch
  } // end of login()

  Future<void> logout() async {
    appSettings.user = AppUser(userName: "", userType: "", fullName: "");
  } // end of logout()
} // end of class LoginService
