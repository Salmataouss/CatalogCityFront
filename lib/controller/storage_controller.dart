import 'dart:convert';

import 'package:catalog_city_project/model/person_details.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageController {
  static final instance = StorageController();
  String languageCode = "languageCode";
  String countryCode = "countryCode";
  String lng = "language";
  String token = "token";
  String isFirstTime = "isFirstTime";

  Future<String?> getLang() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(lng);
  }

  Future<void> setLang(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(lng, value);
  }

  Future<void> setLanguage(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(languageCode, value);
  }

  Future<String?> getLanguage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(languageCode);
  }

  Future<void> setCountryCode(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(countryCode, value);
  }

  Future<void> setAuthToken(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(token, value);
  }

  Future<String?> getAuthToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(token);
  }

  Future<void> setAuthenticatedUser(PersonDetails user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('authUser', jsonEncode(user));
  }

  Future<bool> setAppOpened() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setBool(isFirstTime, false);
  }

  Future<bool> isAppOpened() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(isFirstTime) ?? true;
  }

  Future getAuthenticatedUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final userString = prefs.getString('authUser');
    return userString != null ? jsonDecode(userString) : null;
  }

  Future<bool> isUserAuth() async {
    String? token = await getAuthToken();
    return token != null ? true : false;
  }

  Future<bool> clearToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.remove(token);
  }

  Future<bool> clearUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.remove('authUser');
  }

  Future<String?> getCountryCode() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(countryCode);
  }
}
