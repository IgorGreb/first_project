import 'package:flutter/material.dart';

import 'package:flutter_application_grebenyuk/constants/colors.dart';

class AppTextStyles {
  static const TextStyle homeWelcome =
      TextStyle(fontSize: 22, fontWeight: FontWeight.bold);

  static const TextStyle profileInitials =
      TextStyle(fontSize: 32, fontWeight: FontWeight.bold);

  static const TextStyle profileName =
      TextStyle(fontSize: 20, fontWeight: FontWeight.bold);

  static const TextStyle profileInfo = TextStyle(fontSize: 16);

  static const TextStyle contactsName =
      TextStyle(fontSize: 18, fontWeight: FontWeight.bold);

  static const TextStyle contactsPhone = TextStyle(fontSize: 16);

  static const TextStyle homeworkFiveTitle =
      TextStyle(fontSize: 20, fontWeight: FontWeight.bold);

  static const TextStyle homeworkFiveNote = TextStyle(
    fontSize: 20,
    color: AppColors.accentRed,
    fontStyle: FontStyle.italic,
  );
  static const TextStyle homeButton =
      TextStyle(fontSize: 16, fontWeight: FontWeight.w600);

  static TextStyle profileHeaderName(double fontSize) => TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.bold,
      );

  static TextStyle profileHeaderDescription(double fontSize) => TextStyle(
        fontSize: fontSize,
        color: AppColors.grey600,
      );

  static TextStyle profileAvatarInitial(double fontSize) => TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.bold,
      );

  static TextStyle homeworkSevenHeading(double fontSize) => TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.bold,
      );

  static TextStyle homeworkSevenAbout(double fontSize) => TextStyle(
        fontSize: fontSize,
        height: 1.4,
      );

  static TextStyle statisticsValue(double fontSize) => TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.bold,
      );

  static TextStyle statisticsLabel(double fontSize) => TextStyle(
        fontSize: fontSize,
        color: AppColors.grey700,
      );

  static const TextStyle todoSectionTitle =
      TextStyle(fontSize: 18, fontWeight: FontWeight.bold);

  static const TextStyle todoTileTitle =
      TextStyle(fontSize: 16, fontWeight: FontWeight.w600);

  static const TextStyle dartLessonTitle =
      TextStyle(fontSize: 18, fontWeight: FontWeight.bold);

  static const TextStyle dartLessonSubtitle = TextStyle(fontSize: 14);

  static const TextStyle dartTaskTitle =
      TextStyle(fontSize: 16, fontWeight: FontWeight.w600);

  static TextStyle dartTaskDescription(Color color) => TextStyle(
        fontSize: 14,
        color: color,
        height: 1.3,
      );

  static const TextStyle dartCode =
      TextStyle(fontFamily: 'monospace', fontSize: 13, height: 1.35);
}
