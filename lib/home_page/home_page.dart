import 'package:flutter/material.dart';
import 'package:flutter_application_grebenyuk/constants/dimensions.dart';
import 'package:flutter_application_grebenyuk/constants/text_styles.dart';
import 'package:flutter_application_grebenyuk/constants/ui_texts.dart';
import 'package:flutter_application_grebenyuk/homeworks/eight/homework_eight_screen.dart';
import 'package:flutter_application_grebenyuk/homeworks/five/homework_five_screen.dart';
import 'package:flutter_application_grebenyuk/homeworks/six/profile_screen.dart';
import 'package:flutter_application_grebenyuk/homeworks/seven/homework_seven_screen.dart';
import 'package:flutter_application_grebenyuk/homeworks/nine/screens/homework_nine_screen.dart';
import 'package:flutter_application_grebenyuk/lessons_dart/screens/dart_solutions_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(HomeScreenTexts.appBarTitle),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              HomeScreenTexts.welcomeText,
              style: AppTextStyles.homeWelcome,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppDimensions.gap20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, ProfileScreen.routeName);
              },
              child: const Text(HomeScreenTexts.goToProfileButton),
            ),
            const SizedBox(height: AppDimensions.gap20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, DartSolutionsScreen.routeName);
              },
              child: const Text(HomeScreenTexts.goToDartSolutionsButton),
            ),
            const SizedBox(height: AppDimensions.gap20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, HomeworkFiveScreen.routeName);
              },
              child: const Text(HomeScreenTexts.goToHomeworkFiveButton),
            ),
            const SizedBox(height: AppDimensions.gap20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, HomeworkSevenScreen.routeName);
              },
              child: const Text(HomeScreenTexts.goToHomeworkSevenButton),
            ),
            const SizedBox(height: AppDimensions.gap20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, HomeworkEightScreen.routeName);
              },
              child: const Text(HomeScreenTexts.goToHomeworkEightButton),
            ),
            const SizedBox(height: AppDimensions.gap20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, HomeworkNineScreen.routeName);
              },
              child: const Text(HomeScreenTexts.goToHomeworkNineButton),
            ),
          ],
        ),
      ),
    );
  }
}
