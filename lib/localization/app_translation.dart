import 'package:catalog_city_project/localization/ar_sa.dart';
import 'package:catalog_city_project/localization/de_de.dart';
import 'package:catalog_city_project/localization/en_us.dart';
import 'package:catalog_city_project/localization/fr_fr.dart';
import 'package:catalog_city_project/localization/hi_in.dart';
import 'package:catalog_city_project/localization/zn_ch.dart';
import 'package:get/get.dart';

class AppTranslation implements Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        "en": enUS,
        "fr": frFR,
        "ar": arSA,
        "hi": hiIN,
        "de": deDE,
        "zh": zhCN,
      };
}
