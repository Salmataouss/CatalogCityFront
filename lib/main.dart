import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:catalog_city_project/localization/app_translation.dart';
import 'package:catalog_city_project/util/app_routes.dart';
import 'package:catalog_city_project/util/colors.dart';
import 'package:catalog_city_project/util/string_config.dart';

import 'controller/storage_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.transparent));

  String? languageCode = await StorageController.instance.getLanguage();
  String? countryCode = await StorageController.instance.getCountryCode();
  String initialRoute = await AppRoutes.initial;

  runApp(MyApp(
    languageCode: languageCode,
    countryCode: countryCode,
    initial: initialRoute,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    this.languageCode,
    this.countryCode,
    this.initial = AppRoutes.splashScreen,
  });

  final String? languageCode;
  final String? countryCode;
  final String initial;

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: StringConfig.appName,
      locale: Locale(languageCode ?? "en", countryCode ?? "US"),
      translations: AppTranslation(),
      theme: ThemeData(primaryColor: ColorFile.appColor),
      initialRoute: initial,
      getPages: AppRoutes.routes,
    );
  }
}
