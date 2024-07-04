import 'dart:convert';

import 'package:catalog_city_project/controller/storage_controller.dart';
import 'package:catalog_city_project/model/person_details.dart';
import 'package:catalog_city_project/model/place_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../model/category_model.dart';

class Api {
 static String baseUrl ='https://uq7bi61dug.execute-api.eu-central-1.amazonaws.com/dev';
  static var client = http.Client();

  static Future<List<CategoryModel>?> getCategories() async {
   var url = Uri.parse('$baseUrl/categories');

    var response = await http.get(url);
    if (response.statusCode == 200) {
      var data = response.body;
      return categoryFromJson(data);
    } else {
      debugPrint('Request failed with status: ${response.statusCode}.');
      return null;
    }
  }

  static Future<List<PlaceModel>?> getCities() async {
    var url = Uri.parse('$baseUrl/cities2');

    var response = await http.get(url);
    if (response.statusCode == 200) {
      var data = response.body;
      return placeModelFromJson(data);
    } else {
      debugPrint('Request failed with status: ${response.statusCode}.');
      return null;
    }
  }

  static Future<List<PlaceModel>?> getInternationalTrips() async {
    var url = Uri.parse('$baseUrl/countries');

    var response = await http.get(url);
    if (response.statusCode == 200) {
      var data = response.body;
      return placeModelFromJson(data);
    } else {
      debugPrint('Request failed with status: ${response.statusCode}.');
      return null;
    }
  }

  static Future<void> registerWithEmail(PersonDetails user) async {
     var url = Uri.parse('$baseUrl/auth/signup');
    Map userData = personToJson(user);

    var response = await http.post(url, body: userData);
    String responseBody = response.body;

    if (response.statusCode == 201) {
      final json = jsonDecode(response.body);
      var token = json['token'];
      debugPrint('token : $token');
    } else {
      throw jsonDecode(responseBody)["message"] ?? "Unknown Error Occured";
    }
  }

  static Future<void> loginWithEmail(PersonDetails user) async {
    var url = Uri.parse('$baseUrl/auth/login');
    Map userData = personToJson(user);

    var response = await http.post(url, body: userData);
    String responseBody = response.body;

    if (response.statusCode == 201) {
      final json = jsonDecode(response.body);
      var token = json['access_token'];
      await StorageController.instance.setAuthToken(token);

      user.imageUrl = json['user']['image'];
      user.name = json['user']['name'];
      await StorageController.instance.setAuthenticatedUser(user);
    } else {
      throw jsonDecode(responseBody)["message"] ?? "Unknown Error Occured";
    }
  }

  static Future<void> createNewCity(PlaceModel city) async {
     var url = Uri.parse('$baseUrl/cities2');

    var cityData = placeToJson(city);

    var response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(cityData),
    );
    String responseBody = response.body;
    if (response.statusCode == 201) {
      // final json = jsonDecode(response.body);
    } else {
      throw jsonDecode(responseBody)["message"] ?? "Unknown Error Occured";
    }
  }
}
