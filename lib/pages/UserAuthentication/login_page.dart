import 'package:flutter/material.dart';
import 'package:uni_project/pages/UserAuthentication/components/my_text_field.dart';
import 'package:uni_project/pages/UserAuthentication/components/my_button.dart';
import 'package:uni_project/pages/UserAuthentication/components/square_tile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uni_project/pages/UserAuthentication/forgot_pw_page.dart';

class LoginPage extends StatefulWidget {
  final Function? regButtonPressed;
  const LoginPage({super.key, this.regButtonPressed});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  void signUserIn() async {
    // Show a loading dialog
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      showErrorMessage("${e.code}: ${e.message}");
    }
  }

  void showErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Center(
            child: Text(
              'Error',
              style: TextStyle(
                color: Colors.red,
              ),
            ),
          ),
          content: Text(
            'An error occurred: $message',
            style: const TextStyle(
              color: Colors.red,
            ),
            textAlign: TextAlign.center,
          ),
          actions: [
            Center(
              child: TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('OK'),
              ),
            ),
          ],
          backgroundColor: const Color.fromARGB(255, 217, 238, 255),
        );
      },
    );
  }

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 159, 215, 241),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 30),
                const CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('assets/avatar.jpg'),
                ),
                const SizedBox(height: 30),
                const Text(
                  'Welcome Student!, Please login to continue.',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 22, 20, 20),
                  ),
                ),
                const SizedBox(height: 30),
                MyTextField(
                  controller: emailController,
                  hintText: 'Email',
                  obscureText: false,
                ),
                const SizedBox(height: 20),
                MyTextField(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                ),
                const SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const ForgotPasswordPage()));
                        },
                        child: const Text(
                          'Forgot password?',
                          style: TextStyle(
                            fontSize: 15,
                            color: Color.fromARGB(255, 23, 98, 173),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                MyButton(
                  text: 'Login',
                  onTap: signUserIn,
                ),
                const SizedBox(height: 30),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          'Or continue with',
                          style: TextStyle(color: Color.fromARGB(255, 46, 46, 46)),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SquareTile(imagePath: 'assets/Google__G__logo.svg.png'),
                    SizedBox(width: 50),
                    SquareTile(imagePath: 'assets/1690643640twitter-x-icon-png.webp')
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Don\'t have an account?',
                      style: TextStyle(
                        color: Color.fromARGB(255, 43, 42, 42),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        if (widget.regButtonPressed != null) {
                          print("button clicked");
                          widget.regButtonPressed!();
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 7),
                        child: Text(
                          'Register',
                          style: TextStyle(
                            color: Colors.blue[700],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
