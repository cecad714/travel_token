import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:traveltoken/controllers/add_expense_controller.dart';
import 'package:traveltoken/controllers/create_group_controller.dart';
import 'package:traveltoken/controllers/group_page_controller.dart';
import 'package:traveltoken/controllers/home_page_controller.dart';
import 'package:traveltoken/controllers/sign_in_controller.dart';
import 'package:traveltoken/controllers/summary_controller.dart';
import 'package:traveltoken/controllers/summary_list_page_controller.dart';
import 'package:traveltoken/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:traveltoken/pages/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<SignInController>(
          create: (_) => SignInController()),
      ChangeNotifierProvider<CreateGroupController>(
          create: (_) => CreateGroupController()),
      ChangeNotifierProvider<GroupPageController>(
          create: (_) => GroupPageController()),
      ChangeNotifierProvider<HomePageController>(
          create: (_) => HomePageController()),
      ChangeNotifierProvider<AddExpenseController>(
          create: (_) => AddExpenseController()),
      ChangeNotifierProvider<SummaryController>(
          create: (_) => SummaryController()),
      ChangeNotifierProvider<SummaryListPageController>(
          create: (_) => SummaryListPageController()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Travel Token',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
