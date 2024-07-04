import 'package:catalog_city_project/view/admin/admin_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/person_details.dart';
import '../services/api.dart';
import '../util/string_config.dart';
import '../view/common/app_snakbar.dart';
import '../view/home_screen/home_screen.dart';

class LoginController extends GetxController {
  RxBool passwordVisible = false.obs;
  RxBool isLoading = false.obs;

  RegExp regExp = RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  void onSubmit() async {
    if (formKey.currentState!.validate()) {
      try {
        isLoading(true);
        PersonDetails user = PersonDetails(
          email: emailController.text,
          password: passwordController.text,
        );

        // login to admin
        if (user.email == 'admin@gmail.com' && user.password == 'admin2024') {
          Get.offAll(() => AdminScreen());
          isLoading(false);
          return;
        }

        await Api.loginWithEmail(user);
        Get.off(() => HomeScreen());
        AppSnakBar.showSuccess(
          title: 'Success',
          message: 'Logged in Successfuly',
        );
      } catch (e) {
        AppSnakBar.showError(title: 'Error', message: e.toString());
      } finally {
        isLoading(false);
      }
    }
  }

  void clearAllField() {
    emailController.clear();
    passwordController.clear();
  }

  String? emailValidator(value) {
    if (value!.isEmpty) {
      return "\u24D8 ${StringConfig.thisFieldIsRequired}";
    } else if (!regExp.hasMatch(value)) {
      return "\u24D8 ${StringConfig.invalidEmail}";
    }
    return null;
  }

  String? passwordValidator(value) {
    if (value!.isEmpty) {
      return "\u24D8 ${StringConfig.thisFieldIsRequired}";
    } else if (value.length < 6) {
      return "\u24D8 ${StringConfig.passwordMustBeMoreThan6}";
    }
    return null;
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }
}
