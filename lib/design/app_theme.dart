import 'package:flutter/material.dart';
import 'package:seeds/design/app_color_schemes.dart';
import 'package:seeds/design/app_colors.dart';

class SeedsAppTheme {
  static ThemeData get newDarkTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: AppColorSchemes.darkColorScheme,
      appBarTheme: const AppBarTheme(
          elevation: 0.0,
          titleTextStyle:
              TextStyle(fontSize: 18, fontWeight: FontWeight.w600) // headline7
          ),
      scaffoldBackgroundColor: AppColorSchemes.darkColorScheme.background,
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: AppColorSchemes.darkColorScheme.background),
      fontFamily: 'SFProDisplay',
      textTheme: SeedsTextTheme.darkTheme,
      inputDecorationTheme: SeedsInputDecorationTheme.darkTheme,
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        contentTextStyle:
            TextStyle(color: AppColorSchemes.darkColorScheme.onBackground),
      ),
      indicatorColor: AppColorSchemes.darkColorScheme.secondary,
    );
  }

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: AppColorSchemes.lightColorScheme,
      primaryColor: AppColors.primary,
      fontFamily: 'SFProDisplay',
      textTheme: SeedsTextTheme.lightTheme,
      brightness: Brightness.light,
      canvasColor: AppColors.primary,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.primary,
        elevation: 0.0,
        titleTextStyle:
            TextStyle(fontSize: 18, fontWeight: FontWeight.w600), // headline7
      ),
      inputDecorationTheme: SeedsInputDecorationTheme.lightTheme,
      snackBarTheme: const SnackBarThemeData(
        backgroundColor: AppColors.grey,
        behavior: SnackBarBehavior.floating,
        contentTextStyle: TextStyle(color: AppColors.white),
      ),
      indicatorColor: AppColors.green1,
      sliderTheme: const SliderThemeData(
        thumbColor: AppColors.white,
        thumbShape: RoundSliderThumbShape(),
        trackHeight: 4.0,
        activeTrackColor: AppColors.green1,
        inactiveTrackColor: AppColors.lightGreen6,
        valueIndicatorColor: AppColors.green1,
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: AppColorSchemes.darkColorScheme,
      primaryColor: AppColors.primary,
      fontFamily: 'SFProDisplay',
      textTheme: SeedsTextTheme.darkTheme,
      brightness: Brightness.dark,
      canvasColor: AppColors.primary,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.primary,
        elevation: 0.0,
        titleTextStyle:
            TextStyle(fontSize: 18, fontWeight: FontWeight.w600), // headline7
      ),
      inputDecorationTheme: SeedsInputDecorationTheme.darkTheme,
      snackBarTheme: const SnackBarThemeData(
        backgroundColor: AppColors.grey,
        behavior: SnackBarBehavior.floating,
        contentTextStyle: TextStyle(color: AppColors.white),
      ),
      indicatorColor: AppColors.green1,
      sliderTheme: const SliderThemeData(
        thumbColor: AppColors.white,
        thumbShape: RoundSliderThumbShape(),
        trackHeight: 4.0,
        activeTrackColor: AppColors.green1,
        inactiveTrackColor: AppColors.lightGreen6,
        valueIndicatorColor: AppColors.green1,
      ),
    );
  }
}

// # w100 Thin, the least thick
// # w200 Extra-light
// # w300 Light
// # w400 Normal / regular / plain
// # w500 Medium
// # w600 Semi-bold
// # w700 Bold
// # w800 Extra-bold
// # w900 Black, the most thick
class SeedsTextTheme {
  static TextTheme get lightTheme {
    return const TextTheme(
      displayLarge: TextStyle(fontSize: 42, fontWeight: FontWeight.w600),
      displayMedium: TextStyle(fontSize: 36, fontWeight: FontWeight.w500),
      displaySmall: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
      headlineLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
      headlineMedium: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
      headlineSmall: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
      titleLarge: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
      titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      titleSmall: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
      bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
      bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
      bodySmall: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
      labelLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
      labelMedium: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
      labelSmall: TextStyle(fontSize: 10, fontWeight: FontWeight.w500),
    ).apply(displayColor: Colors.black, bodyColor: Colors.black);
  }

  static TextTheme get darkTheme {
    return const TextTheme(
      displayLarge: TextStyle(fontSize: 42, fontWeight: FontWeight.w600),
      displayMedium: TextStyle(fontSize: 36, fontWeight: FontWeight.w500),
      displaySmall: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
      headlineLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
      headlineMedium: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
      headlineSmall: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
      titleLarge: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
      titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      titleSmall: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
      bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
      bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
      bodySmall: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
      labelLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
      labelMedium: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
      labelSmall: TextStyle(fontSize: 10, fontWeight: FontWeight.w500),
    ).apply(displayColor: Colors.white, bodyColor: Colors.white);
  }
}

// Make sure to import this file in order to use this text styles USE: import 'package:seeds/design/app_theme.dart';
// https://dart.dev/guides/language/extension-methods
extension CustomStyles on TextTheme {
  // Legacy headline styles (for backward compatibility)
  TextStyle get headline7 =>
      const TextStyle(fontSize: 18, fontWeight: FontWeight.w600);
  TextStyle get headline7LowEmphasis =>
      const TextStyle(fontSize: 18, fontWeight: FontWeight.w400);
  TextStyle get headline8 =>
      const TextStyle(fontSize: 20, fontWeight: FontWeight.w500);

  // Material 3 compatible styles (replacing deprecated properties)
  TextStyle get displaySmall =>
      const TextStyle(fontSize: 16, fontWeight: FontWeight.w400);
  TextStyle get headlineMedium =>
      const TextStyle(fontSize: 28, fontWeight: FontWeight.w600);
  TextStyle get headline4 =>
      const TextStyle(fontSize: 36, fontWeight: FontWeight.w500);
  TextStyle get headline5 =>
      const TextStyle(fontSize: 28, fontWeight: FontWeight.w600);
  TextStyle get titleLarge =>
      const TextStyle(fontSize: 22, fontWeight: FontWeight.w500);
  TextStyle get titleMedium =>
      const TextStyle(fontSize: 18, fontWeight: FontWeight.w500);
  TextStyle get titleSmall =>
      const TextStyle(fontSize: 14, fontWeight: FontWeight.w500);
  TextStyle get labelLarge =>
      const TextStyle(fontSize: 14, fontWeight: FontWeight.w500);
  TextStyle get labelLarge1 =>
      const TextStyle(fontSize: 14, fontWeight: FontWeight.w500);
  TextStyle get labelLargeWhiteL => const TextStyle(
      fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.white);
  TextStyle get labelLargeLowEmphasis =>
      const TextStyle(fontSize: 14, fontWeight: FontWeight.w400);
  TextStyle get labelLargeGreen1 => const TextStyle(
      fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.green1);
  TextStyle get titleMediumGreen1 => const TextStyle(
      fontSize: 18, fontWeight: FontWeight.w500, color: AppColors.green1);
  TextStyle get titleLargeGreen => const TextStyle(
      fontSize: 22, fontWeight: FontWeight.w500, color: AppColors.green1);
  TextStyle get labelLargeOpacityEmphasis => const TextStyle(
      fontSize: 14, fontWeight: FontWeight.w500, color: Colors.white);
  TextStyle get labelLargeHighEmphasis =>
      const TextStyle(fontSize: 14, fontWeight: FontWeight.w600);
  TextStyle get subtitle1 =>
      const TextStyle(fontSize: 18, fontWeight: FontWeight.w500);
  TextStyle get subtitle2 =>
      const TextStyle(fontSize: 14, fontWeight: FontWeight.w400);
  TextStyle get button =>
      const TextStyle(fontSize: 16, fontWeight: FontWeight.w500);

  // Custom subtitle styles
  TextStyle get subtitle1HighEmphasis =>
      const TextStyle(fontSize: 18, fontWeight: FontWeight.w600);

  TextStyle get subtitle2HighEmphasis =>
      const TextStyle(fontSize: 14, fontWeight: FontWeight.w500);

  TextStyle get subtitle2LowEmphasis =>
      const TextStyle(fontSize: 14, fontWeight: FontWeight.w300);

  TextStyle get subtitle2OpacityEmphasis => const TextStyle(
      fontSize: 12, fontWeight: FontWeight.w400, color: Colors.white);

  TextStyle get subtitle2OpacityBlack => const TextStyle(
      fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black);

  TextStyle get subtitle3 =>
      const TextStyle(fontSize: 12, fontWeight: FontWeight.w400);

  TextStyle get subtitle2Green3LowEmphasis =>
      subtitle2LowEmphasis.copyWith(color: AppColors.green3);

  TextStyle get subtitle2BlackHighEmphasis =>
      subtitle2HighEmphasis.copyWith(color: AppColors.black);

  TextStyle get subtitle2HighEmphasisGreen1 =>
      subtitle2HighEmphasis.copyWith(color: AppColors.green1);

  TextStyle get subtitle2BlackLowEmphasis =>
      subtitle2LowEmphasis.copyWith(color: AppColors.black);

  TextStyle get subtitle2Black => const TextStyle(
      fontSize: 14, fontWeight: FontWeight.w400, color: AppColors.black);

  TextStyle get subtitle2Green2 => const TextStyle(
      fontSize: 14, fontWeight: FontWeight.w400, color: AppColors.green2);

  TextStyle get subtitle2Darkgreen1L => const TextStyle(
      fontSize: 14, fontWeight: FontWeight.w400, color: AppColors.primary);

  TextStyle get subtitle2OpacityEmphasisBlack =>
      subtitle2OpacityEmphasis.copyWith(color: AppColors.black);

  TextStyle get subtitle3Green => subtitle3.copyWith(color: AppColors.green3);

  TextStyle get subtitle3Red => subtitle3.copyWith(color: AppColors.red1);

  TextStyle get subtitle3Opacity => subtitle3.copyWith(color: Colors.white);

  TextStyle get subtitle3LightGreen6 =>
      subtitle3.copyWith(color: AppColors.lightGreen6);

  TextStyle get subtitle3OpacityEmphasis => const TextStyle(
      fontSize: 13, fontWeight: FontWeight.w400, color: Colors.white);

  TextStyle get subtitle3OpacityEmphasisGreen =>
      subtitle3.copyWith(color: AppColors.green3);

  TextStyle get subtitle3OpacityEmphasisRed =>
      subtitle3.copyWith(color: AppColors.red1);

  TextStyle get subtitle4 =>
      const TextStyle(fontSize: 13, fontWeight: FontWeight.w400);

  // Custom button styles
  TextStyle get buttonHighEmphasis => const TextStyle(
      fontSize: 16, fontWeight: FontWeight.w500, letterSpacing: 2);

  TextStyle get buttonOpacityEmphasis => const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      letterSpacing: 2,
      color: Colors.white);

  TextStyle get buttonLowEmphasis =>
      const TextStyle(fontSize: 16, fontWeight: FontWeight.w400);

  TextStyle get button1 =>
      const TextStyle(fontSize: 25, fontWeight: FontWeight.w400);

  TextStyle get button1Black => const TextStyle(
      fontSize: 25, fontWeight: FontWeight.w400, color: AppColors.darkGreen2);

  TextStyle get buttonWhiteL => const TextStyle(
      fontSize: 16, fontWeight: FontWeight.w500, color: AppColors.white);

  TextStyle get buttonGreen1 => const TextStyle(
      fontSize: 16, fontWeight: FontWeight.w500, color: AppColors.green1);

  TextStyle get buttonBlack => const TextStyle(
      fontSize: 16, fontWeight: FontWeight.w500, color: AppColors.black);

  // Custom headline styles
  TextStyle get headline4Black => const TextStyle(
      fontSize: 36, fontWeight: FontWeight.w500, color: AppColors.black);

  TextStyle get headline6Green => const TextStyle(
      fontSize: 22, fontWeight: FontWeight.w500, color: AppColors.green3);

  TextStyle get headline7Green => headline7.copyWith(
      fontSize: 22, fontWeight: FontWeight.w500, color: AppColors.green3);

  TextStyle get subtitle1Green1 => const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w500,
      letterSpacing: 2,
      color: AppColors.green1);

  TextStyle get subtitle1Red2 => const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w500,
      letterSpacing: 2,
      color: AppColors.red1);

  // Additional custom styles for missing properties
  TextStyle get titleMediumHighEmphasis =>
      const TextStyle(fontSize: 18, fontWeight: FontWeight.w600);
  TextStyle get titleMediumRed2 => const TextStyle(
      fontSize: 18, fontWeight: FontWeight.w500, color: AppColors.red2);
}

class SeedsInputDecorationTheme {
  static InputDecorationTheme get lightTheme => InputDecorationTheme(
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.red),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.red),
        ),
      );

  static InputDecorationTheme get darkTheme => InputDecorationTheme(
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.darkGreen2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.darkGreen2),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.red),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.red),
        ),
      );
}
