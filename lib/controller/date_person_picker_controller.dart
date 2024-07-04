import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../util/asset_image_paths.dart';
import '../util/colors.dart';
import '../view/common/common_button.dart';
import '../util/font_family.dart';
import '../util/size_config.dart';
import '../util/string_config.dart';

class DatePersonPickerController extends GetxController {
  var item1 = 0.obs;
  var item2 = 0.obs;
  var item3 = 0.obs;
  RxString date = DateFormat('dd/MM/yyyy').format(DateTime.now()).obs;
  bool isExpanded = false;

  void setDate(String date) {
    this.date.value = date;
  }

  void incrementCounter1() {
    item1.value++;
  }

  void incrementCounter2() {
    item2.value++;
  }

  void incrementCounter3() {
    item3.value++;
  }

  void decrementCounter1() {
    if (item1.value > 0) {
      item1.value--;
    }
  }

  void decrementCounter2() {
    if (item2.value > 0) {
      item2.value--;
    }
  }

  void decrementCounter3() {
    if (item3.value > 0) {
      item3.value--;
    }
  }

  int getSum() {
    return item1.value + item2.value + item3.value;
  }

  roomBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: ColorFile.whiteColor,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
        topLeft: Radius.circular(SizeFile.height16),
        topRight: Radius.circular(SizeFile.height16),
      )),
      builder: (BuildContext context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
          return Container(
            height: 430,
            decoration: BoxDecoration(
                color: ColorFile.whiteColor,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(SizeFile.height16),
                    topRight: Radius.circular(SizeFile.height16)),
                border: Border.all(color: ColorFile.whiteColor)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: SizeFile.height24,
                      vertical: SizeFile.height17),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(StringConfig.selectTravellerClass,
                          style: TextStyle(
                              color: ColorFile.onBordingColor,
                              fontFamily: satoshiMedium,
                              fontWeight: FontWeight.w500,
                              fontSize: SizeFile.height16)),
                      GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: Image.asset(
                            AssetImagePaths.closeIcon,
                            height: SizeFile.height10,
                            width: SizeFile.height10,
                          ))
                    ],
                  ),
                ),
                Divider(
                  color: ColorFile.appColor.withOpacity(0.15),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: SizeFile.height24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: SizeFile.height16),
                      const Text(StringConfig.addNumberOfTravellers,
                          style: TextStyle(
                              color: ColorFile.onBordingColor,
                              fontFamily: satoshiMedium,
                              fontWeight: FontWeight.w500,
                              fontSize: SizeFile.height14)),
                      const SizedBox(height: SizeFile.height24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(
                                  text: const TextSpan(
                                      text: StringConfig.adult,
                                      style: TextStyle(
                                          decorationColor:
                                              ColorFile.onBordingColor,
                                          color: ColorFile.onBordingColor,
                                          fontFamily: satoshiMedium,
                                          fontWeight: FontWeight.w500,
                                          fontSize: SizeFile.height16),
                                      children: [
                                    TextSpan(
                                        text: StringConfig.no12yrsAndAbove,
                                        style: TextStyle(
                                            decorationColor:
                                                ColorFile.onBordingColor,
                                            color: ColorFile.onBordingColor,
                                            fontFamily: satoshiRegular,
                                            fontWeight: FontWeight.w500,
                                            fontSize: SizeFile.height16))
                                  ])),
                              const SizedBox(height: SizeFile.height2),
                              const Text(StringConfig.onTheDayOfTravel,
                                  style: TextStyle(
                                      color: ColorFile.orContinue,
                                      fontFamily: satoshiRegular,
                                      fontWeight: FontWeight.w400,
                                      fontSize: SizeFile.height12)),
                            ],
                          ),
                          Row(
                            children: [
                              GestureDetector(
                                  onTap: () {
                                    decrementCounter1();
                                  },
                                  child: Image.asset(
                                    AssetImagePaths.minusIcon,
                                    height: SizeFile.height20,
                                    width: SizeFile.height20,
                                  )),
                              const SizedBox(width: SizeFile.height7),
                              Obx(
                                () => Text('$item1',
                                    style: const TextStyle(
                                        color: ColorFile.onBordingColor,
                                        fontFamily: satoshiBold,
                                        fontWeight: FontWeight.w500,
                                        fontSize: SizeFile.height16)),
                              ),
                              const SizedBox(width: SizeFile.height7),
                              GestureDetector(
                                  onTap: () {
                                    incrementCounter1();
                                  },
                                  child: Image.asset(
                                    AssetImagePaths.plushIcon,
                                    height: SizeFile.height20,
                                    width: SizeFile.height20,
                                  )),
                            ],
                          )
                        ],
                      ),
                      const SizedBox(height: SizeFile.height24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(
                                  text: const TextSpan(
                                      text: StringConfig.children,
                                      style: TextStyle(
                                          decorationColor:
                                              ColorFile.onBordingColor,
                                          color: ColorFile.onBordingColor,
                                          fontFamily: satoshiMedium,
                                          fontWeight: FontWeight.w500,
                                          fontSize: SizeFile.height16),
                                      children: [
                                    TextSpan(
                                        text: StringConfig.y212yrs,
                                        style: TextStyle(
                                            decorationColor:
                                                ColorFile.onBordingColor,
                                            color: ColorFile.onBording2Color,
                                            fontFamily: satoshiRegular,
                                            fontWeight: FontWeight.w500,
                                            fontSize: SizeFile.height16))
                                  ])),
                              const SizedBox(height: SizeFile.height2),
                              const Text(StringConfig.onTheDayOfTravel,
                                  style: TextStyle(
                                      color: ColorFile.orContinue,
                                      fontFamily: satoshiRegular,
                                      fontWeight: FontWeight.w400,
                                      fontSize: SizeFile.height12)),
                            ],
                          ),
                          Row(
                            children: [
                              GestureDetector(
                                  onTap: () {
                                    decrementCounter2();
                                  },
                                  child: Image.asset(
                                    AssetImagePaths.minusIcon,
                                    height: SizeFile.height20,
                                    width: SizeFile.height20,
                                  )),
                              const SizedBox(width: SizeFile.height7),
                              Obx(
                                () => Text("$item2",
                                    style: const TextStyle(
                                        color: ColorFile.onBordingColor,
                                        fontFamily: satoshiBold,
                                        fontWeight: FontWeight.w500,
                                        fontSize: SizeFile.height16)),
                              ),
                              const SizedBox(width: SizeFile.height7),
                              GestureDetector(
                                  onTap: () {
                                    incrementCounter2();
                                  },
                                  child: Image.asset(
                                    AssetImagePaths.plushIcon,
                                    height: SizeFile.height20,
                                    width: SizeFile.height20,
                                  )),
                            ],
                          )
                        ],
                      ),
                      const SizedBox(height: SizeFile.height24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(
                                  text: const TextSpan(
                                      text: StringConfig.infant,
                                      style: TextStyle(
                                          decorationColor:
                                              ColorFile.onBordingColor,
                                          color: ColorFile.onBordingColor,
                                          fontFamily: satoshiMedium,
                                          fontWeight: FontWeight.w500,
                                          fontSize: SizeFile.height16),
                                      children: [
                                    TextSpan(
                                        text: StringConfig.y212yrs,
                                        style: TextStyle(
                                            decorationColor:
                                                ColorFile.onBordingColor,
                                            color: ColorFile.onBording2Color,
                                            fontFamily: satoshiRegular,
                                            fontWeight: FontWeight.w500,
                                            fontSize: SizeFile.height16))
                                  ])),
                              const SizedBox(height: SizeFile.height2),
                              const Text(StringConfig.onTheDayOfTravel,
                                  style: TextStyle(
                                      color: ColorFile.orContinue,
                                      fontFamily: satoshiRegular,
                                      fontWeight: FontWeight.w400,
                                      fontSize: SizeFile.height12)),
                            ],
                          ),
                          Row(
                            children: [
                              GestureDetector(
                                  onTap: () {
                                    decrementCounter3();
                                  },
                                  child: Image.asset(
                                    AssetImagePaths.minusIcon,
                                    height: SizeFile.height20,
                                    width: SizeFile.height20,
                                  )),
                              const SizedBox(width: SizeFile.height7),
                              Obx(
                                () => Text("$item3",
                                    style: const TextStyle(
                                        color: ColorFile.onBordingColor,
                                        fontFamily: satoshiBold,
                                        fontWeight: FontWeight.w500,
                                        fontSize: SizeFile.height16)),
                              ),
                              const SizedBox(width: SizeFile.height7),
                              GestureDetector(
                                  onTap: () {
                                    incrementCounter3();
                                  },
                                  child: Image.asset(AssetImagePaths.plushIcon,
                                      height: SizeFile.height20,
                                      width: SizeFile.height20)),
                            ],
                          )
                        ],
                      ),
                      const SizedBox(height: SizeFile.height24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                                // Get.back();
                              },
                              child: ShortButton(
                                text: StringConfig.cancel,
                                textColor: ColorFile.onBordingColor,
                                buttonColor:
                                    ColorFile.appColor.withOpacity(0.15),
                              )),
                          GestureDetector(
                              onTap: () {
                                Get.back();
                              },
                              child: ShortButton(
                                text: StringConfig.apply,
                                textColor: ColorFile.whiteColor,
                                buttonColor: ColorFile.appColor,
                              )),
                        ],
                      ),
                      // const SizedBox(height: 200),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
      },
    );
  }
}
