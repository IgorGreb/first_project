import 'package:collection/collection.dart';

void main() {
  //List task
  List<String> lst = ['Odessa', 'Igor', '1990'];
  print(lst);
  lst.add('Kiev');
  lst.sort((a, b) => a.compareTo(b));
  print(lst);

  List<String> randomData = ['Odessa', 'Igor', '1990'];
  print(randomData);
  Iterable upper = randomData.map((e) => e.toUpperCase());
  print(upper);
  //Map Task
  final Map<String, int> students = {
    'Саша': 85,
    'Ігор': 90,
    'Джон': 88,
    'Тім': 90,
    'Марія': 85,
  };

  students['Sahsa'] = 100;
  students.remove('Jhon');
  students.forEach((key, value) => print('Студент: $key, Оцінка: $value'));

  int totalScore = students.values.fold(0, (sum, score) => sum + score);

  print("The total combined score is: $totalScore");

  // Групуємо студентів за оцінками
  final grouped = groupBy(students.entries, (entry) => entry.value);

  // Перетворюємо у зручний формат: {оцінка: [імена]}
  final result = grouped.map(
    (grade, list) => MapEntry(grade, list.map((e) => e.key).toList()),
  );

  result.forEach((grade, names) {
    print('Оцінка $grade: $names');
  });
}
