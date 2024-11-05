import 'package:flutter/material.dart';
import 'package:traveltoken/constant/app_color.dart';
import 'package:traveltoken/constant/app_fonts.dart';
import 'package:traveltoken/constant/app_size.dart';
import 'package:traveltoken/constant/app_string.dart';

class AddPeoplePage extends StatelessWidget {
  const AddPeoplePage({super.key});

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
                AppString.addPeople,
                style: TextStyle(
                  fontFamily: AppFonts.raleWay,
                  fontSize: AppSize.appSize28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              //choose people
              const Text(
                AppString.choosePeople,
                style: TextStyle(
                  fontFamily: AppFonts.raleWay,
                  fontSize: AppFontSize.font16,
                  fontWeight: FontWeight.w500,
                ),
              ),

              const SizedBox(
                height: AppSize.appSize40,
              ),
              //Group title
              const Text(
                AppString.groupTitle,
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
                      hintText: "Required",
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
              //Choose Date
              const Text(
                AppString.chooseDate,
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
                      hintText: "Date Picker",
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
              //email id
              const Text(
                AppString.emailId,
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
                      hintText: "Required",
                      contentPadding: EdgeInsets.only(left: 10),
                      hintStyle: TextStyle(
                        color: AppColor.hintColor,
                        fontSize: AppFontSize.font16,
                      )),
                ),
              ),
              //added email

              Expanded(
                  child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: const Text("user@gmail.com"),
                    trailing: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.close,
                          color: Colors.red,
                          size: 25,
                        )),
                  );
                },
              )),

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
                  AppString.createGroup,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColor.whiteColor,
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
