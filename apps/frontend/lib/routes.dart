import 'package:organisation_app/pages/about/about_page.dart';
import 'package:organisation_app/pages/calendar/calendar_page.dart';
import 'package:organisation_app/pages/chatgpt/chatgpt_page.dart';
import 'package:organisation_app/pages/courses/courses_list.dart';
import 'package:organisation_app/pages/home/home_page.dart';
import 'package:organisation_app/pages/login/login_page.dart';
import 'package:organisation_app/pages/moodle/moodle_page.dart';
import 'package:organisation_app/pages/progress/progress_page.dart';
import 'package:organisation_app/pages/todos/todos_page.dart';

var appRoutes = {
  '/': (context) => HomePage(),
  '/login': (context) => const LoginPage(),
  '/courses': (context) => const CoursesPage(),
  '/calendar': (context) => const CalendarPage(),
  '/todos': (context) => const TodosPage(),
  '/progress': (context) => const ProgressPage(),
  '/moodle': (context) => const MoodlePage(),
  '/chatgpt': (context) => const ChatGptPage(),
  '/about': (context) => const AboutPage(),
};
