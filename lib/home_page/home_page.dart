import 'package:flutter/material.dart';
import 'package:flutter_application_grebenyuk/constants/dimensions.dart';
import 'package:flutter_application_grebenyuk/constants/text_styles.dart';
import 'package:flutter_application_grebenyuk/constants/ui_texts.dart';
import 'package:flutter_application_grebenyuk/homeworks/home_work_13/home_work_13.dart';
import 'package:flutter_application_grebenyuk/homeworks/home_work_11/eleven_hw_page.dart';
import 'package:flutter_application_grebenyuk/homeworks/home_work_10/ten_page.dart';
import 'package:flutter_application_grebenyuk/homeworks/home_work_12/home_work_12.dart';
import 'package:flutter_application_grebenyuk/homeworks/home_work_8/homework_eight_screen.dart';
import 'package:flutter_application_grebenyuk/homeworks/home_work_5/homework_five_screen.dart';
import 'package:flutter_application_grebenyuk/homeworks/home_work_6/profile_screen.dart';
import 'package:flutter_application_grebenyuk/homeworks/home_work_7/homework_seven_screen.dart';
import 'package:flutter_application_grebenyuk/homeworks/home_work_9/screens/homework_nine_screen.dart';
import 'package:flutter_application_grebenyuk/lessons_dart/screens/dart_solutions_screen.dart';
import 'package:flutter_application_grebenyuk/widgets/app_scaffold.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const routeName = '/';
  static final List<_HomeButtonData> _buttons = [
    const _HomeButtonData(
      title: HomeScreenTexts.goToProfileButton,
      routeName: ProfileScreen.routeName,
    ),
    const _HomeButtonData(
      title: HomeScreenTexts.goToDartSolutionsButton,
      routeName: DartSolutionsScreen.routeName,
    ),
    const _HomeButtonData(
      title: HomeScreenTexts.goToHomeworkFiveButton,
      routeName: HomeworkFiveScreen.routeName,
    ),
    const _HomeButtonData(
      title: HomeScreenTexts.goToHomeworkSevenButton,
      routeName: HomeworkSevenScreen.routeName,
    ),
    const _HomeButtonData(
      title: HomeScreenTexts.goToHomeworkEightButton,
      routeName: HomeworkEightScreen.routeName,
    ),
    const _HomeButtonData(
      title: HomeScreenTexts.goToHomeworkNineButton,
      routeName: HomeworkNineScreen.routeName,
    ),
    const _HomeButtonData(
      title: HomeScreenTexts.goToHomeworkTenButton,
      routeName: TenPage.routeName,
    ),
    const _HomeButtonData(
      title: HomeScreenTexts.goToHomeworkElevenButton,
      routeName: ElevenHwPage.routeName,
    ),
    const _HomeButtonData(
      title: HomeScreenTexts.goToHomeworkTwelveButton,
      routeName: HomeWork12.routeName,
    ),
    const _HomeButtonData(
      title: HomeScreenTexts.goToFinanceTrackerButton,
      routeName: HomeWork13.routeName,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      titleWidget: const Text(
        HomeScreenTexts.welcomeText,
        style: AppTextStyles.homeWelcome,
        textAlign: TextAlign.center,
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppDimensions.gap20),
        child: GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: AppDimensions.gap20,
          crossAxisSpacing: AppDimensions.gap20,
          children:
              _buttons
                  .map(
                    (button) => ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            AppDimensions.borderRadiusSmall,
                          ),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, button.routeName);
                      },
                      child: Text(
                        button.title,
                        textAlign: TextAlign.center,
                        style: AppTextStyles.homeButton,
                      ),
                    ),
                  )
                  .toList(),
        ),
      ),
    );
  }
}

class _HomeButtonData {
  const _HomeButtonData({required this.title, required this.routeName});

  final String title;
  final String routeName;
}
