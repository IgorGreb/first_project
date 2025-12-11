import 'package:equatable/equatable.dart';
import 'package:flutter_application_grebenyuk/homeworks/home_work_12/models/habit_model.dart';

enum HabitsStatus { initial, loading, success, failure }

class HabitsState extends Equatable {
  const HabitsState({
    this.status = HabitsStatus.initial,
    this.habits = const [],
    this.errorMessage,
    this.updatingHabitIds = const {},
    this.isSubmitting = false,
  });

  final HabitsStatus status;
  final List<HabitModel> habits;
  final String? errorMessage;
  final Set<String> updatingHabitIds;
  final bool isSubmitting;

  HabitsState copyWith({
    HabitsStatus? status,
    List<HabitModel>? habits,
    String? errorMessage,
    bool clearError = false,
    Set<String>? updatingHabitIds,
    bool? isSubmitting,
  }) {
    return HabitsState(
      status: status ?? this.status,
      habits: habits ?? this.habits,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      updatingHabitIds: updatingHabitIds ?? this.updatingHabitIds,
      isSubmitting: isSubmitting ?? this.isSubmitting,
    );
  }

  @override
  List<Object?> get props =>
      [status, habits, errorMessage, updatingHabitIds, isSubmitting];
}
