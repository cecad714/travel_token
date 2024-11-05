import 'package:flutter/material.dart';
import 'package:traveltoken/constant/app_color.dart';
import 'package:traveltoken/constant/app_fonts.dart';
import 'package:traveltoken/constant/app_size.dart';
import 'package:traveltoken/constant/app_string.dart';

class HomeCardWidget extends StatelessWidget {
  const HomeCardWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppBorderRadius.radius15)),
      child: SizedBox(
        height: AppSize.appSize200,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(AppPadding.padding8),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 150,
                    width: double.infinity,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(AppPadding.padding6),
                      child: Image.asset(
                        "assets/Rectangle.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const Text(
                    AppString.expenses,
                    style: TextStyle(
                      fontFamily: AppFonts.rubikFont,
                      fontSize: AppFontSize.font14,
                      color: AppColor.homePageExpenseNameColor,
                    ),
                  ),
                  const Text(
                    "24-10-2024",
                    style: TextStyle(
                      fontFamily: AppFonts.inter,
                      fontSize: AppFontSize.font10,
                      color: AppColor.homePageDateColor,
                    ),
                  ),
                ],
              ),
              Positioned(
                bottom: 15,
                right: 18,
                child: Container(
                  decoration: BoxDecoration(
                      color: AppColor.whiteColor,
                      borderRadius:
                          BorderRadius.circular(AppBorderRadius.radius15)),
                  padding: const EdgeInsets.all(AppPadding.padding3),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                        color: AppColor.homePageDateColor,
                        borderRadius:
                            BorderRadius.circular(AppBorderRadius.radius15)),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: AppPadding.padding22,
                        vertical: AppPadding.padding6,
                      ),
                      child: Text(
                        "\$78686",
                        style: TextStyle(
                          color: AppColor.whiteColor,
                          fontFamily: AppFonts.montserratFont,
                          fontSize: AppFontSize.font10,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
