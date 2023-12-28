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
            accountEmail: Text("@${context.read<AppSettings>().user.userName}"),
            currentAccountPicture: const CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(
                Icons.person,
                color: Colors.black,
              ),
            ),
          ),
          ListTile(
            key: const Key('homeTile'),
            leading: const Icon(
              FontAwesomeIcons.house, // replace with your own icon
              size: 25,
            ),
            title: const Text('My Courses'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/home');
            },
          ),
          ListTile(
            key: const Key('modulesTile'),
            leading: const Icon(
              FontAwesomeIcons.book, // replace with your own icon
              size: 25,
            ),
            title: const Text('Modules'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/courses');
            },
          ),
          ListTile(
            key: const Key('todosTile'),
            leading: const Icon(
              FontAwesomeIcons.listCheck, // replace with your own icon
              size: 25,
            ),
            title: const Text('ToDos'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/todos');
            },
          ),
          const Divider(),
          ListTile(
            key: const Key('moodleTile'),
            leading: const Icon(
              FontAwesomeIcons.m, // replace with your own icon
              size: 25,
            ),
            title: const Text('Moodle'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/moodle');
            },
          ),
          ListTile(
            key: const Key('primussTile'),
            leading: const Icon(
              FontAwesomeIcons.idCard, // replace with your own icon
              size: 25,
            ),
            title: const Text('Primuss'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/primuss');
            },
          ),
          ListTile(
            key: const Key('chatgptTile'),
            leading: const Icon(
              FontAwesomeIcons.comments, // replace with your own icon
              size: 25,
            ),
            title: const Text('ChatGPT'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/chatgpt');
            },
          ),
          const Divider(),
          ListTile(
            key: const Key('logoutTile'),
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
