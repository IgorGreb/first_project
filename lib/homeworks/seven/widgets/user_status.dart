import 'package:flutter/material.dart';
import 'package:flutter_application_grebenyuk/homeworks/seven/widgets/statistics_widget_builder.dart';

class UserStatusWidget extends StatelessWidget {
  const UserStatusWidget({
    super.key,
    required this.projects,
    required this.followers,
    required this.following,
  });

  final int projects;
  final int followers;
  final int following;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isWide = constraints.maxWidth >= 400;
        final double valueFontSize = isWide ? 28 : 22;
        final double labelFontSize = isWide ? 16 : 14;
        final double spacing = isWide ? 32 : 16;

        return Container(
          padding: EdgeInsets.symmetric(
            horizontal: isWide ? 32 : 16,
            vertical: isWide ? 20 : 16,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: buildStatistic(
                  'Projects',
                  projects,
                  valueFontSize,
                  labelFontSize,
                ),
              ),
              SizedBox(width: spacing),
              Expanded(
                child: buildStatistic(
                  'Followers',
                  followers,
                  valueFontSize,
                  labelFontSize,
                ),
              ),
              SizedBox(width: spacing),
              Expanded(
                child: buildStatistic(
                  'Following',
                  following,
                  valueFontSize,
                  labelFontSize,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
