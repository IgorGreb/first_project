import 'dart:io';
import 'dart:math';

void main() {}

/// ==========================
/// 🔸 1. Калькулятор
/// ==========================
void calculator() {
  print('\n=== 🧮 Калькулятор ===');

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
        print('⚠️ Не можна ділити на нуль!');
        return;
      }
      result = num1 / num2;
      break;
    default:
      print('❌ Невірний оператор!');
      return;
  }

  print('✅ Результат: $num1 $op $num2 = ${result.toStringAsFixed(2)}');
}

/// ==========================
/// 🔸 2. Гра "Вгадай число"
/// ==========================
void guessTheNumber() {
  print('\n🎯 Гра: Вгадай число від 1 до 100');
  var rng = Random();
  int numberToGuess = rng.nextInt(100) + 1;
  int? guess;

  while (guess != numberToGuess) {
    guess = _readInt('Введи число: ');

    if (guess < numberToGuess) {
      print('🔽 Замало! Спробуй більше.');
    } else if (guess > numberToGuess) {
      print('🔼 Забагато! Спробуй менше.');
    } else {
      print('🎉 Вітаю! Ти вгадав число $numberToGuess');
    }
  }
}

/// ==========================
/// 🔸 3. Факторіал числа
/// ==========================
void factorialOfANumber() {
  print('\n📈 Обчислення факторіалу');
  int n = _readInt('Введи ціле невід’ємне число: ');

  if (n < 0) {
    print('❌ Введи невід’ємне число.');
    return;
  }

  int result = 1;
  for (int i = 1; i <= n; i++) {
    result *= i;
  }

  print('✅ Факторіал числа $n = $result');
}

/// ==========================
/// 🔸 4. Конвертер температури
/// ==========================
void temperatureConverter() {
  print('\n🌡️ Конвертер температури');

  double temp = _readDouble('Введи температуру: ');
  stdout.write('Введи систему (C — Цельсій, F — Фаренгейт): ');
  String? system = stdin.readLineSync()?.toUpperCase();

  if (system == 'C') {
    double converted = temp * 9 / 5 + 32;
    print('✅ $temp°C = ${converted.toStringAsFixed(2)}°F');
  } else if (system == 'F') {
    double converted = (temp - 32) * 5 / 9;
    print('✅ $temp°F = ${converted.toStringAsFixed(2)}°C');
  } else {
    print('❌ Невірна система. Введи C або F.');
  }
}

/// ==========================
/// 🔸 5. Оцінка за балами
/// ==========================
void gradeEvaluator() {
  print('\n🎓 Оцінка за балами');

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

/// ==========================
/// 🔸 Допоміжні функції
/// ==========================

// Зчитує ціле число з консолі
int _readInt(String message) {
  int? value;
  while (value == null) {
    stdout.write(message);
    value = int.tryParse(stdin.readLineSync() ?? '');
    if (value == null) {
      print('❌ Помилка: введи ціле число!');
    }
  }
  return value;
}

// Зчитує число з плаваючою точкою
double _readDouble(String message) {
  double? value;
  while (value == null) {
    stdout.write(message);
    value = double.tryParse(stdin.readLineSync() ?? '');
    if (value == null) {
      print('❌ Помилка: введи число!');
    }
  }
  return value;
}
