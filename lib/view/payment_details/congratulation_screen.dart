import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:catalog_city_project/util/asset_image_paths.dart';
import 'package:catalog_city_project/util/colors.dart';
import 'package:catalog_city_project/util/size_config.dart';
import 'package:catalog_city_project/util/string_config.dart';
import '../common/common_button.dart';
import '../../util/font_family.dart';
import '../my_reviews_screen/give_a_rating_screen.dart';

class CongratulationScreen extends StatefulWidget {
  final String hotel;
  const CongratulationScreen({Key? key, required this.hotel}) : super(key: key);

  @override
  State<CongratulationScreen> createState() => _CongratulationScreenState();
}

class _CongratulationScreenState extends State<CongratulationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorFile.whiteColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: SizeFile.height20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: Get.height / 10.5),
            Image.asset(AssetImagePaths.congratulationIcon,
                height: SizeFile.height189),
            const SizedBox(height: SizeFile.height40),
            Text(
                "${StringConfig.congratulation}\n ${widget.hotel} ${StringConfig.bookingCongratulation}",
                textAlign: TextAlign.center,
                style: TextStyle(
                    decorationColor: ColorFile.onBordingColor,
                    color: ColorFile.onBordingColor,
                    fontFamily: satoshiMedium,
                    fontWeight: FontWeight.w500,
                    fontSize: SizeFile.height18)),
            SizedBox(height: Get.height / 4.3),
            GestureDetector(
              onTap: () {
                Get.to(const GiveARatingScreen());
              },
              child: ButtonCommon(
                text: StringConfig.next,
                buttonColor: ColorFile.appColor,
                textColor: ColorFile.whiteColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
