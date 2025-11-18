import 'package:flutter/material.dart';
import 'package:flutter_application_grebenyuk/constants/colors.dart';
import 'package:flutter_application_grebenyuk/home_page/home_page.dart';
import 'package:flutter_application_grebenyuk/homeworks/five/homework_five_screen.dart';
import 'package:flutter_application_grebenyuk/screens/contacts_screen.dart';
import 'package:flutter_application_grebenyuk/screens/profile_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: MainPageColors.backgroundLight,
        ),
      ),
      initialRoute: HomeworkFiveScreen.routeName,
      routes: {
        HomeScreen.routeName: (context) => const HomeScreen(),
        ProfileScreen.routeName: (context) => const ProfileScreen(),
        ContactsScreen.routeName: (context) => const ContactsScreen(),
        HomeworkFiveScreen.routeName: (context) => const HomeworkFiveScreen(),
      },
    );
  }
}
