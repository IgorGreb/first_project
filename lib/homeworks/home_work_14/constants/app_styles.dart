import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Homework14Colors {
  Homework14Colors._();

  static const Color accent = Color(0xFF7C5CFF);
  static const Color secondary = Color(0xFFFF8F66);
  static const Color lightBackground = Color(0xFFF3F1FF);
  static const Color darkBackground = Color(0xFF0E1224);
  static const Color lightCard = Color(0xFFFFFFFF);
  static const Color darkCard = Color(0xFF1B2036);
  static const Color success = Color(0xFF4DD0E1);
}

class Homework14TextStyles {
  Homework14TextStyles._();

  static TextStyle get pageTitle => GoogleFonts.raleway(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.4,
      );

  static TextStyle get sectionTitle => GoogleFonts.raleway(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.2,
      );

  static TextStyle get body => GoogleFonts.inter(
        fontSize: 15,
        height: 1.5,
        fontWeight: FontWeight.w500,
      );

  static TextStyle get button => GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.3,
      );

  static TextStyle get caption => GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.3,
      );

  static TextTheme textTheme(Brightness brightness) {
    final Color textColor =
        brightness == Brightness.dark ? Colors.white : const Color(0xFF1F1A35);
    return TextTheme(
      displayLarge: pageTitle,
      headlineMedium: sectionTitle,
      bodyLarge: body,
      bodyMedium: body.copyWith(fontSize: 14),
      labelLarge: button,
      labelSmall: caption,
    ).apply(
      displayColor: textColor,
      bodyColor: textColor,
    );
  }
}

class Homework14Themes {
  Homework14Themes._();

  static final ThemeData lightTheme = _createTheme(Brightness.light);
  static final ThemeData darkTheme = _createTheme(Brightness.dark);

  static ThemeData _createTheme(Brightness brightness) {
    final bool isDark = brightness == Brightness.dark;
    final Color backgroundColor = isDark
        ? Homework14Colors.darkBackground
        : Homework14Colors.lightBackground;
    final Color surfaceColor =
        isDark ? Homework14Colors.darkCard : Homework14Colors.lightCard;
    final ColorScheme colorScheme = ColorScheme.fromSeed(
      seedColor: Homework14Colors.accent,
      brightness: brightness,
      primary: Homework14Colors.accent,
      surface: surfaceColor,
      secondary: Homework14Colors.secondary,
      tertiary: Homework14Colors.success,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      scaffoldBackgroundColor: backgroundColor,
      colorScheme: colorScheme,
      textTheme: Homework14TextStyles.textTheme(brightness),
      appBarTheme: AppBarTheme(
        backgroundColor:
            colorScheme.surface.withValues(alpha: isDark ? 0.8 : 0.9),
        elevation: 0,
        centerTitle: true,
        titleTextStyle: Homework14TextStyles.pageTitle.copyWith(
          color: colorScheme.onSurface,
          fontSize: 20,
        ),
        iconTheme: IconThemeData(color: colorScheme.onSurface),
      ),
      cardColor: colorScheme.surface,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          textStyle: Homework14TextStyles.button,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: colorScheme.primary.withValues(alpha: 0.15),
          foregroundColor: colorScheme.primary,
          textStyle: Homework14TextStyles.button,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        ),
      ),
      sliderTheme: SliderThemeData(
        activeTrackColor: colorScheme.primary,
        inactiveTrackColor: colorScheme.primary.withValues(alpha: 0.3),
        thumbColor: colorScheme.secondary,
        overlayColor: colorScheme.primary.withValues(alpha: 0.1),
      ),
      iconTheme: IconThemeData(color: colorScheme.primary),
    );
  }
}
