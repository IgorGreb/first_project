import 'package:flutter/material.dart';
import 'package:flutter_application_grebenyuk/constants/colors.dart';
import 'package:flutter_application_grebenyuk/constants/main_page_text.dart';
import 'package:flutter_application_grebenyuk/home_page/home_page.dart';

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
      home: MyHomePage(title: HomePageText.homePageTitleText),
    );
  }
}
