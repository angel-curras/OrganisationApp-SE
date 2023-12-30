import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:organisation_app/controller/course_controller.dart';
import 'package:organisation_app/model/app_user.dart';
import 'package:organisation_app/model/module.dart';
import 'package:organisation_app/settings/app_settings.dart';
import 'package:provider/provider.dart';
import 'package:universal_html/html.dart' show HttpStatus;

class ModuleDetailsPage extends StatelessWidget {
  static final _logger = Logger();
  final Module module;
  final http.Client _httpClient;

  const ModuleDetailsPage(
      {Key? key, required this.module, required http.Client client})
      : _httpClient = client,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    AppUser user = Provider.of<AppSettings>(context).user;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Module: ${module.name}"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildModuleDetailCard('Name', module.name, '📜'),
            _buildModuleDetailCard('ECTS', module.ects.toString(), '🎓'),
            _buildModuleDetailCard('SWS', module.sws.toString(), '🕒'),
            _buildModuleDetailCard(
                'Verantwortlich', module.verantwortlich, '👤'),
            _buildModuleDetailCard('Sprachen', module.sprachen, '🌐'),
            _buildModuleDetailCard('Lehrform', module.lehrform, '📚'),
            _buildModuleDetailCard('Angebot', module.angebot, '🔄'),
            _buildModuleDetailCard('Aufwand', module.aufwand, '⏳'),
            _buildModuleDetailCard(
                'Voraussetzungen', module.voraussetzungen, '🔍'),
            _buildModuleDetailCard('Ziele', module.ziele, '🎯'),
            _buildModuleDetailCard('Inhalt', module.inhalt, '📖'),
            _buildModuleDetailCard(
                'Medien und Methoden', module.medienUndMethoden, '💻'),
            _buildModuleDetailCard('Literatur', module.literatur, '📚'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          _logger.i('Enroll button pressed');
          _logger.i('User: ${user.userName}');
          _logger.i('Module: ${module.name}');
          _logger.i('Module ID: ${module.id}');

          int statusCode =
              await CourseController().enroll(user.userName, module.id);

          if (!context.mounted) return;

          // Create a snackbar to show the result of the enrollment.
          String message;
          MaterialColor backgroundColor;

          switch (statusCode) {
            case HttpStatus.created:
              message = 'Success: Enrolled in "${module.name}"!';
              backgroundColor = Colors.green;
              break;
            case HttpStatus.conflict:
              message = 'You are already enrolled in "${module.name}".';
              backgroundColor = Colors.green;
              break;
            default:
              message = 'Ups. Something went wrong! Please try again later...';
              backgroundColor = Colors.red;
              break;
          } // end of switch

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(message),
              duration: const Duration(seconds: 3),
              backgroundColor: backgroundColor,
            ),
          );

          Navigator.of(context).pop();
        },
        label: const Text('Enroll'),
        icon: const Icon(Icons.add),
        backgroundColor: Colors.red,
      ),
    );
  }

  Widget _buildModuleDetailCard(String title, String content, String emoji) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          leading: Text(emoji,
              style: const TextStyle(
                fontSize: 24,
              )),
          title: Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(content),
          ),
        ),
      ),
    );
  }
}
