import 'package:flutter/material.dart';
import 'package:flutter_application_grebenyuk/homeworks/home_work_14/bloc/theme_cubit.dart';
import 'package:flutter_application_grebenyuk/homeworks/home_work_14/bloc/theme_state.dart';
import 'package:flutter_application_grebenyuk/homeworks/home_work_14/constants/app_styles.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeSwitchButton extends StatelessWidget {
  const ThemeSwitchButton({super.key, this.iconOnly = false});

  final bool iconOnly;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, HomeworkThemeState>(
      builder: (context, state) {
        final bool isDark = state.themeMode == ThemeMode.dark;
        final String label = isDark ? 'Світла тема' : 'Темна тема';
        final icon = Icon(
          isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
          key: ValueKey(isDark),
        );

        if (iconOnly) {
          return IconButton(
            tooltip: 'Перемкнути тему',
            onPressed: () => context.read<ThemeCubit>().toggleTheme(),
            icon: AnimatedSwitcher(
              duration: const Duration(milliseconds: 250),
              child: icon,
            ),
          );
        }

        return FilledButton.icon(
          onPressed: () => context.read<ThemeCubit>().toggleTheme(),
          icon: AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),
            child: icon,
          ),
          label: Text(
            label,
            style: Homework14TextStyles.button,
          ),
        );
      },
    );
  }
}
