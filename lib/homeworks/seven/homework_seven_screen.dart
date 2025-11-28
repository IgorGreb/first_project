import 'package:flutter/material.dart';
import 'package:flutter_application_grebenyuk/constants/dimensions.dart';
import 'package:flutter_application_grebenyuk/constants/text_styles.dart';
import 'package:flutter_application_grebenyuk/constants/ui_texts.dart';
import 'package:flutter_application_grebenyuk/homeworks/seven/widgets/profile_header.dart';
import 'package:flutter_application_grebenyuk/homeworks/seven/widgets/user_status.dart';
import 'package:flutter_application_grebenyuk/widgets/app_scaffold.dart';

class HomeworkSevenScreen extends StatelessWidget {
  const HomeworkSevenScreen({super.key});

  static const routeName = '/homework-seven';

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: HomeworkSevenTexts.appBarTitle,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final bool isWide = constraints.maxWidth >= 600;
          final EdgeInsets padding = EdgeInsets.symmetric(
            horizontal:
                isWide ? AppDimensions.gap48 : AppDimensions.gap20,
            vertical: isWide ? AppDimensions.gap32 : AppDimensions.gap20,
          );
          final double sectionSpacing =
              isWide ? AppDimensions.gap32 : AppDimensions.gap20;
          final double dividerSpacing =
              isWide ? AppDimensions.gap24 : AppDimensions.gap16;

          return SingleChildScrollView(
            padding: padding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ProfileHeader(
                  name: HomeworkSevenTexts.profileName,
                  description: HomeworkSevenTexts.profileDescription,
                  isWide: isWide,
                ),
                SizedBox(height: sectionSpacing),
                const Divider(),
                SizedBox(height: dividerSpacing),
                Text(
                  HomeworkSevenTexts.aboutTitle,
                  style:
                      AppTextStyles.homeworkSevenHeading(isWide ? 20 : 18),
                ),
                const SizedBox(height: AppDimensions.gap8),
                Text(
                  HomeworkSevenTexts.aboutDescription,
                  style:
                      AppTextStyles.homeworkSevenAbout(isWide ? 16 : 14),
                ),
                SizedBox(height: sectionSpacing),
                const Divider(),
                SizedBox(height: dividerSpacing),
                UserStatusWidget(projects: 32, followers: 1280, following: 340),
              ],
            ),
          );
        },
      ),
    );
  }
}
