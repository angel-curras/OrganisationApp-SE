import 'package:flutter/material.dart';
import 'package:organisation_app/model/module.dart';

class ModuleDetailsPage extends StatelessWidget {
  final Module module;

  const ModuleDetailsPage({Key? key, required this.module}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(module.name),
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
            // add a button to edit the module
            const SubscribeButton(),
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

class SubscribeButton extends StatelessWidget {
  const SubscribeButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: TextButton.styleFrom(
        backgroundColor: Colors.red,
      ),
      child: const Text(
        'Subscribe',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}
