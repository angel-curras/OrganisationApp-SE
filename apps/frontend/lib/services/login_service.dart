import 'package:organisation_app/controller/user_controller.dart';

import '../model/app_user.dart';
import '../settings/app_settings.dart';

class LoginService {
  UserController userController = UserController();
  AppSettings appSettings = AppSettings();

  Future<bool> login(String username) async {
    try {
      AppUser user = await userController.getUser(username);
      appSettings.rememberUser(user);
      return true;
    } catch (e) {
      return false;
    } // end of try-catch
  } // end of login()

  Future<void> logout() async {
    await appSettings.forgetUser();
  } // end of logout()
} // end of class LoginService
