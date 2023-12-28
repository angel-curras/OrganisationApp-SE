import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:organisation_app/services/login_service.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  // text editing controllers
  final usernameController = TextEditingController();

  // sign user in method
  void signUserIn() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 70),

                SizedBox(
                  height: 120,
                  child: Image.asset(
                    'assets/images/logo.png',
                    width: 200,
                    height: 200,
                    fit: BoxFit.contain,
                  ),
                ),
                Image.asset(
                  'assets/images/shadow.png',
                  width: 150,
                  height: 150,
                ),

                // welcome back, you've been missed!
                const Text(
                  'Welcome back you\'ve been missed!',
                  style: TextStyle(
                    color: Colors.white60,
                    fontSize: 16,
                  ),
                ),

                const SizedBox(height: 20),

                // username textfield
                TextField(
                  controller: usernameController,
                  decoration: const InputDecoration(
                    labelText: 'Enter your name',
                    border: OutlineInputBorder(),
                  ),
                ),

                // Login button
                LoginButton(
                  icon: FontAwesomeIcons.rightToBracket,
                  text: 'Login',
                  loginMethod: () async {
                    BuildContext initialContext = context;

                    // Get the name from the text field
                    String name = usernameController.text;
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

                const SizedBox(height: 20),

                // continue as guest

                Padding(
                  padding: const EdgeInsets.all(8.0),
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
                    color: const Color(0xffbf0000),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// calls for the login button
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
