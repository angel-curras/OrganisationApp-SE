import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MenuDrawer extends StatelessWidget {
  const MenuDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text('Menu'),
          ),
          ListTile(
            leading: const Icon(
              FontAwesomeIcons.house, // replace with your own icon
              size: 25,
            ),
            title: const Text('Home'),
            onTap: () {
              Navigator.pushNamed(context, '/');
            },
          ),
          ListTile(
            leading: const Icon(
              FontAwesomeIcons.book, // replace with your own icon
              size: 25,
            ),
            title: const Text('Courses'),
            onTap: () {
              Navigator.pushNamed(context, '/courses');
            },
          ),
          ListTile(
            leading: const Icon(
              FontAwesomeIcons.calendar, // replace with your own icon
              size: 25,
            ),
            title: const Text('Calendar'),
            onTap: () {
              Navigator.pushNamed(context, '/calendar');
            },
          ),
          ListTile(
            leading: const Icon(
              FontAwesomeIcons.listCheck, // replace with your own icon
              size: 25,
            ),
            title: const Text('ToDos'),
            onTap: () {
              Navigator.pushNamed(context, '/todos');
            },
          ),
          ListTile(
            leading: const Icon(
              FontAwesomeIcons.barsProgress, // replace with your own icon
              size: 25,
            ),
            title: const Text('Progress'),
            onTap: () {
              Navigator.pushNamed(context, '/progress');
            },
          ),
          ListTile(
            leading: const Icon(
              FontAwesomeIcons.m, // replace with your own icon
              size: 25,
            ),
            title: const Text('Moodle'),
            onTap: () {
              Navigator.pushNamed(context, '/moodle');
            },
          ),
          ListTile(
            leading: const Icon(
              FontAwesomeIcons.idCard, // replace with your own icon
              size: 25,
            ),
            title: const Text('Primuss'),
            onTap: () {
              Navigator.pushNamed(context, '/primuss');
            },
          ),
          ListTile(
            leading: const Icon(
              FontAwesomeIcons.comments, // replace with your own icon
              size: 25,
            ),
            title: const Text('ChatGPT'),
            onTap: () {
              Navigator.pushNamed(context, '/chatgpt');
            },
          ),
          ListTile(
            leading: const Icon(
              FontAwesomeIcons.question, // replace with your own icon
              size: 25,
            ),
            title: const Text('About'),
            onTap: () {
              Navigator.pushNamed(context, '/about');
            },
          ),
        ],
      ),
    );
  }
}
