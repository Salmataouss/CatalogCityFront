import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppSnakBar {
  static void showError({required title, required message}) {
    Get.snackbar(
      'Error',
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.red.shade50,
      titleText: Text(
        title,
        style: TextStyle(
          color: Colors.red,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
      messageText: Text(
        message,
        style: TextStyle(
          color: Colors.red,
        ),
      ),
    );
  }

  static void showSuccess({required title, required message}) {
    Get.snackbar(
      'Success',
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.green.shade50,
      titleText: Text(
        title,
        style: TextStyle(
          color: Colors.green,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
      messageText: Text(
        message,
        style: TextStyle(
          color: Colors.green,
        ),
      ),
    );
  }
}
