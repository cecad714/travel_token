import 'package:flutter/material.dart';
import 'package:traveltoken/constant/app_color.dart';
import 'package:traveltoken/constant/app_size.dart';

class TextFieldWidget extends StatelessWidget {
  final String hintText;
  final void Function(String)? onChanged;
  final void Function()? onTap;
  final TextEditingController? textEditingController;
  final TextInputType? keyboardType;
  final bool isReadOnly;
  const TextFieldWidget(
      {super.key,
      required this.hintText,
      this.onChanged,
      this.onTap,
      this.isReadOnly = false,
      this.textEditingController,
      this.keyboardType});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppSize.appSize37,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: AppColor.formFieldFill),
      child: TextFormField(
        style: const TextStyle(color: Colors.white),
        keyboardType: keyboardType,
        onChanged: onChanged,
        controller: textEditingController,
        onTap: onTap,
        readOnly: isReadOnly,
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hintText,
            contentPadding: const EdgeInsets.only(left: 10),
            hintStyle: const TextStyle(
              color: Colors.white,
              fontSize: AppFontSize.font16,
            )),
      ),
    );
  }
}
