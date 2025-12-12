import 'package:flutter/material.dart';
import 'package:flutter_application_grebenyuk/homeworks/home_work_14/bloc/theme_cubit.dart';
import 'package:flutter_application_grebenyuk/homeworks/home_work_14/bloc/theme_state.dart';
import 'package:flutter_application_grebenyuk/homeworks/home_work_14/constants/app_constants.dart';
import 'package:flutter_application_grebenyuk/homeworks/home_work_14/constants/app_styles.dart';
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
        final ThemeData themeData = state.themeMode == ThemeMode.dark
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
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return AppScaffold(
      appBar: AppBar(
        title: const Text(Homework14Texts.screenTitle),
        actions: const [ThemeSwitchButton(iconOnly: true)],
      ),
      body: ListView(
        padding: const EdgeInsets.all(Homework14Dimensions.pagePadding),
        children: [
          Container(
            padding: const EdgeInsets.all(Homework14Dimensions.cardPadding),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                Homework14Dimensions.heroBorderRadius,
              ),
              gradient: LinearGradient(
                colors: [
                  colorScheme.primary.withValues(alpha: 0.85),
                  colorScheme.secondary.withValues(alpha: 0.8),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  Homework14Texts.heroTitle,
                  style: Homework14TextStyles.pageTitle.copyWith(
                    color: colorScheme.onPrimary,
                  ),
                ),
                const SizedBox(height: Homework14Dimensions.smallSpacing),
                Text(
                  Homework14Texts.heroSubtitle,
                  style: Homework14TextStyles.body.copyWith(
                    color: colorScheme.onPrimary.withValues(alpha: 0.9),
                  ),
                ),
                const SizedBox(height: Homework14Dimensions.heroSpacing),
                const ThemeSwitchButton(),
              ],
            ),
          ),
          const SizedBox(height: Homework14Dimensions.sectionSpacing),
          Text(
            Homework14Texts.sectionTitle,
            style: Homework14TextStyles.sectionTitle,
          ),
          const SizedBox(height: Homework14Dimensions.tinySpacing),
          Text(
            Homework14Texts.sectionDescription,
            style: Homework14TextStyles.body,
          ),
          const SizedBox(height: Homework14Dimensions.heroSpacing),
          const HomeworkVideoCard(),
          const SizedBox(height: Homework14Dimensions.sectionSpacing),
          const HomeworkAudioCard(),
          const SizedBox(height: Homework14Dimensions.sliderSpacing),
          Text(
            Homework14Texts.themePersistenceNote,
            style: Homework14TextStyles.caption.copyWith(
              color: colorScheme.onSurface.withValues(alpha: 0.7),
            ),
          ),
        ],
      ),
    );
  }
}
