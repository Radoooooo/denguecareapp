import 'package:denguecare/views/admin/admin_dataviz.dart';
import 'package:denguecare/views/admin/admin_dengueheatmap.dart';
import 'package:denguecare/views/admin/admin_report_page.dart';
import 'package:flutter/material.dart';
import 'package:denguecare/controllers/authentication.dart';
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

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({super.key});

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  final AuthenticationController _authenticationController =
      Get.put(AuthenticationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DengueCare'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Image.asset('images/logo-no-background.png'),
            ),
            ListTile(
              title: const Text('Account Settings'),
              leading: const Icon(
                Icons.person,
                color: Colors.black,
              ),
              onTap: () {},
            ),
            ListTile(
              title: const Text('Manage Admins'),
              leading: const Icon(
                Icons.person_pin_rounded,
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
              title: const Text('View Logs'),
              leading: const Icon(
                Icons.view_list_outlined,
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
      ),
      body: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("hello admin"),
        ],
      ),
    );
  }
}

class AdminMainPage extends StatefulWidget {
  const AdminMainPage({super.key});

  @override
  State<AdminMainPage> createState() => _AdminMainPageState();
}

class _AdminMainPageState extends State<AdminMainPage> {
  int currentIndex = 0;
  final screens = [
    const AdminHomePage(),
    const AdminReportPage(),
    const AdminDengueHeatMapPage(),
    const AdminDataVizPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: screens,
      ),
      bottomNavigationBar: NavigationBar(
        animationDuration: const Duration(seconds: 1),
        selectedIndex: currentIndex,
        onDestinationSelected: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        destinations: _navBarItemsAdmin,
      ),
    );
  }
}

const _navBarItemsAdmin = [
  NavigationDestination(
    icon: Icon(Icons.home_outlined),
    selectedIcon: Icon(Icons.home_rounded),
    label: 'Home',
  ),
  NavigationDestination(
    icon: Icon(Icons.report_outlined),
    selectedIcon: Icon(Icons.report_rounded),
    label: 'Report',
  ),
  NavigationDestination(
    icon: Icon(Icons.map_outlined),
    selectedIcon: Icon(Icons.map_rounded),
    label: 'Map',
  ),
  NavigationDestination(
    icon: Icon(Icons.auto_graph_outlined),
    selectedIcon: Icon(Icons.auto_graph_rounded),
    label: 'Data Analytics',
  ),
];
