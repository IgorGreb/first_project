import 'package:flutter/material.dart';
import 'package:flutter_application_grebenyuk/homeworks/home_work_8/models/todo_task.dart';
import 'package:flutter_application_grebenyuk/homeworks/home_work_8/widgets/todo_task_tile.dart';

class AnimatedTaskTile extends StatelessWidget {
  const AnimatedTaskTile({
    super.key,
    required this.animation,
    required this.task,
    required this.enabled,
    required this.onToggle,
    required this.onDelete,
  });

  final Animation<double> animation;
  final TodoTask task;
  final bool enabled;
  final VoidCallback? onToggle;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    final Animation<double> curved = CurvedAnimation(
      parent: animation,
      curve: Curves.easeOutCubic,
    );

    return SizeTransition(
      sizeFactor: curved,
      child: FadeTransition(
        opacity: curved,
        child: TodoTaskTile(
          task: task,
          enabled: enabled,
          onToggle: onToggle,
          onDelete: onDelete,
        ),
      ),
    );
  }
}
