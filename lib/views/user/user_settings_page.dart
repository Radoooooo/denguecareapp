import 'package:denguecare/controllers/authentication.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

Future<bool> showLogoutConfirmationDialog(BuildContext context) async {
  return await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Logout Confirmation"),
        content: const Text("Are you sure you want to log out?"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false); // User canceled logout
            },
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true); // User confirmed logout
            },
            child: const Text("Logout"),
          ),
        ],
      );
    },
  );
}

class UserSettingsPage extends StatefulWidget {
  const UserSettingsPage({super.key});

  @override
  State<UserSettingsPage> createState() => _UserSettingsPageState();
}

class _UserSettingsPageState extends State<UserSettingsPage> {
  final AuthenticationController _authenticationController =
      Get.put(AuthenticationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          ListTile(
            title: const Text('Account Settings'),
            leading: const Icon(
              Icons.person,
              color: Colors.black,
            ),
            onTap: () {},
          ),
          ListTile(
            title: const Text('Prefereneces'),
            leading: const Icon(
              Icons.checklist,
              color: Colors.black,
            ),
            onTap: () {},
          ),
          ListTile(
            title: Obx(() {
              return _authenticationController.isLoading.value
                  ? const CircularProgressIndicator(color: Colors.white)
                  : Text(
                      "Logout",
                      style: GoogleFonts.poppins(color: Colors.red),
                    );
            }),
            leading: const Icon(
              Icons.logout_rounded,
              color: Colors.red,
            ),
            onTap: () async {
              bool logoutConfirmed =
                  await showLogoutConfirmationDialog(context);
              if (logoutConfirmed) {
                await _authenticationController.logout();
              }
            },
          ),
        ],
      ),
    );
  }
}
