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
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.padding8),
        child: Stack(
          children: [
            SizedBox(
              height: 150,
              width: double.infinity,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(AppBorderRadius.radius6),
                child: Image.asset(
                  "assets/Rectangle.png",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              height: 150,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppBorderRadius.radius6),
                  gradient: const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color.fromRGBO(0, 0, 0, 0.58),
                        Color.fromRGBO(0, 0, 0, 1),
                      ],
                      stops: [
                        0.0,
                        1.0
                      ])),
            ),
            const Padding(
              padding: const EdgeInsets.all(19.0),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppString.expenses,
                    style: TextStyle(
                        fontFamily: AppFonts.rubikFont,
                        fontSize: AppFontSize.font24,
                        color: AppColor.whiteColor,
                        fontWeight: FontWeight.w700),
                  ),
                  Text(
                    "24-10-2024",
                    style: TextStyle(
                      fontFamily: AppFonts.inter,
                      fontSize: AppFontSize.font10,
                      color: AppColor.dateColor,
                    ),
                  ),
                  SizedBox(
                    height: AppSize.appSize21,
                  ),
                  Text(
                    "\$5000",
                    style: TextStyle(
                        fontFamily: AppFonts.inter,
                        fontSize: AppFontSize.font20,
                        color: AppColor.whiteColor,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 15,
              right: 18,
              child: Container(
                decoration: BoxDecoration(
                    color: AppColor.whiteColor,
                    borderRadius:
                        BorderRadius.circular(AppBorderRadius.radius24)),
                padding: const EdgeInsets.all(AppPadding.padding3),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                      color: AppColor.homePageDateColor,
                      borderRadius:
                          BorderRadius.circular(AppBorderRadius.radius24)),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppPadding.padding28,
                      vertical: AppPadding.padding6,
                    ),
                    child: Text(
                      "View",
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
    );
  }
}
