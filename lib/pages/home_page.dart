import 'package:flutter/material.dart';
import 'package:traveltoken/constant/app_fonts.dart';
import 'package:traveltoken/constant/app_size.dart';
import 'package:traveltoken/constant/app_string.dart';
import 'package:traveltoken/widgets/home_card_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppPadding.padding10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //name

              const Text(
                "${AppString.hi}Arjun",
                style: TextStyle(
                  fontFamily: AppFonts.montserratFont,
                  fontSize: AppFontSize.font32,
                ),
              ),

              const SizedBox(height: AppSize.appSize16),
              //expense
              const Text(
                AppString.expenses,
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontFamily: AppFonts.montserratFont,
                    fontSize: AppFontSize.font18,
                    fontWeight: FontWeight.w600),
              ),
              //listview builder

              Expanded(
                  child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return const HomeCardWidget();
                },
              ))
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
          selectedFontSize: 0,
          unselectedFontSize: 0,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "",
            ),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.add_circle,
                  color: Colors.black,
                  size: 35,
                ),
                label: ""),
            BottomNavigationBarItem(icon: Icon(Icons.menu), label: ""),
          ]),
    );
  }
}
