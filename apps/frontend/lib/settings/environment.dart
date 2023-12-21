import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static String get fileName {
    if (kReleaseMode) {
      return 'environments/.env.prod';
    }

    return 'environments/.env.dev';
  }

  static String get apiUrl {
    return dotenv.get('API_URL', fallback: 'http://localhost:8080');
  }
}
