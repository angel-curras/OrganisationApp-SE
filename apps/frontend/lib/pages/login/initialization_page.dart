import 'package:flutter/material.dart';
import 'package:organisation_app/settings/app_settings.dart';

class InitializationPage extends StatefulWidget {
  // Constructor.
  const InitializationPage({super.key});

  @override
  State<InitializationPage> createState() => _InitializationPageState();
}

class _InitializationPageState extends State<InitializationPage> {
  bool _isLoggedIn = false; // Replace with your authentication logic

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    AppSettings appSettings = AppSettings();

    // Get the login status from the shared preferences
    bool result = await appSettings.hasUser();

    // Update the state to reflect the login status
    setState(() {
      _isLoggedIn = result; // Set to true if the user is logged in
    });

    // Navigate to the appropriate screen based on the login status
    _navigateToScreen();
  }

  void _navigateToScreen() {
    if (_isLoggedIn) {
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child:
            CircularProgressIndicator(), // You can display a loading indicator here
      ),
    );
  }
}
