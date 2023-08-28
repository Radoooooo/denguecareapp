import 'dart:convert';
import 'package:denguecare/constants/constants.dart';
import 'package:denguecare/views/admin/admin_homepage.dart';
import 'package:denguecare/views/login_page.dart';
import 'package:denguecare/views/user/userregister_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';
import '../views/user/userhome_page.dart';

class AuthenticationController extends GetxController {
  UserRegisterPage userRegisterPage = const UserRegisterPage();
  final isLoading = false.obs;
  final token = ''.obs;
  final box = GetStorage();

  Future userRegister({
    required String name,
    required String age,
    required String sex,
    required String contactNumber,
    required String email,
    required String password,
  }) async {
    try {
      isLoading.value = true;
      var data = {
        'name': name,
        'age': age,
        'sex': sex,
        'contact_number': contactNumber,
        'email': email,
        'password': password,
      };

      var response = await http.post(
        // ignore: prefer_interpolation_to_compose_strings
        Uri.parse(url + 'register'),
        headers: {
          'Accept': 'application/json',
        },
        body: data,
      );
      if (response.statusCode == 201) {
        isLoading.value = false;
        token.value = json.decode(response.body)['token'];
        box.write('token', token.value);

        Get.snackbar(
          'Success',
          //json.decode(response.body)['message'],
          'Register Successful',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      } else {
        isLoading.value = false;
        Get.snackbar(
          'Error',
          json.decode(response.body)['message'],
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        debugPrint(json.decode(response.body).toString());
      }
    } catch (e) {
      isLoading.value = false;
      print(e.toString());
    }
  }

  Future userLogin({
    required String email,
    required String password,
  }) async {
    try {
      isLoading.value = true;
      var data = {
        'email': email,
        'password': password,
      };

      var response = await http.post(
        // ignore: prefer_interpolation_to_compose_strings
        Uri.parse(url + 'login'),
        headers: {
          'Accept': 'application/json',
        },
        body: data,
      );
      if (response.statusCode == 200) {
        isLoading.value = false;
        token.value = json.decode(response.body)['token'];
        box.write('token', token.value);
        Get.offAll(() => const UserMainPage());
      } else {
        isLoading.value = false;
        Get.snackbar(
          'Error',
          json.decode(response.body)['message'],
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        debugPrint(json.decode(response.body).toString());
      }
    } catch (e) {
      isLoading.value = false;

      print(e.toString());
    }
  }

  Future adminLogin({
    required String email,
    required String password,
  }) async {
    try {
      isLoading.value = true;
      var data = {
        'email': email,
        'password': password,
      };

      var response = await http.post(
        // ignore: prefer_interpolation_to_compose_strings
        Uri.parse(url + 'adminlogin'),
        headers: {
          'Accept': 'application/json',
        },
        body: data,
      );
      if (response.statusCode == 200) {
        isLoading.value = false;
        token.value = json.decode(response.body)['token'];
        box.write('token', token.value);
        Get.offAll(() => const AdminMainPage());
      } else {
        isLoading.value = false;
        Get.snackbar(
          'Error',
          json.decode(response.body)['message'],
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        debugPrint(json.decode(response.body).toString());
      }
    } catch (e) {
      isLoading.value = false;
      print(e.toString());
    }
  }

  Future logout() async {
    try {
      isLoading.value = true;
      final response = await http.post(
        // ignore: prefer_interpolation_to_compose_strings
        Uri.parse(url + 'logout'),
        headers: {
          'Accept': 'application/json', // Add necessary headers
          // Other headers if needed
        },
      );

      if (response.statusCode == 200) {
        isLoading.value = false;
        // Logout successful, navigate to login page

        Get.offAll(() => const LoginPage());
      } else {
        // Handle error response
        isLoading.value = false;
        Get.snackbar(
          'Error',
          json.decode(response.body)['message'],
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        debugPrint(json.decode(response.body).toString());
      }
    } catch (e) {
      // Handle network or other errors
      isLoading.value = false;
      print(e.toString());
    }
  }
}
