import 'package:flutter/material.dart';
import 'package:flutter_application_grebenyuk/constants/colors.dart';
import 'package:flutter_application_grebenyuk/home_page/home_page.dart';
import 'package:flutter_application_grebenyuk/homeworks/home_work_10/async_api/multi_stage_async_api_screen.dart';
import 'package:flutter_application_grebenyuk/homeworks/home_work_10/async_chat_bot/asycn_chat_bot.dart';
import 'package:flutter_application_grebenyuk/homeworks/home_work_10/async_real_time_data/async_rea_time_call_to_api.dart';
import 'package:flutter_application_grebenyuk/homeworks/home_work_10/async_timer/count_down_timer.dart';
import 'package:flutter_application_grebenyuk/homeworks/home_work_11/eleven_hw_page.dart';
import 'package:flutter_application_grebenyuk/homeworks/home_work_10/ten_page.dart';
import 'package:flutter_application_grebenyuk/homeworks/home_work_12/home_work_12.dart';
import 'package:flutter_application_grebenyuk/homeworks/home_work_8/homework_eight_screen.dart';
import 'package:flutter_application_grebenyuk/homeworks/home_work_5/homework_five_screen.dart';
import 'package:flutter_application_grebenyuk/homeworks/home_work_6/contacts_screen.dart';
import 'package:flutter_application_grebenyuk/homeworks/home_work_6/profile_screen.dart';
import 'package:flutter_application_grebenyuk/homeworks/home_work_7/homework_seven_screen.dart';
import 'package:flutter_application_grebenyuk/homeworks/home_work_9/screens/homework_nine_screen.dart';
import 'package:flutter_application_grebenyuk/lessons_dart/screens/dart_solutions_screen.dart';

class WebAcademyHomeWorkApp extends StatelessWidget {
  const WebAcademyHomeWorkApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.backgroundLight),
      ),
      initialRoute: HomeScreen.routeName,
      routes: {
        HomeScreen.routeName: (context) => const HomeScreen(),
        ProfileScreen.routeName: (context) => const ProfileScreen(),
        ContactsScreen.routeName: (context) => const ContactsScreen(),
        HomeworkFiveScreen.routeName: (context) => const HomeworkFiveScreen(),
        HomeworkSevenScreen.routeName: (context) => const HomeworkSevenScreen(),
        HomeworkEightScreen.routeName: (context) => const HomeworkEightScreen(),
        HomeworkNineScreen.routeName: (context) => const HomeworkNineScreen(),
        DartSolutionsScreen.routeName: (context) => const DartSolutionsScreen(),
        AsyncChatBot.routeName: (context) => const AsyncChatBot(),
        TenPage.routeName: (context) => const TenPage(),
        CountDownTimer.routeName: (context) => const CountDownTimer(),
        AsyncReaTimeCallToApi.routeName:
            (context) => const AsyncReaTimeCallToApi(),
        MultiStageAsyncApiScreen.routeName:
            (context) => const MultiStageAsyncApiScreen(),
        ElevenHwPage.routeName: (context) => const ElevenHwPage(),
        HomeWork12.routeName: (context) => const HomeWork12(),
      },
    );
  }
}
