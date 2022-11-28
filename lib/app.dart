import 'package:flutter/material.dart';
import 'package:sampleproject/home_page.dart';
import 'package:sampleproject/profile.dart';
import 'package:sampleproject/screens/search_screen.dart';

import 'app_bar_widget.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  int currentPageIndex = 0;
  double bmi = 0; 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(),
      body: currentPageIndex == 0 ? const HomePage() : currentPageIndex == 1 ? ProfilePage(/*bmi: bmi*/) : SearchScreen(),
      bottomNavigationBar: NavigationBar(
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: "Home"),
          NavigationDestination(icon: Icon(Icons.person), label: 'Profile'),
          NavigationDestination(icon: Icon(Icons.note), label: 'Plan'),
        ],
        backgroundColor: Colors.white,
        onDestinationSelected: (int index) => {
          setState(() => {
            currentPageIndex = index
          })
        },
        selectedIndex: currentPageIndex
      ),
    );
  }
}