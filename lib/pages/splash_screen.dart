import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:traveltoken/controllers/sign_in_controller.dart';
import 'package:traveltoken/pages/home_page.dart';
import 'package:traveltoken/pages/sign_in_page.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        final isAuthenticated =
            await context.read<SignInController>().isUserAuthenticated();
        if (isAuthenticated) {
          if (!context.mounted) return;
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => const HomePage(),
          ));
        } else {
          if (!context.mounted) return;
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => const SignInPage(),
          ));
        }
      },
    );
    return const Scaffold();
  }
}
