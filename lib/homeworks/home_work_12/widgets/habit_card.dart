import 'package:flutter/material.dart';
import 'package:flutter_application_grebenyuk/constants/colors.dart';
import 'package:flutter_application_grebenyuk/homeworks/home_work_12/constants/habit_dimens.dart';
import 'package:flutter_application_grebenyuk/homeworks/home_work_12/constants/habit_texts.dart';
import 'package:flutter_application_grebenyuk/homeworks/home_work_12/models/habit_model.dart';
import 'package:intl/intl.dart';

class HabitCard extends StatelessWidget {
  const HabitCard({
    super.key,
    required this.habit,
    required this.isUpdating,
    required this.onToggle,
    required this.onTap,
  });

  final HabitModel habit;
  final bool isUpdating;
  final ValueChanged<bool> onToggle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final completedToday = habit.isCompletedToday;
    final startDateString = DateFormat('dd MMM yyyy').format(habit.startDate);

    return Material(
      color: AppColors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(HabitDimens.cardRadius),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          padding: const EdgeInsets.all(HabitDimens.spaceMD),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(HabitDimens.cardRadius),
            color: theme.colorScheme.surface,
            border: Border.all(
              color: completedToday
                  ? theme.colorScheme.primary
                  : theme.colorScheme.outlineVariant,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.black.withOpacity(HabitDimens.cardShadowOpacity),
                blurRadius: HabitDimens.cardShadowBlur,
                offset: const Offset(0, HabitDimens.cardShadowOffsetY),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      habit.name,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Icon(
                    completedToday ? Icons.check_circle : Icons.circle_outlined,
                    color: completedToday
                        ? theme.colorScheme.primary
                        : theme.colorScheme.outline,
                  ),
                ],
              ),
              const SizedBox(height: HabitDimens.spaceSM),
              Text(
                habit.frequency,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: HabitDimens.spaceSM),
              Text(
                '${HabitTexts.startDatePrefix} $startDateString',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: HabitDimens.spaceLG),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Checkbox.adaptive(
                    value: completedToday,
                    onChanged: isUpdating
                        ? null
                        : (value) {
                            if (value == null) return;
                            onToggle(value);
                          },
                  ),
                  Expanded(
                    child: Text(
                      completedToday
                          ? HabitTexts.todayDone
                          : HabitTexts.todayTodo,
                      style: theme.textTheme.bodyMedium,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
