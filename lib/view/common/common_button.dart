import 'package:flutter/material.dart';
import 'package:catalog_city_project/util/font_family.dart';
import 'package:catalog_city_project/util/size_config.dart';
import '../../util/colors.dart';

// ignore: must_be_immutable
class ButtonCommon extends StatelessWidget {
  String? text;
  VoidCallback? onTap;
  Color? textColor;
  Color? buttonColor;
  bool? isLoading;
  ButtonCommon({
    super.key,
    this.isLoading,
    this.text,
    this.buttonColor,
    this.textColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeFile.height52,
      width: double.infinity,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(SizeFile.height8),
        color: buttonColor ?? ColorFile.appColor,
      ),
      child: isLoading != null && isLoading == true
          ? SizedBox(
              width: 20,
              height: 20,
              child: const CircularProgressIndicator(color: Colors.white),
            )
          : Text(
              text!,
              style: TextStyle(
                color: textColor ?? ColorFile.whiteColor,
                fontFamily: satoshiMedium,
                fontWeight: FontWeight.w500,
                fontSize: SizeFile.height18,
              ),
            ),
    );
  }
}

class LoadingButton extends StatelessWidget {
  final bool isLoading;
  final String text;
  final VoidCallback onTap;
  final Color? textColor;
  final Color? buttonColor;

  const LoadingButton({
    super.key,
    required this.isLoading,
    required this.text,
    this.buttonColor,
    this.textColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      style: FilledButton.styleFrom(
        backgroundColor: buttonColor ?? ColorFile.appColor,
        minimumSize: Size.fromHeight(50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onPressed: isLoading ? null : () => onTap(),
      child: isLoading == true
          ? SizedBox(
              width: 20,
              height: 20,
              child: const CircularProgressIndicator(),
            )
          : Text(
              text,
              style: TextStyle(
                color: textColor ?? ColorFile.whiteColor,
                fontFamily: satoshiMedium,
                fontWeight: FontWeight.w500,
                fontSize: SizeFile.height18,
              ),
            ),
    );
  }
}

// ignore: must_be_immutable
class ShortButton extends StatelessWidget {
  String? text;
  Color? textColor;
  Color? buttonColor;
  double? width;
  ShortButton(
      {super.key, this.text, this.textColor, this.buttonColor, this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeFile.height48,
      width: width ?? MediaQuery.of(context).size.width / 2.4,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: buttonColor,
        borderRadius: BorderRadius.circular(SizeFile.height10),
      ),
      child: Text(text ?? "",
          style: TextStyle(
              color: textColor ?? ColorFile.whiteColor,
              fontFamily: satoshiMedium,
              fontWeight: FontWeight.w500,
              fontSize: SizeFile.height18)),
    );
  }
}
