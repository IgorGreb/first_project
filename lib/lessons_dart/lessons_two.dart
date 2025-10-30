import 'dart:io';
import 'dart:math';

void main() {
  calculator();
}

void someFunction() {
  stdout.write('Введи свій бал: ');
  String? input = stdin.readLineSync();
  int? score = int.tryParse(input ?? '');
  if (score == null) {
    print('Потрібно ввести ціле число!');
    return;
  }

  if (score >= 90) {
    print('A');
  } else if (score >= 80 && score <= 89) {
    print('B');
  } else if (score >= 70 && score <= 79) {
    print('C');
  } else if (score >= 60 && score <= 69) {
    print('D');
  } else {
    print('F');
  }
}

void guessTheNumber() {
  var rng = Random();
  int numberToGuess = rng.nextInt(100) + 1;
  int? guess;

  print('Я загадав число від 0 до 100. Спробуй його відгадати!');

  while (guess != numberToGuess) {
    stdout.write('Введи число: ');
    guess = int.tryParse(stdin.readLineSync() ?? '');

    if (guess == null) {
      print('Помилка: введи правильне число.');
      continue;
    }

    if (guess < 0 || guess > 100) {
      print('Число має бути від 0 до 100. Спробуй ще раз.');
      continue;
    }

    if (guess < numberToGuess) {
      print('Замало! Спробуй більше.');
    } else if (guess > numberToGuess) {
      print('Забагато! Спробуй менше.');
    } else {
      print('Вітаю! Ти вгадав');
    }
  }
}

void factorialOfANumber() {
  stdout.write('Введи число: ');
  int? n = int.tryParse(stdin.readLineSync() ?? '');

  if (n == null || n < 0) {
    print('Введи невід’ємне ціле число.');
    return;
  }

  int result = 1;
  int i = 1;

  while (i <= n) {
    result *= i;
    i++;
  }

  print('Факторіал числа $n є $result');
}

void temperatureConverter() {
  double celsiusToFahrenheit(double celsius) {
    return celsius * 9 / 5 + 32;
  }

  double fahrenheitToCelsius(double fahrenheit) {
    return (fahrenheit - 32) * 5 / 9;
  }

  stdout.write('Введи температуру: ');
  double? temp = double.tryParse(stdin.readLineSync() ?? '');

  if (temp == null) {
    print('Помилка: введи правильне число.');
    return;
  }

  stdout.write('Введи систему конвертації (C для Цельсія, F для Фаренгейта): ');
  String? system = stdin.readLineSync()?.toUpperCase();

  if (system == 'F') {
    double converted = celsiusToFahrenheit(temp);
    print('$temp°C = ${converted.toStringAsFixed(2)}°F');
  } else if (system == 'C') {
    double converted = fahrenheitToCelsius(temp);
    print('$temp°F = ${converted.toStringAsFixed(2)}°C');
  } else {
    print('Невірна система. Введи C або F.');
  }
}

void calculator() {
  double? num1;
  double? num2;

  while (num1 == null) {
    stdout.write('Перше число: ');
    num1 = double.tryParse(stdin.readLineSync() ?? '');
    if (num1 == null) {
      print('Помилка: введи число.');
    }
  }

  while (num2 == null) {
    stdout.write('Друге число: ');
    num2 = double.tryParse(stdin.readLineSync() ?? '');
    if (num2 == null) {
      print('Помилка: введи число.');
    }
  }

  stdout.write('Вибери оператор (+, -, *, /): ');
  String? op = stdin.readLineSync();

  switch (op) {
    case '+':
      print('Відповідь: ${num1 + num2}');
      break;
    case '-':
      print('Відповідь: ${num1 - num2}');
      break;
    case '*':
      print('Відповідь: ${num1 * num2}');
      break;
    case '/':
      if (num2 == 0) {
        print('Не можна ділити на нуль!');
      } else {
        print('Відповідь: ${num1 / num2}');
      }
      break;
    default:
      print('Невірний оператор!');
  }
}
