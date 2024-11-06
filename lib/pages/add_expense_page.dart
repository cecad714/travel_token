import 'package:flutter/material.dart';
import 'package:traveltoken/constant/app_color.dart';
import 'package:traveltoken/constant/app_fonts.dart';
import 'package:traveltoken/constant/app_size.dart';
import 'package:traveltoken/constant/app_string.dart';

class AddExpensePage extends StatelessWidget {
  const AddExpensePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //add people

              const Text(
                AppString.addExpense,
                style: TextStyle(
                  fontFamily: AppFonts.raleWay,
                  fontSize: AppSize.appSize28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              //choose people
              const Text(
                AppString.addExpenseGroup,
                style: TextStyle(
                  fontFamily: AppFonts.raleWay,
                  fontSize: AppFontSize.font16,
                  fontWeight: FontWeight.w500,
                ),
              ),

              const SizedBox(
                height: AppSize.appSize40,
              ),
              //Description
              const Text(
                AppString.description,
                style: TextStyle(
                  fontFamily: AppFonts.raleWay,
                  fontSize: AppFontSize.font14,
                  fontWeight: FontWeight.w500,
                ),
              ),

              Container(
                height: AppSize.appSize37,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: AppColor.formFieldFill),
                child: const TextField(
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: AppString.required,
                      contentPadding: EdgeInsets.only(left: 10),
                      hintStyle: TextStyle(
                        color: AppColor.hintColor,
                        fontSize: AppFontSize.font16,
                      )),
                ),
              ),

              const SizedBox(
                height: AppSize.appSize13,
              ),
              //Amount
              const Text(
                AppString.amount,
                style: TextStyle(
                  fontFamily: AppFonts.raleWay,
                  fontSize: AppFontSize.font14,
                  fontWeight: FontWeight.w500,
                ),
              ),

              Container(
                height: AppSize.appSize37,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: AppColor.formFieldFill),
                child: const TextField(
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: AppString.required,
                      contentPadding: EdgeInsets.only(left: 10),
                      hintStyle: TextStyle(
                        color: AppColor.hintColor,
                        fontSize: AppFontSize.font16,
                      )),
                ),
              ),
              const SizedBox(
                height: AppSize.appSize13,
              ),

              const Spacer(),

              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: AppPadding.padding14,
                ),
                width: MediaQuery.sizeOf(context).width,
                decoration: const BoxDecoration(
                    color: AppColor.signInButtonBackgroundColor,
                    borderRadius: BorderRadius.all(
                        Radius.circular(AppSize.buttonBorderRadius))),
                child: const Text(
                  AppString.addExpense,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColor.buttonTextColor,
                    fontSize: AppFontSize.font16,
                    fontFamily: AppFonts.rubikFont,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
