import 'package:flutter/material.dart';
import 'package:flutter_application_grebenyuk/constants/colors.dart';
import 'package:flutter_application_grebenyuk/constants/dimensions.dart';
import 'package:flutter_application_grebenyuk/constants/text_styles.dart';
import 'package:flutter_application_grebenyuk/constants/ui_texts.dart';
import 'package:flutter_application_grebenyuk/lessons_dart/data/dart_tasks_data.dart';
import 'package:flutter_application_grebenyuk/lessons_dart/models/dart_task.dart';
import 'package:flutter_application_grebenyuk/widgets/app_scaffold.dart';

class DartSolutionsScreen extends StatelessWidget {
  const DartSolutionsScreen({super.key});

  static const routeName = '/dart-solutions';

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: DartSolutionsTexts.appBarTitle,
      body: ListView.separated(
        padding: const EdgeInsets.all(AppDimensions.paddingDefault),
        itemCount: dartLessonSections.length,
        separatorBuilder: (_, __) =>
            const SizedBox(height: AppDimensions.gap16),
        itemBuilder: (context, index) {
          final section = dartLessonSections[index];
          return _DartLessonCard(section: section);
        },
      ),
    );
  }
}

class _DartLessonCard extends StatelessWidget {
  const _DartLessonCard({required this.section});

  final DartLessonSection section;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.borderRadiusMedium),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: AppColors.transparent),
        child: ExpansionTile(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimensions.borderRadiusMedium),
          ),
          collapsedShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimensions.borderRadiusMedium),
          ),
          tilePadding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.gap20,
            vertical: AppDimensions.gap12,
          ),
          childrenPadding:
              const EdgeInsets.only(bottom: AppDimensions.gap16),
          title: Text(
            section.title,
            style: AppTextStyles.dartLessonTitle,
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: AppDimensions.gap6),
            child: Text(
              section.description,
              style: AppTextStyles.dartLessonSubtitle,
            ),
          ),
          children: section.tasks
              .map((task) => _DartTaskTile(task: task))
              .toList(growable: false),
        ),
      ),
    );
  }
}

class _DartTaskTile extends StatelessWidget {
  const _DartTaskTile({required this.task});

  final DartTask task;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final Color codeBackground = colorScheme.surfaceContainerHighest;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.gap20,
        vertical: AppDimensions.gap10,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            task.title,
            style: AppTextStyles.dartTaskTitle,
          ),
          const SizedBox(height: AppDimensions.gap6),
          Text(
            task.description,
            style: AppTextStyles.dartTaskDescription(
              colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: AppDimensions.gap12),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(AppDimensions.cardPadding),
            decoration: BoxDecoration(
              color: codeBackground,
              borderRadius:
                  BorderRadius.circular(AppDimensions.borderRadiusMedium),
              border: Border.all(
                color: Theme.of(context)
                    .dividerColor
                    .withValues(alpha: 0.3),
              ),
            ),
            child: SelectableText(
              task.solution.trim(),
              style: AppTextStyles.dartCode.copyWith(
                color: colorScheme.onSurface,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
