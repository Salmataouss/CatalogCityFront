import 'package:flutter/material.dart';

// UTILS IMPORTS
import '../../util/colors.dart';
import '../../util/size_config.dart';

class LoadingIconButton extends StatelessWidget {
  const LoadingIconButton(
      {super.key,
      required this.iconPath,
      required this.onPressed,
      required this.isLoading});

  final String iconPath;
  final void Function() onPressed;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => onPressed(),
      icon: isLoading
          ? Container(
              width: SizeFile.height35,
              height: SizeFile.height35,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: CircularProgressIndicator(),
              ))
          : Image.asset(
              iconPath,
              color: ColorFile.whiteColor,
              height: SizeFile.height36,
              width: SizeFile.height36,
            ),
    );
  }
}
