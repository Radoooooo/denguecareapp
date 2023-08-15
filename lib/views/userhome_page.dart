import 'package:flutter/material.dart';
import 'package:denguecare/controllers/authentication.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class UserHomePage extends StatefulWidget {
  const UserHomePage({super.key});

  @override
  State<UserHomePage> createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  final AuthenticationController _authenticationController =
      Get.put(AuthenticationController());
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("hello"),
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
                await _authenticationController.logout();
              },
              child: Obx(() {
                return _authenticationController.isLoading.value
                    ? const CircularProgressIndicator(color: Colors.white)
                    : Text(
                        "Logout",
                        style: GoogleFonts.poppins(fontSize: size * 0.040),
                      );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
