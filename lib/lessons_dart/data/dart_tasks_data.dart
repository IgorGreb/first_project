import 'package:flutter_application_grebenyuk/lessons_dart/models/dart_task.dart';

const List<DartLessonSection> dartLessonSections = [
  DartLessonSection(
    title: 'Урок 1. ООП та патерни',
    description:
        'Класи, міксіни, інтерфейси та порівняння об’єктів через Equatable.',
    tasks: [
      DartTask(
        title: 'Клас Book',
        description:
            'Зберігає назву, автора і рік та має метод для виводу інформації.',
        solution: r'''
class Book {
  String name;
  String author;
  int publishYear;

  Book(this.name, this.author, this.publishYear);

  void displayInfo() {
    print('Назва книги: $name, Автор: $author, Дата публікації: $publishYear');
  }
}
''',
      ),
      DartTask(
        title: 'Міксин Swimming для тварин',
        description:
            'Fish і Duck наслідують Animal та розширюють поведінку методом swim().',
        solution: r'''
mixin Swimming {
  String swim() {
    return "I can swim";
  }
}

class Fish extends Animal with Swimming {
  Fish(super.species, super.age);

  void prinFishtInfo() {
    print('I’m a fish and ${swim()}');
  }
}

class Duck extends Animal with Swimming {
  Duck(super.species, super.age);
  void prinDuckInfo() {
    print('I’m a duck and ${swim()}');
  }
}
''',
      ),
      DartTask(
        title: 'Інтерфейси Playable та клуб',
        description:
            'Інтерфейс описує метод play(), а SportsClub викликає його на кожному спорті.',
        solution: r'''
abstract class Playable {
  String play();
}

class Soccer extends Playable {
  @override
  String play() => 'play football';
}

class Basketball extends Playable {
  @override
  String play() => 'play basketball';
}

class SportsClub {
  final List<Playable> _sports = [];

  void addSport(Playable playable) {
    _sports.add(playable);
  }

  void playAll() {
    for (var sport in _sports) {
      print(sport.play());
    }
  }
}
''',
      ),
      DartTask(
        title: 'Порівняння координат через Equatable',
        description:
            'Coordinate2 перевизначає props, тож == працює коректно для значень.',
        solution: r'''
class Coordinate2 extends Equatable {
  final double latitude;
  final double longitude;

  const Coordinate2(this.latitude, this.longitude);

  @override
  List<Object?> get props => [latitude, longitude];
}
''',
      ),
    ],
  ),
  DartLessonSection(
    title: 'Урок 2. Базові алгоритми',
    description:
        'Консольні приклади на умови, цикли та роботу з введенням користувача.',
    tasks: [
      DartTask(
        title: 'Калькулятор',
        description:
            'Зчитує два числа та оператор, перевіряє ділення на нуль і виводить результат.',
        solution: r'''
void calculator() {
  print('\n=== Калькулятор ===');

  double num1 = _readDouble('Введіть перше число: ');
  double num2 = _readDouble('Введіть друге число: ');

  stdout.write('Вибери оператор (+, -, *, /): ');
  String? op = stdin.readLineSync();

  double? result;

  switch (op) {
    case '+':
      result = num1 + num2;
      break;
    case '-':
      result = num1 - num2;
      break;
    case '*':
      result = num1 * num2;
      break;
    case '/':
      if (num2 == 0) {
        print('Не можна ділити на нуль!');
        return;
      }
      result = num1 / num2;
      break;
    default:
      print('Невірний оператор!');
      return;
  }

  print('Результат: $num1 $op $num2 = ${result.toStringAsFixed(2)}');
}
''',
      ),
      DartTask(
        title: 'Гра «Вгадай число»',
        description:
            'Генерує випадкове число і підказує, чи треба шукати вище чи нижче.',
        solution: r'''
void guessTheNumber() {
  print('\nГра: Вгадай число від 1 до 100');
  var rng = Random();
  int numberToGuess = rng.nextInt(100) + 1;
  int? guess;

  while (guess != numberToGuess) {
    guess = _readInt('Введи число: ');

    if (guess < numberToGuess) {
      print('Замало! Спробуй більше.');
    } else if (guess > numberToGuess) {
      print('Забагато! Спробуй менше.');
    } else {
      print('Вітаю! Ти вгадав число $numberToGuess');
    }
  }
}
''',
      ),
      DartTask(
        title: 'Факторіал числа',
        description:
            'Перевіряє, що число невід’ємне, і за допомогою циклу for обчислює факторіал.',
        solution: r'''
void factorialOfANumber() {
  print('\nОбчислення факторіалу');
  int n = _readInt('Введи ціле невід’ємне число: ');

  if (n < 0) {
    print('Введи невід’ємне число.');
    return;
  }

  int result = 1;
  for (int i = 1; i <= n; i++) {
    result *= i;
  }

  print('Факторіал числа $n = $result');
}
''',
      ),
      DartTask(
        title: 'Конвертер температур',
        description:
            'Перекладає значення між °C та °F залежно від введеної системи.',
        solution: r'''
void temperatureConverter() {
  print('\nКонвертер температури');

  double temp = _readDouble('Введи температуру: ');
  stdout.write('Введи систему (C — Цельсій, F — Фаренгейт): ');
  String? system = stdin.readLineSync()?.toUpperCase();

  if (system == 'C') {
    double converted = temp * 9 / 5 + 32;
    print('$temp°C = ${converted.toStringAsFixed(2)}°F');
  } else if (system == 'F') {
    double converted = (temp - 32) * 5 / 9;
    print('$temp°F = ${converted.toStringAsFixed(2)}°C');
  } else {
    print('Невірна система. Введи C або F.');
  }
}
''',
      ),
      DartTask(
        title: 'Оцінка за балами',
        description: 'Зіставляє числовий бал з літерною оцінкою A–F.',
        solution: r'''
void gradeEvaluator() {
  print('\nОцінка за балами');

  int score = _readInt('Введи свій бал (0–100): ');

  if (score >= 90) {
    print('Оцінка: A');
  } else if (score >= 80) {
    print('Оцінка: B');
  } else if (score >= 70) {
    print('Оцінка: C');
  } else if (score >= 60) {
    print('Оцінка: D');
  } else {
    print('Оцінка: F');
  }
}
''',
      ),
    ],
  ),
  DartLessonSection(
    title: 'Урок 3. Колекції та групування',
    description: 'Робота зі списками та мапами, сортування і об’єднання даних.',
    tasks: [
      DartTask(
        title: 'Операції над списками',
        description:
            'Сортування, додавання нових міст та перетворення у верхній регістр.',
        solution: r'''
void workWithLists() {
  List<String> lst = ['Odessa', 'Igor', '1990'];
  print(lst);
  lst.add('Kiev');
  lst.sort((a, b) => a.compareTo(b));
  print(lst);

  List<String> randomData = ['Odessa', 'Igor', '1990'];
  print(randomData);
  Iterable upper = randomData.map((e) => e.toUpperCase());
  print(upper);
}
''',
      ),
      DartTask(
        title: 'Групування студентів за оцінками',
        description:
            'Використовує пакет collection, щоб зробити мапу {оцінка: [імена]}.',
        solution: r'''
void groupStudents() {
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

  final grouped = groupBy(students.entries, (entry) => entry.value);
  final result = grouped.map(
    (grade, list) => MapEntry(grade, list.map((e) => e.key).toList()),
  );

  result.forEach((grade, names) {
    print('Оцінка $grade: $names');
  });
}
''',
      ),
    ],
  ),
];
