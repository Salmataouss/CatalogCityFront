import 'package:catalog_city_project/model/person_details.dart';
import 'package:catalog_city_project/view/common/app_snakbar.dart';
import 'package:catalog_city_project/view/login_screem/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../services/api.dart';
import '../util/string_config.dart';

class SignUpController extends GetxController {
  RxBool signPasswordVisible = false.obs;
  RxBool signConFirmPasswordVisible = false.obs;
  RxBool isLoading = false.obs;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  RegExp regExp = RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

  void onSubmit() async {
    if (formKey.currentState!.validate()) {
      try {
        isLoading(true);
        PersonDetails user = PersonDetails(
          name: nameController.text,
          email: emailController.text,
          password: passwordController.text,
        );

        await Api.registerWithEmail(user);
        Get.off(() => LoginScreen());
        AppSnakBar.showSuccess(
            title: 'Success', message: 'User Created Successfuly');
      } catch (e) {
        AppSnakBar.showError(title: 'Error', message: e.toString());
      } finally {
        isLoading(false);
      }
    }
  }

  void clearAllField() {
    nameController.clear();
    emailController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
  }

  String? nameValidator(value) {
    if (value!.isEmpty) {
      return "\u24D8 ${StringConfig.thisFieldIsRequired}";
    }
    return null;
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

  String? confirmPasswordValidator(value) {
    if (value!.isEmpty) {
      return "\u24D8 ${StringConfig.thisFieldIsRequired}";
    } else if (value.length < 6) {
      return "\u24D8 ${StringConfig.passwordMustBeMoreThan6}";
    } else if (value != passwordController.text) {
      return "\u24D8 ${StringConfig.passwordNotMatch}";
    }
    return null;
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
  }
}
