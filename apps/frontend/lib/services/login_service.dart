import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:organisation_app/controller/user_controller.dart';
import 'package:organisation_app/model/app_user.dart';
import 'package:organisation_app/settings/app_settings.dart';

class LoginService {
  final Logger _logger = Logger();
  final UserController _userController;
  final AppSettings _appSettings;

  LoginService({
    required http.Client client,
    required AppSettings appSettings,
  })  : _appSettings = appSettings,
        _userController = UserController(client: client);

  Future<bool> login(String username) async {
    try {
      _logger.i('Logging in: $username');
      AppUser user = await _userController.getUser(username);
      _logger.i('User found: $user');
      await _appSettings.saveUser(user);
      return true;
    } catch (exception) {
      _logger.i('User not found: $username');
      return false;
    } // end of try-catch
  } // end of login()

  Future<void> logout() async {
    _logger.i('Logging out...');
    await _appSettings.clearUser();
  } // end of logout()
} // end of class LoginService
