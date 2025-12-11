import 'package:flutter/material.dart';
import 'package:flutter_application_grebenyuk/homeworks/home_work_12/bloc/habits_bloc.dart';
import 'package:flutter_application_grebenyuk/homeworks/home_work_12/bloc/habits_event.dart';
import 'package:flutter_application_grebenyuk/homeworks/home_work_12/constants/habit_dimens.dart';
import 'package:flutter_application_grebenyuk/homeworks/home_work_12/constants/habit_texts.dart';
import 'package:flutter_application_grebenyuk/homeworks/home_work_12/models/habit_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class HabitDetailPage extends StatelessWidget {
  const HabitDetailPage({super.key, required this.habit});

  final HabitModel habit;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final entries = habit.progress.entries.toList()
      ..sort((a, b) => b.key.compareTo(a.key));
    final completedDays = entries.where((entry) => entry.value).length;
    final totalDays = entries.length;
    final percent = habit.completionPercent.clamp(0.0, 1.0);
    final dateFormat = DateFormat('dd MMM yyyy');

    return Scaffold(
      appBar: AppBar(
        title: Text(habit.name),
        actions: [
          IconButton(
            onPressed: () async {
              final shouldDelete = await showDialog<bool>(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text(HabitTexts.deleteHabitTitle),
                      content: const Text(HabitTexts.deleteHabitWarning),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(false),
                          child: const Text(HabitTexts.cancel),
                        ),
                        FilledButton(
                          onPressed: () => Navigator.of(context).pop(true),
                          child: const Text(HabitTexts.deleteHabitConfirm),
                        ),
                      ],
                    ),
                  ) ??
                  false;
              if (!shouldDelete) return;
              context.read<HabitsBloc>().add(HabitDeletedRequested(habit.id));
              if (context.mounted) Navigator.of(context).pop();
            },
            icon: const Icon(Icons.delete_outline),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(HabitDimens.pagePadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              HabitTexts.detailTitle,
              style: theme.textTheme.titleLarge
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: HabitDimens.spaceMD),
            LinearPercentIndicator(
              lineHeight: HabitDimens.progressIndicatorHeight,
              barRadius:
                  const Radius.circular(HabitDimens.progressIndicatorRadius),
              backgroundColor: theme.colorScheme.surfaceVariant,
              progressColor: theme.colorScheme.primary,
              percent: percent,
              animation: true,
            ),
            const SizedBox(height: HabitDimens.spaceSM),
            Text(
              '${HabitTexts.completedDays}: $completedDays / $totalDays',
              style: theme.textTheme.bodyMedium,
            ),
            const SizedBox(height: HabitDimens.spaceLG),
            Row(
              children: [
                Expanded(
                  child: _DetailTile(
                    title: HabitTexts.frequencyLabel,
                    value: habit.frequency,
                  ),
                ),
                const SizedBox(width: HabitDimens.spaceMD),
                Expanded(
                  child: _DetailTile(
                    title: HabitTexts.startDateLabel,
                    value: dateFormat.format(habit.startDate),
                  ),
                ),
              ],
            ),
            const SizedBox(height: HabitDimens.spaceLG),
            Text(
              HabitTexts.progressTitle,
              style: theme.textTheme.titleMedium,
            ),
            const SizedBox(height: HabitDimens.spaceSM),
            if (entries.isEmpty)
              Text(
                HabitTexts.noProgressYet,
                style: theme.textTheme.bodyMedium,
              )
            else
              Expanded(
                child: ListView.separated(
                  itemCount: entries.length,
                  separatorBuilder: (_, __) =>
                      const SizedBox(height: HabitDimens.spaceSM),
                  itemBuilder: (context, index) {
                    final entry = entries[index];
                    final date = dateFormat.format(DateTime.parse(entry.key));
                    return ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Icon(
                        entry.value
                            ? Icons.check_circle
                            : Icons.radio_button_unchecked,
                        color: entry.value
                            ? theme.colorScheme.primary
                            : theme.colorScheme.outline,
                      ),
                      title: Text(date),
                      subtitle: Text(
                        entry.value
                            ? HabitTexts.progressCompleted
                            : HabitTexts.progressSkipped,
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _DetailTile extends StatelessWidget {
  const _DetailTile({required this.title, required this.value});

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(HabitDimens.spaceMD),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(HabitDimens.cardRadius),
        border: Border.all(color: theme.colorScheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: HabitDimens.spaceXS),
          Text(
            value,
            style: theme.textTheme.titleMedium,
          ),
        ],
      ),
    );
  }
}
