class DartTask {
  final String title;
  final String description;
  final String solution;

  const DartTask({
    required this.title,
    required this.description,
    required this.solution,
  });
}

class DartLessonSection {
  final String title;
  final String description;
  final List<DartTask> tasks;

  const DartLessonSection({
    required this.title,
    required this.description,
    required this.tasks,
  });
}
