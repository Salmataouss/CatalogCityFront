import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:catalog_city_project/util/asset_image_paths.dart';
import 'package:catalog_city_project/util/colors.dart';
import 'package:catalog_city_project/util/size_config.dart';
import 'package:catalog_city_project/util/string_config.dart';
import '../common/common_button.dart';
import '../../util/font_family.dart';
import '../home_screen/home_screen.dart';

class EmptyFavouriteScreen extends StatefulWidget {
  const EmptyFavouriteScreen({Key? key}) : super(key: key);

  @override
  State<EmptyFavouriteScreen> createState() => _EmptyFavouriteScreenState();
}

class _EmptyFavouriteScreenState extends State<EmptyFavouriteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorFile.whiteColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: Get.height / 10.5),
          Image.asset(
            AssetImagePaths.emptyFavouriteIcon,
            height: SizeFile.height189,
          ),
          const SizedBox(height: SizeFile.height40),
          Text(StringConfig.noTourSavedYet.tr,
              textAlign: TextAlign.center,
              style: TextStyle(
                  decorationColor: ColorFile.onBordingColor,
                  color: ColorFile.appColor,
                  fontFamily: satoshiBold,
                  fontWeight: FontWeight.w700,
                  fontSize: SizeFile.height22)),
          const SizedBox(height: SizeFile.height2),
          Text(StringConfig.saveOrganizeAndShareActivesAndTour.tr,
              textAlign: TextAlign.center,
              style: TextStyle(
                  decorationColor: ColorFile.onBordingColor,
                  color: ColorFile.onBording2Color,
                  fontFamily: satoshiMedium,
                  fontWeight: FontWeight.w500,
                  fontSize: SizeFile.height16)),
          SizedBox(height: Get.height / 4.3),
          GestureDetector(
            onTap: () {
              Get.to(const HomeScreen());
            },
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: SizeFile.height20),
              child: ButtonCommon(
                text: StringConfig.findNewActivities.tr,
                buttonColor: ColorFile.appColor,
                textColor: ColorFile.whiteColor,
              ),
            ),
          ),
          SizedBox(height: SizeFile.height10)
        ],
      ),
    );
  }
}
