class HomeScreenTexts {
  static const String appBarTitle = 'Мій профіль';
  static const String welcomeText = 'Вітаю!';
  static const String goToProfileButton = 'Перейти до профілю';
  static const String goToHomeworkFiveButton = 'Домашка #5';
  static const String goToHomeworkSevenButton = 'Домашка #7';
  static const String goToHomeworkEightButton = 'Домашка #8';
  static const String goToHomeworkNineButton = 'Домашка #9';
  static const String goToDartSolutionsButton =
      'Задачі з Dart \n Домашки: #1, #2, #3';
  static const String goToHomeworkTenButton = 'Домашка #10';
  static const String goToHomeworkElevenButton = 'Домашка #11';
}

class ProfileScreenTexts {
  static const String appBarTitle = 'Профіль';
  static const String name = 'Ігор Гребенюк';
  static const String age = 'Вік: 35';
  static const String job = 'Місце роботи: Web Academy';
  static const String contactsButton = 'Контакти';
  static const String backButton = 'Назад';
  static const String initials = 'IG';
  static const String about =
      'Люблю навчатися Flutter та створювати красиві додатки.';
}

class ContactsScreenTexts {
  static const String appBarTitle = 'Контакти';
  static const List<Map<String, String>> contacts = [
    {'name': 'Олена Петрова', 'phone': '+380 50 123 45 67'},
    {'name': 'Максим Іванов', 'phone': '+380 63 987 65 43'},
    {'name': 'Web Academy', 'phone': '+380 44 555 44 33'},
  ];
}

class HomeworkFiveTexts {
  static const String appBarTitle = 'My Homework';
  static const String sectionTitle = 'Beautiful Images';
  static const String highlightText = 'My text';
  static const String firstImageUrl =
      'https://fastly.picsum.photos/id/179/2048/1365.jpg?hmac=GJyDjrvfBfjPfJPqSBd2pX6sjvsGbG10d21blr5bTS8';
  static const String secondImageUrl =
      'https://fastly.picsum.photos/id/200/1920/1280.jpg?hmac=-eKjMC8-UrbLMpy1A4OWrK0feVPB3Ka5KNOGibQzpRU';
  static const String assetImagePath = 'assets/images/animal.jpg';
}

class HomeworkSevenTexts {
  static const String appBarTitle = 'User Profile';
  static const String profileName = 'Oleksandr';
  static const String profileDescription = 'Flutter Developer';
  static const String aboutTitle = 'About';
  static const String aboutDescription =
      'I build mobile experiences with Flutter, Dart, and Firebase.';
}

class UserStatusTexts {
  static const String projects = 'Projects';
  static const String followers = 'Followers';
  static const String following = 'Following';
}

class HomeworkEightTexts {
  static const String appBarTitle = 'Homework #8: To-Do List';
  static const String newTaskTitle = 'Нове завдання';
  static const String taskHint = 'Опишіть, що потрібно зробити';
  static const String addButton = 'Додати';
  static const String emptyState =
      'Поки що завдань немає.\nДодайте перший пункт!';
  static const String deleteTooltip = 'Видалити';
}

class HomeworkNineTexts {
  static const String appBarTitle = 'Книга рецептів';
  static const String emptyListMessage =
      'Поки що немає рецептів. Додайте перший!';
}

class HomeworkTenTexts {
  static const String appBarTitle = 'Async Chat Bot';
  static const String defaultResponse = 'Ваше питання опрацьоване.';
  static const String errorResponse = 'Щось пішло не так! Спробуйте ще раз.';
  static const String positiveResponse = 'Я радий, що вам подобається!';
  static const String emptyChatPlaceholder =
      'Поставте перше питання, щоб розпочати чат.';
  static const String typingLabel = 'Бот друкує';
  static const String questionHint = 'Введіть питання...';
  static const String sendButton = 'Надіслати';
  static const String weatherResponseTemplate = 'Зараз приблизно {temp}°C.';

  static String weatherResponse(int temperature) =>
      weatherResponseTemplate.replaceFirst('{temp}', '$temperature');
}

class RecipeDetailsTexts {
  static const String ingredientsTitle = 'Інгредієнти';
  static const String instructionsTitle = 'Інструкції';
}

class RecipeFormTexts {
  static const String appBarTitle = 'Новий рецепт';
  static const String titleLabel = 'Назва';
  static const String titleHint = 'Наприклад, Олів’є';
  static const String descriptionLabel = 'Короткий опис';
  static const String descriptionHint = 'Що робить цей рецепт особливим?';
  static const String ingredientsLabel = 'Інгредієнти';
  static const String ingredientsHint = 'Кожен інгредієнт з нового рядка';
  static const String instructionsLabel = 'Інструкції';
  static const String instructionsHint =
      'Опишіть кроки приготування (по рядку на крок)';
  static const String imageUrlLabel = 'URL зображення';
  static const String imageUrlHint = 'Вставте посилання на фото страви';
  static const String saveButton = 'Зберегти рецепт';
  static const String fieldValidationError = 'Заповніть поле';
}

class DartSolutionsTexts {
  static const String appBarTitle = 'Задачі з Dart';
}

class TenPageTexts {
  static const String homeworkTenTitle = 'Домашка #10';
  static const String chatBot = 'Chat Bot';
  static const String asyncCountdown = 'Countdown timer';
  static const String asyncCallToApi = 'Call to API';
  static const String asyncMultiStage = 'Multi-stage API';
}

class MultiStageApiTexts {
  static const String appBarTitle = 'Async API (3 етапи)';
  static const String startButton = 'Запустити fetchDataFromApi';
  static const String emptyState = 'Натисніть кнопку, щоб почати';
  static const String successMessage = 'Дані отримано успішно!';
  static const String errorPrefix = 'API повернуло помилку (10% шанс)';
  static const String logSuccessPrefix = '✅ Завершено: ';
  static const String logErrorPrefix = '❌ ';

  static const String stageInit = 'Етап 1: ініціалізація…';
  static const String stageRequest = 'Етап 2: виконуємо запит до API…';
  static const String stageResponse = 'Етап 3: очікуємо відповідь…';
  static const String stageCompletedSuffix = ' - виконано';
}

class AsyncTimerTexts {
  static const String appBarTitle = 'CountDownTimer';
  static const String errorPrefix = 'Помилка: ';
  static const String idleState = 'Натисніть «Старт», щоб розпочати';
  static const String finishedState = 'Таймер завершено!';
  static const String startButton = 'Старт';
  static const String startWithErrorButton = 'Старт з помилкою';
  static const String lastErrorPrefix = 'Остання помилка: ';
  static const String runningDescription = 'Зворотній відлік триває...';
  static const String invalidDurationError =
      'Неможливо створити таймер із від’ємним часом';
}

class AsyncRealtimeTexts {
  static const String appBarTitle = 'Async ReaTime Call To Api';
  static const String streamErrorPrefix = 'Помилка: ';
  static const String pausedState =
      'Потік призупинено. Натисніть "Продовжити".';
  static const String idleState = 'Натисніть "Старт", щоб запустити потік.';
  static const String runningState = 'Дані оновлюються кожні 2 секунди';
  static const String stoppedState = 'Потік зупинено';
  static const String startButton = 'Старт';
  static const String pauseButton = 'Пауза';
  static const String resumeButton = 'Продовжити';
  static const String stopButton = 'Зупинити';
  static const String lastErrorPrefix = 'Остання помилка: ';

  static String invalidValueError(int value) =>
      'Отримано небезпечне значення: $value';
}

class ElevenHWTexts {
  static const String appBarTitle = 'Домашка #11';
  static const String title = 'Список постів';
}
