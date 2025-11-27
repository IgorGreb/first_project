import 'package:flutter/material.dart';
import 'package:flutter_application_grebenyuk/constants/dimensions.dart';
import 'package:flutter_application_grebenyuk/constants/text_styles.dart';
import 'package:flutter_application_grebenyuk/constants/ui_texts.dart';
import 'package:flutter_application_grebenyuk/homeworks/eight/models/todo_task.dart';
import 'package:flutter_application_grebenyuk/homeworks/eight/widgets/animated_task_tile.dart';
import 'package:flutter_application_grebenyuk/homeworks/eight/widgets/empty_state.dart';

class HomeworkEightScreen extends StatefulWidget {
  const HomeworkEightScreen({super.key});

  static const routeName = '/homework-eight';

  @override
  State<HomeworkEightScreen> createState() => _HomeworkEightScreenState();
}

class _HomeworkEightScreenState extends State<HomeworkEightScreen> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  final TextEditingController _textController = TextEditingController();
  final List<TodoTask> _tasks = [];
  int _nextId = 0;
  String _draftText = '';

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  bool get _canAddTask => _draftText.trim().isNotEmpty;

  void _handleTextChanged(String value) {
    setState(() {
      _draftText = value;
    });
  }

  void _addTask() {
    final String title = _draftText.trim();
    if (title.isEmpty) return;

    final TodoTask task = TodoTask(id: _nextId++, title: title);
    setState(() {
      _tasks.insert(0, task);
      _draftText = '';
    });
    _textController.clear();
    _listKey.currentState?.insertItem(
      0,
      duration: const Duration(milliseconds: 350),
    );
  }

  void _toggleTask(int taskId) {
    final int index = _tasks.indexWhere((task) => task.id == taskId);
    if (index == -1) return;
    setState(() {
      _tasks[index].isDone = !_tasks[index].isDone;
    });
  }

  void _removeTask(int taskId) {
    final int index = _tasks.indexWhere((task) => task.id == taskId);
    if (index == -1) return;

    final TodoTask removedTask = _tasks.removeAt(index);
    setState(() {});
    _listKey.currentState?.removeItem(
      index,
      (context, animation) => AnimatedTaskTile(
        animation: animation,
        task: removedTask,
        enabled: false,
        onToggle: null,
        onDelete: null,
      ),
      duration: const Duration(milliseconds: 350),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(HomeworkEightTexts.appBarTitle),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.gap20,
          vertical: AppDimensions.gap16,
        ),
        child: Column(
          children: [
            Card(
              elevation: 2,
              child: Padding(
                padding:
                    const EdgeInsets.all(AppDimensions.paddingDefault),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      HomeworkEightTexts.newTaskTitle,
                      style: AppTextStyles.todoSectionTitle,
                    ),
                    const SizedBox(height: AppDimensions.gap12),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _textController,
                            onChanged: _handleTextChanged,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: HomeworkEightTexts.taskHint,
                            ),
                          ),
                        ),
                        const SizedBox(width: AppDimensions.gap12),
                        FilledButton.icon(
                          onPressed: _canAddTask ? _addTask : null,
                          icon: const Icon(Icons.add_task),
                          label: const Text(HomeworkEightTexts.addButton),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: AppDimensions.gap20),
            Expanded(
              child: Stack(
                children: [
                  AnimatedList(
                    key: _listKey,
                    initialItemCount: _tasks.length,
                    padding:
                        const EdgeInsets.only(bottom: AppDimensions.gap12),
                    itemBuilder: (context, index, animation) {
                      final TodoTask task = _tasks[index];
                      return AnimatedTaskTile(
                        animation: animation,
                        task: task,
                        enabled: true,
                        onToggle: () => _toggleTask(task.id),
                        onDelete: () => _removeTask(task.id),
                      );
                    },
                  ),
                  if (_tasks.isEmpty)
                    const TodoEmptyState(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
