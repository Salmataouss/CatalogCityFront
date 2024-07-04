import 'package:flutter/material.dart';

import '../../util/asset_image_paths.dart';
import '../../util/colors.dart';
import '../../util/size_config.dart';

Widget inputFieldText(
    {required TextEditingController controller,
    required String? Function(String?) validator,
    required String prefixIconPath,
    String? hintText,
    TextInputType? keyboardType}) {
  return TextFormField(
    controller: controller,
    keyboardType: keyboardType,
    autovalidateMode: AutovalidateMode.onUserInteraction,
    validator: (value) => validator(value),
    decoration: InputDecoration(
      isDense: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(
          SizeFile.height8,
        ),
      ),
      hintText: hintText,
      hintStyle: const TextStyle(
          fontSize: SizeFile.height14, color: ColorFile.orContinue),
      prefixIcon: Padding(
        padding: const EdgeInsets.all(SizeFile.height12),
        child: Image.asset(
          prefixIconPath,
          height: SizeFile.height12,
          width: SizeFile.height15,
        ),
      ),
    ),
  );
}

Widget editFieldText(
    {required TextEditingController controller,
    required String? Function(String?) validator,
    String? hintText,
    TextInputType? keyboardType}) {
  return TextFormField(
    controller: controller,
    keyboardType: keyboardType,
    autovalidateMode: AutovalidateMode.onUserInteraction,
    validator: (value) => validator(value),
    decoration: InputDecoration(
      isDense: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(
          SizeFile.height8,
        ),
      ),
      hintText: hintText,
      hintStyle: const TextStyle(
          fontSize: SizeFile.height14, color: ColorFile.orContinue),
    ),
  );
}

Widget passwordFieldText(
    {required TextEditingController controller,
    required String? Function(String?) validator,
    required String prefixIconPath,
    required void Function() onTap,
    required bool isVisible,
    String? hintText,
    TextInputType? keyboardType}) {
  return TextFormField(
    controller: controller,
    keyboardType: keyboardType,
    autovalidateMode: AutovalidateMode.onUserInteraction,
    obscureText: !isVisible,
    validator: (value) => validator(value),
    decoration: InputDecoration(
      isDense: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(
          SizeFile.height8,
        ),
      ),
      hintText: hintText,
      hintStyle: const TextStyle(
          fontSize: SizeFile.height14, color: ColorFile.orContinue),
      prefixIcon: Padding(
        padding: const EdgeInsets.all(SizeFile.height12),
        child: Image.asset(
          prefixIconPath,
          height: SizeFile.height12,
          width: SizeFile.height15,
        ),
      ),
      suffixIcon: GestureDetector(
        onTap: () => onTap(),
        child: isVisible
            ? Padding(
                padding: const EdgeInsets.all(SizeFile.height12),
                child: Image.asset(
                  AssetImagePaths.passwordVisible,
                  height: SizeFile.height20,
                  width: SizeFile.height20,
                ),
              )
            : Padding(
                padding: const EdgeInsets.all(SizeFile.height12),
                child: Image.asset(
                  AssetImagePaths.passwordNotVisible,
                  height: SizeFile.height20,
                  width: SizeFile.height20,
                ),
              ),
      ),
    ),
  );
}
