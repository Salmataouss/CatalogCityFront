import 'package:catalog_city_project/view/home_screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:catalog_city_project/controller/sign_up_controller.dart';
import 'package:catalog_city_project/util/asset_image_paths.dart';
import 'package:catalog_city_project/util/colors.dart';
import 'package:catalog_city_project/util/font_family.dart';
import 'package:catalog_city_project/util/size_config.dart';
import 'package:catalog_city_project/util/string_config.dart';
import '../common/common_button.dart';
import '../common/common_text_field.dart';
import '../login_screem/login_screen.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key}) : super(key: key);

  final SignUpController signUpController = Get.put(SignUpController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorFile.whiteColor,
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        backgroundColor: ColorFile.whiteColor,
        elevation: 0,
        leading: GestureDetector(
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
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: TextButton(
              onPressed: () => Get.off(() => HomeScreen()),
              child: Text(
                'Passer',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: SizeFile.height20),
          child: Form(
            key: signUpController.formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: SizeFile.height10),
                const Text(StringConfig.createANewAccount,
                    style: TextStyle(
                        fontSize: SizeFile.height26,
                        color: ColorFile.onBordingColor,
                        fontWeight: FontWeight.w500,
                        fontFamily: satoshiMedium)),
                const SizedBox(height: SizeFile.height4),
                const Text(StringConfig.pleaseEnterYourDetailsAndJoin,
                    style: TextStyle(
                        fontSize: SizeFile.height14,
                        color: ColorFile.onBording2Color,
                        fontFamily: satoshiRegular)),
                const SizedBox(height: SizeFile.height30),
                inputFieldText(
                  controller: signUpController.nameController,
                  validator: signUpController.nameValidator,
                  prefixIconPath: AssetImagePaths.userRounded,
                  hintText: StringConfig.enterName,
                ),
                const SizedBox(height: SizeFile.height20),
                inputFieldText(
                  controller: signUpController.emailController,
                  validator: signUpController.emailValidator,
                  keyboardType: TextInputType.emailAddress,
                  prefixIconPath: AssetImagePaths.emailIcon,
                  hintText: StringConfig.enterEmail,
                ),
                const SizedBox(height: SizeFile.height20),
                Obx(
                  () => passwordFieldText(
                    controller: signUpController.passwordController,
                    onTap: signUpController.signPasswordVisible.toggle,
                    isVisible: signUpController.signPasswordVisible.value,
                    prefixIconPath: AssetImagePaths.passwordLock,
                    validator: signUpController.passwordValidator,
                    hintText: StringConfig.enterPassword,
                  ),
                ),
                const SizedBox(height: SizeFile.height20),
                Obx(
                  () => passwordFieldText(
                    controller: signUpController.confirmPasswordController,
                    onTap: signUpController.signConFirmPasswordVisible.toggle,
                    isVisible:
                        signUpController.signConFirmPasswordVisible.value,
                    prefixIconPath: AssetImagePaths.passwordLock,
                    validator: signUpController.confirmPasswordValidator,
                    hintText: StringConfig.enterConfirmPassword,
                  ),
                ),
                const SizedBox(height: SizeFile.height12),
                const SizedBox(height: SizeFile.height30),
                Obx(
                  () => LoadingButton(
                    onTap: () => signUpController.onSubmit(),
                    isLoading: signUpController.isLoading.value,
                    text: StringConfig.signUp,
                  ),
                ),
                const SizedBox(height: SizeFile.height24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: SizeFile.height1,
                      width: SizeFile.height100,
                      color: ColorFile.lineColor,
                    ),
                    const SizedBox(width: SizeFile.height10),
                    const Text(
                      StringConfig.orContinueWith,
                      style: TextStyle(
                        color: ColorFile.orContinue,
                        fontFamily: satoshiRegular,
                        fontWeight: FontWeight.w500,
                        fontSize: SizeFile.height12,
                      ),
                    ),
                    const SizedBox(width: SizeFile.height10),
                    Container(
                      height: SizeFile.height1,
                      width: SizeFile.height100,
                      color: ColorFile.lineColor,
                    ),
                    // Image.asset(AssetImagePaths.line),
                  ],
                ),
                const SizedBox(height: SizeFile.height24),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: SizeFile.height10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: SizeFile.height44,
                        width: SizeFile.height131,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(SizeFile.size9),
                            color: ColorFile.whiteColor,
                            border:
                                Border.all(color: ColorFile.googleBorderLogo)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              AssetImagePaths.googleLogo,
                              height: SizeFile.height24,
                              width: SizeFile.height24,
                            ),
                            const SizedBox(width: SizeFile.height10),
                            const Text(StringConfig.google,
                                style: TextStyle(
                                  color: ColorFile.onBordingColor,
                                  fontFamily: satoshiRegular,
                                  fontSize: SizeFile.height14,
                                ))
                          ],
                        ),
                      ),
                      const SizedBox(width: SizeFile.height20),
                      Container(
                          height: SizeFile.height44,
                          width: SizeFile.height131,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(SizeFile.size9),
                              color: ColorFile.whiteColor,
                              border: Border.all(
                                  color: ColorFile.googleBorderLogo)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                AssetImagePaths.facebook,
                                height: SizeFile.height24,
                                width: SizeFile.height24,
                              ),
                              const SizedBox(width: SizeFile.height10),
                              const Text(StringConfig.facebook,
                                  style: TextStyle(
                                    color: ColorFile.onBordingColor,
                                    fontFamily: satoshiRegular,
                                    fontSize: SizeFile.height14,
                                  ))
                            ],
                          ))
                    ],
                  ),
                ),
                const SizedBox(height: SizeFile.height30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      StringConfig.alreadyAMember,
                      style: TextStyle(
                          fontFamily: satoshiRegular,
                          fontSize: SizeFile.height14,
                          color: ColorFile.onBording2Color),
                    ),
                    const SizedBox(width: SizeFile.height5),
                    GestureDetector(
                      onTap: () {
                        Get.off(const LoginScreen());
                      },
                      child: const Text(StringConfig.logIn,
                          style: TextStyle(
                              letterSpacing: 0.5,
                              fontFamily: satoshiBold,
                              fontSize: SizeFile.height16,
                              color: ColorFile.appColor)),
                    )
                  ],
                ),
                const SizedBox(height: SizeFile.height10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
