import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_grebenyuk/homeworks/home_work_12/bloc/habits_bloc.dart';
import 'package:flutter_application_grebenyuk/homeworks/home_work_12/bloc/habits_event.dart';
import 'package:flutter_application_grebenyuk/homeworks/home_work_12/bloc/habits_state.dart';
import 'package:flutter_application_grebenyuk/homeworks/home_work_12/constants/habit_dimens.dart';
import 'package:flutter_application_grebenyuk/homeworks/home_work_12/constants/habit_texts.dart';
import 'package:flutter_application_grebenyuk/homeworks/home_work_12/models/habit_model.dart';
import 'package:flutter_application_grebenyuk/homeworks/home_work_12/services/auth_repository.dart';
import 'package:flutter_application_grebenyuk/homeworks/home_work_12/widgets/add_habit_sheet.dart';
import 'package:flutter_application_grebenyuk/homeworks/home_work_12/widgets/habit_card.dart';
import 'package:flutter_application_grebenyuk/homeworks/home_work_12/widgets/habit_detail_page.dart';
import 'package:flutter_application_grebenyuk/widgets/app_scaffold.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class HabitsPage extends StatelessWidget {
  const HabitsPage({super.key, required this.user});

  final User user;

  @override
  Widget build(BuildContext context) {
    return BlocListener<HabitsBloc, HabitsState>(
      listenWhen: (previous, current) =>
          previous.errorMessage != current.errorMessage &&
          current.errorMessage != null,
      listener: (context, state) {
        final message = state.errorMessage;
        if (message == null) return;
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(SnackBar(content: Text(message)));
      },
      child: AppScaffold(
        title: HabitTexts.habitsTitle,
        actions: [
          TextButton.icon(
            onPressed: () => context.read<AuthRepository>().signOut(),
            icon: const Icon(Icons.logout),
            label: const Text(HabitTexts.logout),
          ),
        ],
        body: const _HabitsBody(),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => _openAddHabitSheet(context, user.uid),
          label: const Text(HabitTexts.addHabitButton),
          icon: const Icon(Icons.add),
        ),
      ),
    );
  }
}

void _openAddHabitSheet(BuildContext context, String userId) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (_) => BlocProvider.value(
      value: context.read<HabitsBloc>(),
      child: AddHabitSheet(userId: userId),
    ),
  );
}

class _HabitsBody extends StatelessWidget {
  const _HabitsBody();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HabitsBloc, HabitsState>(
      builder: (context, state) {
        switch (state.status) {
          case HabitsStatus.initial:
          case HabitsStatus.loading:
            return const Center(child: CircularProgressIndicator());
          case HabitsStatus.failure:
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.error_outline, size: HabitDimens.errorIconSize),
                  const SizedBox(height: HabitDimens.spaceMD),
                  Text(
                    state.errorMessage ?? HabitTexts.loadError,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: HabitDimens.spaceMD),
                  FilledButton(
                    onPressed: () {
                      final bloc = context.read<HabitsBloc>();
                      final userId = (bloc.state.habits.isNotEmpty
                              ? bloc.state.habits.first.userId
                              : null) ??
                          FirebaseAuth.instance.currentUser?.uid;
                      if (userId != null) {
                        bloc.add(HabitsSubscriptionRequested(userId));
                      }
                    },
                    child: const Text(HabitTexts.retry),
                  ),
                ],
              ),
            );
          case HabitsStatus.success:
            if (state.habits.isEmpty) {
              return const _EmptyHabitsView();
            }
            return Padding(
              padding: const EdgeInsets.all(HabitDimens.pagePadding),
              child: _HabitsGrid(habits: state.habits),
            );
        }
      },
    );
  }
}

class _HabitsGrid extends StatelessWidget {
  const _HabitsGrid({required this.habits});

  final List<HabitModel> habits;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final updatingIds =
        context.select((HabitsBloc bloc) => bloc.state.updatingHabitIds);
    final crossAxisCount = width > 1000
        ? 3
        : width > 600
            ? 2
            : 1;

    return MasonryGridView.count(
      crossAxisCount: crossAxisCount,
      mainAxisSpacing: HabitDimens.spaceMD,
      crossAxisSpacing: HabitDimens.spaceMD,
      itemCount: habits.length,
      itemBuilder: (context, index) {
        final habit = habits[index];
        final isUpdating = updatingIds.contains(habit.id);
        return HabitCard(
          habit: habit,
          isUpdating: isUpdating,
          onToggle: (value) => context.read<HabitsBloc>().add(
                HabitCompletionToggled(
                  habitId: habit.id,
                  date: DateTime.now(),
                  isComplete: value,
                ),
              ),
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => BlocProvider.value(
                value: context.read<HabitsBloc>(),
                child: HabitDetailPage(habit: habit),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _EmptyHabitsView extends StatelessWidget {
  const _EmptyHabitsView();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(HabitDimens.pagePadding),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.auto_stories_outlined,
              size: HabitDimens.emptyIconSize,
              color: theme.colorScheme.primary,
            ),
            const SizedBox(height: HabitDimens.spaceMD),
            Text(
              HabitTexts.emptyHabits,
              style: theme.textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
