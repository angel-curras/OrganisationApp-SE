import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:organisation_app/services/login_service.dart';
import 'package:organisation_app/settings/app_settings.dart';
import 'package:provider/provider.dart';

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
          UserAccountsDrawerHeader(
            accountName: Text(context.read<AppSettings>().user.fullName),
            accountEmail: Text(context.read<AppSettings>().user.userName),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(
                Icons.person,
                color: Colors.black,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(
              FontAwesomeIcons.house, // replace with your own icon
              size: 25,
            ),
            title: const Text('My Semester'),
            onTap: () {
              Navigator.pushNamed(context, '/');
            },
          ),
          ListTile(
            leading: const Icon(
              FontAwesomeIcons.book, // replace with your own icon
              size: 25,
            ),
            title: const Text('Modules'),
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
          const Divider(),
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
          const Divider(),
          ListTile(
            leading: const Icon(
              FontAwesomeIcons.arrowRightFromBracket,
              // replace with your own icon
              size: 25,
            ),
            title: const Text(
              'Logout',
              style: TextStyle(color: Colors.red),
            ),
            onTap: () async {
              BuildContext initialContext = context;
              await LoginService().logout();
              if (!initialContext.mounted) return;
              Navigator.of(initialContext)
                  .pushNamedAndRemoveUntil('/login', (route) => false);
            },
          ),
        ],
      ),
    );
  }
}
