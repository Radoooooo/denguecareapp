import 'package:denguecare/views/userregister_page.dart';
import 'package:denguecare/views/widgets/input_email_widget.dart';
import 'package:denguecare/views/widgets/input_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:denguecare/controllers/authentication.dart';

class UserLoginPage extends StatefulWidget {
  const UserLoginPage({super.key});

  @override
  State<UserLoginPage> createState() => _UserLoginPageState();
}

class _UserLoginPageState extends State<UserLoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _selectedUserType = 'User';
  final List<String> _userTypes = ['User', 'Admin'];
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
                                    style: GoogleFonts.poppins(
                                        fontSize: size * 0.040),
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
