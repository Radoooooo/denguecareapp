import 'package:denguecare/views/user/userregister_page.dart';
import 'package:denguecare/views/widgets/input_widget.dart';
import 'package:denguecare/views/widgets/input_password_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:denguecare/controllers/authentication.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _selectedUserType = 'User';
  final List<String> _userTypes = ['User', 'Admin'];
  final AuthenticationController _authenticationController =
      Get.put(AuthenticationController());
  bool _isPasswordNotVisible = true;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 118, 162, 120),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Card(
              elevation: 8,
              child: Container(
                padding: const EdgeInsets.all(32.0),
                constraints: const BoxConstraints(maxWidth: 360),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('images/logo-no-background.png'),
                      const SizedBox(height: 20),
                      const SizedBox(height: 20),
                      DropdownButtonFormField<String>(
                        value: _selectedUserType,
                        items: _userTypes.map((String userType) {
                          return DropdownMenuItem<String>(
                            value: userType,
                            child: Text(
                              userType,
                              style: GoogleFonts.poppins(fontSize: 16),
                            ),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedUserType = value!;
                          });
                        },
                      ),
                      const SizedBox(height: 20),
                      InputWidget(
                        hintText: "Email",
                        controller: _emailController,
                        obscureText: false,
                      ),
                      const SizedBox(height: 20),
                      InputPasswordWidget(
                        hintText: "Password",
                        controller: _passwordController,
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
                          //padding: const EdgeInsets.symmetric(vertical: 5),
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
                            if (_selectedUserType == 'User') {
                              await _authenticationController.userLogin(
                                email: _emailController.text.trim(),
                                password: _passwordController.text.trim(),
                              );
                            }
                            if (_selectedUserType == 'Admin') {
                              await _authenticationController.adminLogin(
                                email: _emailController.text.trim(),
                                password: _passwordController.text.trim(),
                              );
                            }
                          },
                          child: Obx(() {
                            return _authenticationController.isLoading.value
                                ? const CircularProgressIndicator(
                                    color: Colors.white)
                                : Text(
                                    "Login",
                                    style: GoogleFonts.poppins(fontSize: 20),
                                  );
                          }),
                        ),
                      ),
                      const SizedBox(height: 18),
                      InkWell(
                        onTap: () {
                          Get.to(() => const UserRegisterPage());
                        },
                        child: Text(
                          "Don't have an account? Sign up now!",
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
    );
  }
}
