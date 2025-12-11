import 'package:flutter/material.dart';
import 'package:flutter_application_grebenyuk/constants/dimensions.dart';
import 'package:flutter_application_grebenyuk/constants/text_styles.dart';
import 'package:flutter_application_grebenyuk/constants/ui_texts.dart';
import 'package:flutter_application_grebenyuk/homeworks/home_work_8/models/todo_task.dart';

class TodoTaskTile extends StatelessWidget {
  const TodoTaskTile({
    super.key,
    required this.task,
    required this.enabled,
    required this.onToggle,
    required this.onDelete,
  });

  final TodoTask task;
  final bool enabled;
  final VoidCallback? onToggle;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final Color baseColor =
        task.isDone ? colorScheme.surfaceContainerHighest : colorScheme.surface;
    final Color borderColor =
        colorScheme.outline.withValues(alpha: task.isDone ? 0.25 : 0.6);
    final Color textColor = task.isDone
        ? colorScheme.onSurface.withValues(alpha: 0.6)
        : colorScheme.onSurface;

    return Padding(
      padding:
          const EdgeInsets.symmetric(vertical: AppDimensions.todoTileSpacing),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
        decoration: BoxDecoration(
          color: baseColor,
          borderRadius:
              BorderRadius.circular(AppDimensions.borderRadiusMedium),
          border: Border.all(color: borderColor),
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.todoTilePaddingHorizontal,
            vertical: AppDimensions.todoTilePaddingVertical,
          ),
          leading: Checkbox(
            value: task.isDone,
            onChanged: enabled ? (_) => onToggle?.call() : null,
          ),
          title: AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 250),
            style: AppTextStyles.todoTileTitle.copyWith(
              decoration:
                  task.isDone ? TextDecoration.lineThrough : TextDecoration.none,
              color: textColor,
            ),
            child: Text(task.title),
          ),
          trailing: IconButton(
            icon: const Icon(Icons.delete_outline),
            tooltip: HomeworkEightTexts.deleteTooltip,
            onPressed: enabled ? onDelete : null,
          ),
        ),
      ),
    );
  }
}
