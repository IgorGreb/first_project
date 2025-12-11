import 'dart:async';

import 'package:flutter_application_grebenyuk/homeworks/home_work_12/bloc/habits_event.dart';
import 'package:flutter_application_grebenyuk/homeworks/home_work_12/bloc/habits_state.dart';
import 'package:flutter_application_grebenyuk/homeworks/home_work_12/models/habit_model.dart';
import 'package:flutter_application_grebenyuk/homeworks/home_work_12/services/habit_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HabitsBloc extends Bloc<HabitsEvent, HabitsState> {
  HabitsBloc({required HabitRepository habitRepository})
      : _habitRepository = habitRepository,
        super(const HabitsState()) {
    on<HabitsSubscriptionRequested>(_onSubscriptionRequested);
    on<HabitsListUpdated>(_onHabitsListUpdated);
    on<HabitsLoadFailed>(_onHabitsLoadFailed);
    on<HabitCompletionToggled>(_onHabitCompletionToggled);
    on<HabitAddedRequested>(_onHabitAddedRequested);
    on<HabitDeletedRequested>(_onHabitDeletedRequested);
  }

  final HabitRepository _habitRepository;
  StreamSubscription<List<HabitModel>>? _habitsSubscription;

  Future<void> _onSubscriptionRequested(
    HabitsSubscriptionRequested event,
    Emitter<HabitsState> emit,
  ) async {
    emit(state.copyWith(status: HabitsStatus.loading, clearError: true));
    await _habitsSubscription?.cancel();
    _habitsSubscription =
        _habitRepository.watchHabits(userId: event.userId).listen(
              (habits) => add(HabitsListUpdated(habits)),
              onError: (error, _) => add(
                HabitsLoadFailed(error.toString()),
              ),
            );
  }

  void _onHabitsListUpdated(
    HabitsListUpdated event,
    Emitter<HabitsState> emit,
  ) {
    emit(
      state.copyWith(
        status: HabitsStatus.success,
        habits: event.habits,
        clearError: true,
      ),
    );
  }

  void _onHabitsLoadFailed(
    HabitsLoadFailed event,
    Emitter<HabitsState> emit,
  ) {
    emit(
      state.copyWith(
        status: HabitsStatus.failure,
        errorMessage: event.message,
      ),
    );
  }

  Future<void> _onHabitCompletionToggled(
    HabitCompletionToggled event,
    Emitter<HabitsState> emit,
  ) async {
    final toggling = <String>{...state.updatingHabitIds, event.habitId};
    emit(state.copyWith(updatingHabitIds: toggling, clearError: true));
    try {
      await _habitRepository.toggleHabitProgress(
        habitId: event.habitId,
        date: event.date,
        isComplete: event.isComplete,
      );
    } catch (_) {
      emit(
        state.copyWith(
          errorMessage: 'Не вдалося оновити прогрес',
          updatingHabitIds: {...state.updatingHabitIds}..remove(event.habitId),
        ),
      );
      return;
    }
    final updated = <String>{...state.updatingHabitIds}..remove(event.habitId);
    emit(state.copyWith(updatingHabitIds: updated, clearError: true));
  }

  Future<void> _onHabitAddedRequested(
    HabitAddedRequested event,
    Emitter<HabitsState> emit,
  ) async {
    emit(state.copyWith(isSubmitting: true, clearError: true));
    try {
      await _habitRepository.addHabit(
        userId: event.userId,
        name: event.name,
        frequency: event.frequency,
        startDate: event.startDate,
      );
      emit(state.copyWith(isSubmitting: false));
    } catch (_) {
      emit(
        state.copyWith(
          isSubmitting: false,
          errorMessage: 'Не вдалося створити звичку',
        ),
      );
    }
  }

  Future<void> _onHabitDeletedRequested(
    HabitDeletedRequested event,
    Emitter<HabitsState> emit,
  ) async {
    final toggling = <String>{...state.updatingHabitIds, event.habitId};
    emit(state.copyWith(updatingHabitIds: toggling));
    try {
      await _habitRepository.deleteHabit(event.habitId);
    } catch (_) {
      emit(
        state.copyWith(
          errorMessage: 'Не вдалося видалити звичку',
          updatingHabitIds: {...state.updatingHabitIds}..remove(event.habitId),
        ),
      );
      return;
    }
    emit(
      state.copyWith(
        updatingHabitIds: {...state.updatingHabitIds}..remove(event.habitId),
      ),
    );
  }

  @override
  Future<void> close() async {
    await _habitsSubscription?.cancel();
    return super.close();
  }
}
