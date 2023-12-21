import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:organisation_app/services/backend.dart';
import 'package:organisation_app/services/logInService.dart';

class LoginPage extends StatefulWidget {
  final Backend? backend;
  final http.Client? client;

  static LogInService loginService =
      LogInService(backend: Backend(), client: http.Client());

  const LoginPage({Key? key, logInService, this.backend, this.client})
      : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _nameController = TextEditingController();

  get logInService => LoginPage.loginService;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const FlutterLogo(
              size: 150,
            ),
            Flexible(
              child: LoginButton(
                icon: FontAwesomeIcons.userNinja,
                text: 'Continue as Guest',
                loginMethod: () => Navigator.pushNamed(context, '/'),
                color: Colors.deepPurple,
              ),
            ),
            SizedBox(height: 20), // Add some spacing

            // New text field for the name
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Enter your name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20), // Add some spacing

            // New login button for custom login
            LoginButton(
              icon: FontAwesomeIcons.signInAlt,
              text: 'Login',
              loginMethod: () async {
                // Get the name from the text field
                String name = _nameController.text;
                // Call the login method from the LogInService
                if (await logInService.authentication(name)) {
                  Navigator.pushNamed(context, '/');
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Invalid name'),
                    ),
                  );
                }
              },
              color: Colors.blue,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }
}

class LoginButton extends StatelessWidget {
  final Color color;
  final IconData icon;
  final String text;
  final VoidCallback loginMethod;

  const LoginButton({
    Key? key,
    required this.text,
    required this.icon,
    required this.color,
    required this.loginMethod,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: ElevatedButton.icon(
        icon: Icon(
          icon,
          color: Colors.white,
          size: 20,
        ),
        style: TextButton.styleFrom(
          padding: const EdgeInsets.all(24),
          backgroundColor: color,
        ),
        onPressed: loginMethod,
        label: Text(text, textAlign: TextAlign.center),
      ),
    );
  }
}
