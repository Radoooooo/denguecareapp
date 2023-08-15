import 'package:denguecare/controllers/authentication.dart';
import 'package:denguecare/views/userlogin_page.dart';
import 'package:denguecare/views/widgets/input_email_widget.dart';
import 'package:denguecare/views/widgets/input_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class UserRegisterPage extends StatefulWidget {
  const UserRegisterPage({super.key});

  @override
  State<UserRegisterPage> createState() => _UserRegisterPageState();
}

class _UserRegisterPageState extends State<UserRegisterPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _sexController = TextEditingController();
  final TextEditingController _contactNumberController =
      TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthenticationController _authenticationController =
      Get.put(AuthenticationController());
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
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('images/logo-no-background.png'),
                      const SizedBox(height: 20),
                      const SizedBox(height: 20),
                      InputWidget(
                        hintText: "Name",
                        controller: _nameController,
                        obscureText: false,
                      ),
                      const SizedBox(height: 20),
                      InputWidget(
                        hintText: "Age",
                        controller: _ageController,
                        obscureText: false,
                      ),
                      const SizedBox(height: 20),
                      InputWidget(
                        hintText: "Sex",
                        controller: _sexController,
                        obscureText: false,
                      ),
                      const SizedBox(height: 20),
                      InputWidget(
                        hintText: "Contact Number",
                        controller: _contactNumberController,
                        obscureText: false,
                      ),
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
                        obscureText: true,
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {},
                          child: Text(
                            "Register",
                            style: GoogleFonts.poppins(fontSize: size * 0.040),
                          ),
                        ),
                      ),
                      const SizedBox(height: 14),
                      InkWell(
                        onTap: () {
                          Get.to(() => const UserLoginPage());
                        },
                        child: Text(
                          "Already have an accont? Sign in!",
                          style: GoogleFonts.poppins(
                              fontSize: size * 0.030, color: Colors.blue),
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
