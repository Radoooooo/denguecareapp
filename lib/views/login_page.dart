import 'package:denguecare/views/widgets/input_widget.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Card(
            elevation: 8,
            child: Container(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Login Page"),
                  const SizedBox(height: 20),
                  InputWidget(
                      hintText: "Email",
                      controller: _emailController,
                      obscureText: false),
                  const SizedBox(height: 20),
                  InputWidget(
                      hintText: "Password",
                      controller: _passwordController,
                      obscureText: true)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
