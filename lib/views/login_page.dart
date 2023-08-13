import 'package:denguecare/views/widgets/input_email_widget.dart';
import 'package:denguecare/views/widgets/input_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Card(
              elevation: 8,
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('images/logo-no-background.png'),
                      const SizedBox(height: 20),
                      const SizedBox(height: 20),
                      InputEmailWidget(
                        hintText: "Email",
                        controller: _emailController,
                        obscureText: false,
                      ),
                      const SizedBox(height: 20),
                      InputWidget(
                          hintText: "Password",
                          controller: _passwordController,
                          obscureText: true),
                      const SizedBox(height: 20),
                      InkWell(
                        onTap: () {},
                        child: Text(
                          "Don't have an account? Sign up now!",
                          style: GoogleFonts.poppins(
                              fontSize: size * 0.030, color: Colors.blue),
                        ),
                      ),
                      const SizedBox(height: 18),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {},
                          child: Text(
                            "Login",
                            style: GoogleFonts.poppins(fontSize: size * 0.040),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
