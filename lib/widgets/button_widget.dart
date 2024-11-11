import 'package:flutter/material.dart';
import 'package:traveltoken/constant/app_color.dart';
import 'package:traveltoken/constant/app_fonts.dart';
import 'package:traveltoken/constant/app_size.dart';

class ButtonWidget extends StatelessWidget {
  final String text;
  final void Function()? onTap;
  const ButtonWidget({
    required this.text,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: AppPadding.padding14,
        ),
        width: MediaQuery.sizeOf(context).width,
        decoration: const BoxDecoration(
            color: AppColor.signInButtonBackgroundColor,
            borderRadius:
                BorderRadius.all(Radius.circular(AppSize.buttonBorderRadius))),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: AppColor.buttonTextColor,
            fontSize: AppFontSize.font16,
            fontFamily: AppFonts.rubikFont,
          ),
        ),
      ),
    );
  }
}
