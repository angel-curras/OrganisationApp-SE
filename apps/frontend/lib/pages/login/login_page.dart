import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:organisation_app/services/login_service.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final TextEditingController _nameController = TextEditingController();

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
                loginMethod: () async {
                  BuildContext initialContext = context;
                  bool result = await LoginService().login('guest');
                  if (!context.mounted) return;
                  if (result) {
                    Navigator.pushReplacementNamed(initialContext, '/home');
                  } else {
                    ScaffoldMessenger.of(initialContext).showSnackBar(
                      const SnackBar(
                        content: Text('Login failed'),
                      ),
                    );
                  }
                },
                color: Colors.red,
              ),
            ),
            const SizedBox(height: 20), // Add some spacing

            // New text field for the name
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Enter your name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20), // Add some spacing

            // New login button for custom login
            LoginButton(
              icon: FontAwesomeIcons.rightToBracket,
              text: 'Login',
              loginMethod: () async {
                BuildContext initialContext = context;

                // Get the name from the text field
                String name = _nameController.text;
                bool result = await LoginService().login(name);
                if (!context.mounted) return;
                if (result) {
                  Navigator.pushReplacementNamed(initialContext, '/home');
                } else {
                  ScaffoldMessenger.of(initialContext).showSnackBar(
                    const SnackBar(
                      content: Text('Invalid username!'),
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
  } // end of build()
} // end of class LoginPage

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
