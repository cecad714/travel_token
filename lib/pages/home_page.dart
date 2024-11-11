import 'package:flutter/material.dart';
import 'package:traveltoken/pages/create_group_page.dart';
import 'package:traveltoken/pages/summary_list_page.dart';
import 'package:traveltoken/widgets/home_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: index == 2 ? const SummaryListPage() : const ExpenseListWidget(),
      ),
      bottomNavigationBar: BottomNavigationBar(
          selectedFontSize: 0,
          unselectedFontSize: 0,
          selectedItemColor: Colors.blue,
          // unselectedItemColor: Colors.grey, // Set unselected item color
          currentIndex: index, // Set the current index
          onTap: (value) {
            if (value == 1) {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const CreateGroupPage(),
              ));
            } else {
              setState(() {
                index = value;
              });
            }
          },
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.add_circle,
                size: 35,
                color: Colors.black,
              ),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.menu),
              label: "",
            ),
          ]),
    );
  }
}
