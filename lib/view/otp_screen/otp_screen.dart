import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:catalog_city_project/controller/otp_controller.dart';
import 'package:catalog_city_project/util/asset_image_paths.dart';
import 'package:catalog_city_project/util/colors.dart';
import 'package:catalog_city_project/view/common/common_button.dart';
import 'package:catalog_city_project/util/font_family.dart';
import 'package:catalog_city_project/util/size_config.dart';
import 'package:catalog_city_project/util/string_config.dart';
import '../../view/create_new_password/create_new_password_screen.dart';
import '../home_screen/home_screen.dart';

// ignore: must_be_immutable
class OtpScreen extends StatelessWidget {
  final String? status;
  OtpScreen({Key? key, this.status}) : super(key: key);

  final pinPutController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  OtpController otpController = Get.put(OtpController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorFile.whiteColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: SizeFile.height20),
          child: Form(
            key: formKey,
            child: Obx(
              () => Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: SizeFile.height20),
                  GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: SizeFile.height1,
                          top: SizeFile.height20,
                          bottom: SizeFile.height20,
                        ),
                        child: Image.asset(AssetImagePaths.backArrow2,
                            height: SizeFile.height18,
                            width: SizeFile.height18,
                            color: ColorFile.onBordingColor),
                      )),
                  const SizedBox(height: SizeFile.height30),
                  const Text(StringConfig.oTPVerification,
                      style: TextStyle(
                          fontSize: SizeFile.height26,
                          color: ColorFile.onBordingColor,
                          fontWeight: FontWeight.w500,
                          fontFamily: satoshiMedium)),
                  const SizedBox(height: SizeFile.height4),
                  const Text(StringConfig.weVeSendAOneTimePassword,
                      style: TextStyle(
                          fontSize: SizeFile.height14,
                          color: ColorFile.onBording2Color,
                          fontWeight: FontWeight.w400,
                          fontFamily: satoshiRegular)),
                  const SizedBox(height: SizeFile.height30),
                  Center(
                    child: Pinput(
                      defaultPinTheme: defaultPinTheme,
                      controller: pinPutController,
                      validator: (value) {
                        return value != '8255'
                            ? null
                            : "  \u24D8  ${StringConfig.pinIncorrect}";
                      },
                      errorPinTheme: defaultPinTheme.copyBorderWith(
                        border: Border.all(color: ColorFile.canceledColor),
                      ),
                      autofocus: true,
                      errorTextStyle: const TextStyle(
                        fontSize: SizeFile.height12,
                        fontFamily: satoshiRegular,
                        fontWeight: FontWeight.w400,
                        color: ColorFile.canceledColor,
                      ),
                      submittedPinTheme: submittedPinTheme,
                      focusedPinTheme: focusedPinTheme,
                      pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                      showCursor: true,
                      // ignore: avoid_print
                      onCompleted: (pin) => print(pin),
                    ),
                  ),
                  const SizedBox(height: SizeFile.height40),
                  if (!otpController.timerCompleted.value) ...[
                    Center(
                      child: Text(StringConfig.resendCodeIn,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: SizeFile.height14,
                              color: ColorFile.onBording2Color,
                              fontFamily: satoshiRegular)),
                    ),
                    Obx(
                      () => Center(
                        child: Text(otpController.getFormattedTime(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: SizeFile.height14,
                                color: ColorFile.appColor,
                                fontFamily: satoshiBold)),
                      ),
                    ),
                  ] else ...[
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          if (otpController.timerCompleted.value) {
                            pinPutController.clear();
                            otpController.restartTimer();
                          }
                        },
                        child: Text(StringConfig.resendCode,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: SizeFile.height14,
                                color: ColorFile.dividerColor,
                                fontFamily: satoshiBold,
                                fontWeight: FontWeight.w700)),
                      ),
                    )
                  ],
                  const SizedBox(height: SizeFile.height40),
                  GestureDetector(
                    onTap: () {
                      if (formKey.currentState!.validate()) {
                        if (status == "Reset") {
                          Get.to(CreateNewPasswordScreen());
                        } else {
                          Get.to(const HomeScreen());
                        }
                      }
                    },
                    child: ButtonCommon(
                      text: StringConfig.verify,
                      buttonColor: ColorFile.appColor,
                      textColor: ColorFile.whiteColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  static final defaultPinTheme = PinTheme(
    width: SizeFile.height48,
    height: SizeFile.height56,
    margin: const EdgeInsets.only(left: SizeFile.height12),
    textStyle: const TextStyle(
        fontSize: SizeFile.height20,
        color: ColorFile.appColor,
        fontWeight: FontWeight.w400),
    decoration: BoxDecoration(
      border: Border.all(color: const Color.fromRGBO(234, 239, 243, 1)),
      borderRadius: BorderRadius.circular(SizeFile.height8),
    ),
  );
  final focusedPinTheme = defaultPinTheme.copyDecorationWith(
    border: Border.all(color: ColorFile.dividerColor),
    borderRadius: BorderRadius.circular(SizeFile.height8),
  );
  final submittedPinTheme = defaultPinTheme.copyDecorationWith(
    border: Border.all(color: ColorFile.dividerColor),
    borderRadius: BorderRadius.circular(SizeFile.height8),
  );
}
