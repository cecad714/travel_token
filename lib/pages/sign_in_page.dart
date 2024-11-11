import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:traveltoken/constant/app_color.dart';
import 'package:traveltoken/constant/app_fonts.dart';
import 'package:traveltoken/constant/app_image.dart';
import 'package:traveltoken/constant/app_size.dart';
import 'package:traveltoken/constant/app_string.dart';
import 'package:traveltoken/controllers/sign_in_controller.dart';
import 'package:traveltoken/pages/home_page.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          //background image
          SizedBox(
            height: MediaQuery.sizeOf(context).height,
            width: MediaQuery.sizeOf(context).width,
            child: Image.asset(
              AppImages.signInBackgroundImg,
            ),
          ),

          SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * .20,
                ),
                SizedBox(
                  height: AppSize.signInButtonHeight,
                  width: AppSize.logoImageWidth,
                  child: Image.asset(
                    height: AppSize.logoImageHeight,
                    width: AppSize.logoImageWidth,
                    AppImages.signLogo,
                    fit: BoxFit.cover,
                  ),
                ),
                const Text(
                  AppString.easySplits,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: AppFonts.rubikFont,
                  ),
                ),
              ],
            ),
          ),

          //elevated button

          Positioned(
            bottom: MediaQuery.sizeOf(context).height * .10,
            left: 0,
            right: 0,
            child: GestureDetector(
              onTap: () async {
                final isAuthenticated =
                    await context.read<SignInController>().googleSignIn();
                if (isAuthenticated) {
                  if (!context.mounted) return;
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const HomePage(),
                  ));
                } else {
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).clearSnackBars();
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Something Went Wrong")));
                  }
                }
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppPadding.padding22),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: AppPadding.padding14,
                  ),
                  width: MediaQuery.sizeOf(context).width,
                  decoration: const BoxDecoration(
                      color: AppColor.signInButtonBackgroundColor,
                      borderRadius: BorderRadius.all(
                          Radius.circular(AppSize.buttonBorderRadius))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                          height: AppSize.appSize28,
                          width: AppSize.appSize28,
                          child: Image.asset(AppImages.signInIcon)),
                      const SizedBox(
                        width: AppSize.appSize16,
                      ),
                      const Text(
                        AppString.loginWithGoogle,
                        style: TextStyle(
                          color: AppColor.whiteColor,
                          fontSize: AppFontSize.font16,
                          fontWeight: FontWeight.bold,
                          fontFamily: AppFonts.rubikFont,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          if (context.watch<SignInController>().isLoading)
            const Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}
