import 'package:flutter/material.dart';
import 'package:flutter_application_grebenyuk/constants/colors.dart';
import 'package:flutter_application_grebenyuk/constants/dimensions.dart';
import 'package:flutter_application_grebenyuk/constants/text_styles.dart';
import 'package:flutter_application_grebenyuk/constants/ui_texts.dart';
import 'package:flutter_application_grebenyuk/widgets/app_scaffold.dart';

class HomeworkFiveScreen extends StatelessWidget {
  const HomeworkFiveScreen({super.key});

  static const routeName = '/homework-five';

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: HomeworkFiveTexts.appBarTitle,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppDimensions.paddingDefault),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              HomeworkFiveTexts.sectionTitle,
              style: AppTextStyles.homeworkFiveTitle,
            ),
            const SizedBox(height: AppDimensions.gap20),
            buildWidget(HomeworkFiveTexts.firstImageUrl),
            const SizedBox(height: AppDimensions.gap20),
            buildWidget(HomeworkFiveTexts.secondImageUrl),
            const SizedBox(height: AppDimensions.gap20),
            _buildAssetWidget(),
            const SizedBox(height: AppDimensions.gap20),
            const Text(
              HomeworkFiveTexts.highlightText,
              style: AppTextStyles.homeworkFiveNote,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildWidget(String imageUrl) {
    return Container(
      padding: const EdgeInsets.all(AppDimensions.imagePadding),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.borderGrey),
        borderRadius: BorderRadius.circular(AppDimensions.borderRadiusSmall),
      ),
      child: Image.network(
        imageUrl,
        height: AppDimensions.squareImage,
        width: AppDimensions.squareImage,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildAssetWidget() {
    return Container(
      padding: const EdgeInsets.all(AppDimensions.imagePadding),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.borderGrey),
        borderRadius: BorderRadius.circular(AppDimensions.borderRadiusSmall),
        boxShadow: const [
          BoxShadow(
            color: AppColors.black12,
            blurRadius: AppDimensions.blurRadiusSmall,
            offset: Offset(0, AppDimensions.shadowOffsetY),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppDimensions.borderRadiusSmall),
        child: Image.asset(
          HomeworkFiveTexts.assetImagePath,
          height: AppDimensions.squareImage,
          width: AppDimensions.squareImage,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
