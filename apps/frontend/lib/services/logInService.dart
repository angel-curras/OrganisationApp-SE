import 'package:http/http.dart' as http;
import 'package:organisation_app/services/backend.dart';

class LogInService {
  final Backend? backend;
  final http.Client? client;
  bool _authentication = false;

  LogInService({this.backend, this.client});

  Future<bool> authentication(String name) async {
    if (backend == null || client == null) {
      throw Exception("Backend or client not initialized");
    }
    //convert Future<List<String>> to List<String>
    List<String> users = await backend!.getRequest(client!, "users/usernames");
    if (users.contains(name)) {
      return true;
    } else {
      return false;
    }
  }
}
