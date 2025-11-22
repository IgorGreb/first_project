import 'package:flutter/material.dart';
import 'package:flutter_application_grebenyuk/homeworks/eight/models/todo_task.dart';

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
        task.isDone ? colorScheme.surfaceVariant : colorScheme.surface;
    final Color borderColor =
        colorScheme.outline.withOpacity(task.isDone ? 0.25 : 0.6);
    final Color textColor = task.isDone
        ? colorScheme.onSurface.withOpacity(0.6)
        : colorScheme.onSurface;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
        decoration: BoxDecoration(
          color: baseColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: borderColor),
        ),
        child: ListTile(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          leading: Checkbox(
            value: task.isDone,
            onChanged: enabled ? (_) => onToggle?.call() : null,
          ),
          title: AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 250),
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              decoration:
                  task.isDone ? TextDecoration.lineThrough : TextDecoration.none,
              color: textColor,
            ),
            child: Text(task.title),
          ),
          trailing: IconButton(
            icon: const Icon(Icons.delete_outline),
            tooltip: 'Видалити',
            onPressed: enabled ? onDelete : null,
          ),
        ),
      ),
    );
  }
}
