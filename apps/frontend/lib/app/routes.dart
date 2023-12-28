import 'package:http/http.dart' as http;
import 'package:organisation_app/pages/chatgpt/chatgpt_page.dart';
import 'package:organisation_app/pages/courses/courses_list.dart';
import 'package:organisation_app/pages/home/home_page.dart';
import 'package:organisation_app/pages/login/initialization_page.dart';
import 'package:organisation_app/pages/login/login_page.dart';
import 'package:organisation_app/pages/moodle/moodle_page.dart';
import 'package:organisation_app/pages/primuss/primuss_page.dart';
import 'package:organisation_app/pages/todos/todos_page.dart';

var appRoutes = {
  '/init': (context) => const InitializationPage(),
  '/home': (context) => MyCoursesPage(client: http.Client()),
  '/login': (context) => LoginPage(),
  '/courses': (context) => const CoursesPage(),
  '/todos': (context) => TodosPage(),
  '/moodle': (context) => const MoodlePage(),
  '/chatgpt': (context) => const ChatGptPage(),
  '/primuss': (context) => const PrimussPage(),
};
