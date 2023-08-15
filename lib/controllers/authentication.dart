import 'dart:convert';
import 'package:denguecare/constants/constants.dart';
import 'package:denguecare/views/userhome_page.dart';
import 'package:denguecare/views/userlogin_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';

class AuthenticationController extends GetxController {
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
        'contactNumber': contactNumber,
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
        Get.offAll(() => const UserLoginPage());
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
        Get.offAll(() => const UserHomePage());
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
}
