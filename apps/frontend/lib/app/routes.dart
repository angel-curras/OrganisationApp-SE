import 'package:http/http.dart' as http;
import 'package:organisation_app/pages/chatgpt/chatgpt_page.dart';
import 'package:organisation_app/pages/home/home_page.dart';
import 'package:organisation_app/pages/login/initialization_page.dart';
import 'package:organisation_app/pages/login/login_page.dart';
import 'package:organisation_app/pages/modules/modules_list.dart';
import 'package:organisation_app/pages/moodle/moodle_page.dart';
import 'package:organisation_app/pages/primuss/primuss_page.dart';
import 'package:organisation_app/pages/todos/todos_page.dart';

http.Client client = http.Client();

var appRoutes = {
  '/init': (context) => InitializationPage(),
  '/my_courses': (context) => MyCoursesPage(),
  '/login': (context) => LoginPage(
        client: client,
      ),
  '/modules': (context) => const CoursesPage(),
  '/todos': (context) => TodosPage(
        client: client,
      ),
  '/moodle': (context) => MoodlePage(),
  '/chatgpt': (context) => ChatGptPage(),
  '/primuss': (context) => PrimussPage(),
};
