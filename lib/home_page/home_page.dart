import 'package:flutter/material.dart';
import 'package:flutter_application_grebenyuk/constants/main_page_text.dart';
import 'package:flutter_application_grebenyuk/homeworks/five/homework_five_screen.dart';
import 'package:flutter_application_grebenyuk/screens/profile_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(HomePageText.appBarTitle),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              HomePageText.welcomeText,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, ProfileScreen.routeName);
              },
              child: const Text(HomePageText.goToProfileButton),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, HomeworkFiveScreen.routeName);
              },
              child: const Text(HomePageText.goToHomeworkFiveButton),
            ),
          ],
        ),
      ),
    );
  }
}
