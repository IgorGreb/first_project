import 'package:flutter/material.dart';

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
        style: TextStyle(fontSize: valueFontSize, fontWeight: FontWeight.bold),
      ),
      const SizedBox(height: 6),
      Text(
        label,
        style: TextStyle(fontSize: labelFontSize, color: Colors.grey[700]),
      ),
    ],
  );
}
