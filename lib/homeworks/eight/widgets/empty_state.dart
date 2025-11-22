import 'package:flutter/material.dart';

class TodoEmptyState extends StatelessWidget {
  const TodoEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return IgnorePointer(
      child: AnimatedOpacity(
        opacity: 1,
        duration: const Duration(milliseconds: 300),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.task_alt,
                size: 64,
                color: theme.colorScheme.outline.withOpacity(0.4),
              ),
              const SizedBox(height: 12),
              Text(
                'Поки що завдань немає.\nДодайте перший пункт!',
                style: theme.textTheme.titleMedium
                    ?.copyWith(color: theme.colorScheme.outline),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
