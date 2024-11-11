import 'package:flutter/material.dart';
import 'package:traveltoken/constant/app_fonts.dart';
import 'package:traveltoken/constant/app_size.dart';

class TextFieldNameWidget extends StatelessWidget {
  final String text;
  const TextFieldNameWidget({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontFamily: AppFonts.raleWay,
        fontSize: AppFontSize.font14,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
