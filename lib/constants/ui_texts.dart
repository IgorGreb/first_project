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
  static const String goToDartHomeworkTenButton = 'Домашка #10';
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
  static const String errorResponse =
      'Щось пішло не так! Спробуйте ще раз.';
  static const String positiveResponse = 'Я радий, що вам подобається!';
  static const String emptyChatPlaceholder =
      'Поставте перше питання, щоб розпочати чат.';
  static const String typingLabel = 'Бот друкує';
  static const String questionHint = 'Введіть питання...';
  static const String sendButton = 'Надіслати';
  static const String weatherResponseTemplate =
      'Зараз приблизно {temp}°C.';

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
