import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

class HomeworkThemeState extends Equatable {
  const HomeworkThemeState({
    required this.themeMode,
    this.isInitialized = false,
  });

  final ThemeMode themeMode;
  final bool isInitialized;

  HomeworkThemeState copyWith({
    ThemeMode? themeMode,
    bool? isInitialized,
  }) {
    return HomeworkThemeState(
      themeMode: themeMode ?? this.themeMode,
      isInitialized: isInitialized ?? this.isInitialized,
    );
  }

  @override
  List<Object?> get props => [themeMode, isInitialized];
}
