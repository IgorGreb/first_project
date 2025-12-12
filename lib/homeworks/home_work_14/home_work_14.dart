import 'package:flutter/material.dart';
import 'package:flutter_application_grebenyuk/homeworks/home_work_14/bloc/theme_cubit.dart';
import 'package:flutter_application_grebenyuk/homeworks/home_work_14/bloc/theme_state.dart';
import 'package:flutter_application_grebenyuk/homeworks/home_work_14/widgets/audio_player_card.dart';
import 'package:flutter_application_grebenyuk/homeworks/home_work_14/widgets/theme_switch_button.dart';
import 'package:flutter_application_grebenyuk/homeworks/home_work_14/widgets/video_player_card.dart';
import 'package:flutter_application_grebenyuk/widgets/app_scaffold.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeWork14 extends StatelessWidget {
  const HomeWork14({super.key});

  static const String routeName = '/homework-fourteen';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ThemeCubit(HomeworkThemeStorage()),
      child: const _Homework14ThemeWrapper(),
    );
  }
}

class _Homework14ThemeWrapper extends StatelessWidget {
  const _Homework14ThemeWrapper();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, HomeworkThemeState>(
      builder: (context, state) {
        if (!state.isInitialized) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final themeCubit = context.read<ThemeCubit>();
        final ThemeData themeData =
            state.themeMode == ThemeMode.dark
                ? themeCubit.darkTheme
                : themeCubit.lightTheme;

        return Theme(data: themeData, child: const _Homework14View());
      },
    );
  }
}

class _Homework14View extends StatelessWidget {
  const _Homework14View();

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(actions: const [ThemeSwitchButton(iconOnly: true)]),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          const SizedBox(height: 28),

          const SizedBox(height: 6),

          const SizedBox(height: 18),
          const HomeworkVideoCard(),
          const SizedBox(height: 28),
          const HomeworkAudioCard(),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}
