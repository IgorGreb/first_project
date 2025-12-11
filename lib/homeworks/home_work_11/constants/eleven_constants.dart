import 'package:flutter/material.dart';

class ElevenApiConstants {
  const ElevenApiConstants._();

  static const String baseUrl = 'https://jsonplaceholder.typicode.com';
  static const String posts = '$baseUrl/posts';

  static String post(int id) => '$posts/$id';
  static String commentsByPost(int id) => '$posts/$id/comments';
}

class ElevenTexts {
  const ElevenTexts._();

  static const title = 'Домашка #11';
  static const postsHeader = 'Список постів';
  static const postsSubtitle = 'Натисни на картку, щоб переглянути коментарі';
  static const commentsHeader = 'Коментарі';
  static const postsEmpty = 'Пости відсутні';
  static const commentsEmpty = 'Коментарів немає';
  static const genericError = 'Помилка';
  static const retry = 'Спробувати ще раз';
  static const backToPosts = 'До списку постів';
  static const commentsHint = 'Пост #';
  static const deleteSuccess = 'Пост успішно видалено';
  static const deleteError = 'Не вдалося видалити пост';
  static const deleteButtonTooltip = 'Видалити пост';
  static const postEmptyTitle = 'Без назви';
  static const postIdLabel = 'ID: ';
  static const placeholderDash = '—';
  static const missingEmail = 'Без email';
  static const avatarFallback = '?';
}

class ElevenDimens {
  const ElevenDimens._();

  static const double pagePaddingHorizontal = 16;
  static const double pagePaddingVertical = 8;
  static const double cardPadding = 16;
  static const double cardRadius = 12;
  static const double spaceXS = 4;
  static const double spaceSM = 8;
  static const double spaceMD = 12;
  static const double spaceLG = 16;
  static const double deletingIndicatorSize = 20;
  static const double iconSmall = 16;
  static const double iconPlaceholder = 48;
  static const double iconFailure = 56;
  static const double overlayOpacity = 0.25;
}

class ElevenFontWeights {
  const ElevenFontWeights._();

  static const FontWeight cardTitle = FontWeight.w600;
}

class ElevenDurations {
  const ElevenDurations._();

  static const Duration contentSwitch = Duration(milliseconds: 250);
}
