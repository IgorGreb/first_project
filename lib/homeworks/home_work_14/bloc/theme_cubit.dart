import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_grebenyuk/homeworks/home_work_14/bloc/theme_state.dart';
import 'package:flutter_application_grebenyuk/homeworks/home_work_14/constants/app_styles.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeworkThemeStorage {
  static const String _key = 'homework14_theme_mode';

  Future<void> saveThemeMode(ThemeMode mode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, mode.name);
  }

  Future<ThemeMode> loadThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    final stored = prefs.getString(_key);
    switch (stored) {
      case 'dark':
        return ThemeMode.dark;
      case 'light':
        return ThemeMode.light;
      case 'system':
        return ThemeMode.system;
      default:
        return ThemeMode.light;
    }
  }
}

class ThemeCubit extends Cubit<HomeworkThemeState> {
  ThemeCubit(this._storage)
      : super(
          const HomeworkThemeState(
            themeMode: ThemeMode.light,
            isInitialized: false,
          ),
        ) {
    _loadTheme();
  }

  final HomeworkThemeStorage _storage;

  ThemeData get lightTheme => Homework14Themes.lightTheme;
  ThemeData get darkTheme => Homework14Themes.darkTheme;

  Future<void> _loadTheme() async {
    final savedTheme = await _storage.loadThemeMode();
    emit(state.copyWith(themeMode: savedTheme, isInitialized: true));
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    emit(state.copyWith(themeMode: mode));
    await _storage.saveThemeMode(mode);
  }

  Future<void> toggleTheme() async {
    final ThemeMode newMode =
        state.themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    await setThemeMode(newMode);
  }
}
