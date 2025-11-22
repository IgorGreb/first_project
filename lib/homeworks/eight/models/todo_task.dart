class TodoTask {
  TodoTask({
    required this.id,
    required this.title,
    this.isDone = false,
  });

  final int id;
  final String title;
  bool isDone;
}
