import 'package:catalog_city_project/controller/storage_controller.dart';
import 'package:catalog_city_project/view/sign_up_screen/sign_up_screen.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../model/person_details.dart';

class AuthUtils {
  static Future<bool> redirectTo({Widget? page}) async {
    String? token = await StorageController.instance.getAuthToken();
    if (token != null) {
      if (page != null) {
        Get.to(() => page);
      }
      return true;
    } else {
      Get.to(() => SignUpScreen());
      return false;
    }
  }

  static Future getConnectedUser() async {
    var userData = await StorageController.instance.getAuthenticatedUser();
    PersonDetails user = PersonDetails(email: '');
    if (userData != null) {
      user = PersonDetails(
        email: userData['email'],
        imageUrl: userData['imageUrl'],
        name: userData['name'],
      );
    }
    return user;
  }
}
