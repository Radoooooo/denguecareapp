import 'package:denguecare/controllers/authentication.dart';
import 'package:denguecare/views/userlogin_page.dart';

import 'package:denguecare/views/widgets/input_age_widget.dart';
import 'package:denguecare/views/widgets/input_confirmpass_widget.dart';
import 'package:denguecare/views/widgets/input_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

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

  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final AuthenticationController _authenticationController =
      Get.put(AuthenticationController());
  void clear() {
    _nameController.text = "";
    _ageController.text = "";
    _sexController.text = "";
    _contactNumberController.text = "";
    _emailController.text = "";
    _passwordController.text = "";
  }

  bool _isPasswordNotVisible = true;
  @override
  Widget build(BuildContext context) {
    // var size = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 118, 162, 120),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Card(
              child: Container(
                padding: const EdgeInsets.all(32.0),
                constraints: const BoxConstraints(maxWidth: 360),
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
                        InputAgeWidget(
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
                        IntlPhoneField(
                          initialCountryCode: 'PH',
                          controller: _contactNumberController,
                          decoration: const InputDecoration(
                            labelText: 'Contact Number',
                            border: OutlineInputBorder(
                              borderSide: BorderSide(),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        InputWidget(
                          hintText: "Email",
                          controller: _emailController,
                          obscureText: false,
                        ),
                        const SizedBox(height: 20),
                        InputConfirmPassWidget(
                          hintText: "Password",
                          controller: _passwordController,
                          confirmController: _confirmPasswordController,
                          obscureText: _isPasswordNotVisible,
                          iconButton: IconButton(
                            icon: Icon(_isPasswordNotVisible
                                ? Icons.visibility
                                : Icons.visibility_off),
                            onPressed: () {
                              setState(() {
                                _isPasswordNotVisible = !_isPasswordNotVisible;
                              });
                            },
                          ),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 50,
                                vertical: 15,
                              ),
                            ),
                            onPressed: () async {
                              await _authenticationController.userRegister(
                                name: _nameController.text.trim(),
                                age: _ageController.text.trim(),
                                sex: _sexController.text.trim(),
                                contactNumber:
                                    _contactNumberController.text.trim(),
                                email: _emailController.text.trim(),
                                password: _passwordController.text.trim(),
                              );
                              clear();
                              Get.offAll(() => const UserLoginPage());
                            },
                            child: Obx(() {
                              return _authenticationController.isLoading.value
                                  ? const CircularProgressIndicator(
                                      color: Colors.white,
                                    )
                                  : Text(
                                      "Register",
                                      style: GoogleFonts.poppins(fontSize: 20),
                                    );
                            }),
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
                                fontSize: 12, color: Colors.blue),
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
      ),
    );
  }
}

class UserOTP extends StatelessWidget {
  const UserOTP({super.key});
  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
