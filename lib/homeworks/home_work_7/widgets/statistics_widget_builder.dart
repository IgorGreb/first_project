import 'package:flutter/material.dart';
import 'package:flutter_application_grebenyuk/constants/dimensions.dart';
import 'package:flutter_application_grebenyuk/constants/text_styles.dart';

Widget buildStatistic(
  String label,
  int value,
  double valueFontSize,
  double labelFontSize,
) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Text(
        value.toString(),
        style: AppTextStyles.statisticsValue(valueFontSize),
      ),
      const SizedBox(height: AppDimensions.gap6),
      Text(
        label,
        style: AppTextStyles.statisticsLabel(labelFontSize),
      ),
    ],
  );
}
