import 'package:equatable/equatable.dart';
import 'package:flutter_application_grebenyuk/homeworks/home_work_12/models/habit_model.dart';

abstract class HabitsEvent extends Equatable {
  const HabitsEvent();

  @override
  List<Object?> get props => [];
}

class HabitsSubscriptionRequested extends HabitsEvent {
  const HabitsSubscriptionRequested(this.userId);

  final String userId;

  @override
  List<Object?> get props => [userId];
}

class HabitCompletionToggled extends HabitsEvent {
  const HabitCompletionToggled({
    required this.habitId,
    required this.date,
    required this.isComplete,
  });

  final String habitId;
  final DateTime date;
  final bool isComplete;

  @override
  List<Object?> get props => [habitId, date, isComplete];
}

class HabitAddedRequested extends HabitsEvent {
  const HabitAddedRequested({
    required this.userId,
    required this.name,
    required this.frequency,
    required this.startDate,
  });

  final String userId;
  final String name;
  final String frequency;
  final DateTime startDate;

  @override
  List<Object?> get props => [userId, name, frequency, startDate];
}

class HabitDeletedRequested extends HabitsEvent {
  const HabitDeletedRequested(this.habitId);

  final String habitId;

  @override
  List<Object?> get props => [habitId];
}

class HabitsListUpdated extends HabitsEvent {
  const HabitsListUpdated(this.habits);

  final List<HabitModel> habits;

  @override
  List<Object?> get props => [habits];
}

class HabitsLoadFailed extends HabitsEvent {
  const HabitsLoadFailed(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
