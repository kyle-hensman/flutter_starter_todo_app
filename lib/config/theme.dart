import 'package:flutter/material.dart';

class AppColors {
  static Color primary = const Color.fromARGB(255, 190, 130, 255);
  static Color onPrimary = const Color.fromARGB(255, 167, 84, 255);
  static Color primaryContainer = const Color.fromARGB(255, 81, 1, 255);
  static Color secondaryLight = const Color(0xFF696F8C);
  static Color secondaryDark = const Color.fromARGB(255, 210, 210, 210);
  static Color onSecondary = const Color(0xFFD7D9E4);
  static Color secondaryContainer = const Color(0xFFE9EBF9);
  static Color tertiary = const Color.fromARGB(255, 15, 122, 179);
  static Color onTertiaryLight = const Color(0xFF9E9E9E);
  static Color onTertiaryDark = const Color.fromARGB(255, 106, 106, 106);

  static Color white = const Color(0xFFFFFFFF);
  static Color offWhite = const Color(0xFFEBEEF3);
  static Color black = const Color(0xFF000000);
  static Color slate = const Color.fromARGB(255, 98, 98, 98);
  static Color lighterBlueGrey = const Color(0xFFE9EBF8);
  static Color lightBlueGrey = const Color(0xFFF8F9FB);

  static Color error = const Color(0xFFEA7E84);

  static Color bodyTextLight = const Color(0xff2D2A4E);
  static Color bodyTextDark = const Color.fromARGB(255, 198, 198, 198);
}

class AppFonts {
  static String primary = 'OpenSans';
  static const xs = 12.00;
  static const small = 14.00;
  static const medium = 16.00;
  static const large = 18.00;
  static const xl = 20.00;
  static const jumbo = 30.00;
}

class AppThemes {
  ThemeData lightTheme() {
    return ThemeData(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      fontFamily: AppFonts.primary,
      secondaryHeaderColor: AppColors.primary,
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.white,
      inputDecorationTheme: InputDecorationTheme(
        focusColor: AppColors.black,
      ),
      colorScheme: ColorScheme.light(
        outline: AppColors.bodyTextLight,
        background: AppColors.white,
        primary: AppColors.primary,
        onPrimary: AppColors.onPrimary,
        primaryContainer: AppColors.primaryContainer,
        secondary: AppColors.secondaryLight,
        secondaryContainer: AppColors.secondaryContainer,
        onSecondary: AppColors.onSecondary,
        error: AppColors.error,
        tertiary: AppColors.tertiary,
        onTertiary: AppColors.onTertiaryLight,
        surface: AppColors.white,
        onSurfaceVariant: AppColors.lightBlueGrey,
        surfaceTint: AppColors.lighterBlueGrey,
        onSecondaryContainer: AppColors.offWhite,
      ),
      appBarTheme: AppBarTheme(
        centerTitle: true,
        backgroundColor: AppColors.white,
        foregroundColor: AppColors.primary,
        titleTextStyle: TextStyle(
          fontSize: AppFonts.large, // 18
          color: AppColors.black,
          fontWeight: FontWeight.w600,
          fontFamily: AppFonts.primary,
        ),
      ),
      textTheme: TextTheme(
        titleSmall: TextStyle(
          color: AppColors.secondaryLight,
          fontSize: AppFonts.xs, // 12
        ),
        titleMedium: TextStyle(
          color: AppColors.bodyTextLight,
          fontSize: AppFonts.small, // 14
          fontWeight: FontWeight.w500,
        ),
        headlineMedium: TextStyle(
          color: AppColors.bodyTextLight,
          fontSize: AppFonts.medium, // 16
          fontWeight: FontWeight.w600,
        ),
        labelSmall: TextStyle(
          color: AppColors.error,
          fontSize: AppFonts.large, // 18
        ),
        labelMedium: TextStyle(
          color: AppColors.primary,
          fontSize: AppFonts.medium, // 16
        ),
        bodySmall: TextStyle(
          color: AppColors.bodyTextLight,
          fontSize: AppFonts.small, // 14
        ),
        bodyMedium: TextStyle(
          color: AppColors.bodyTextLight,
          fontSize: AppFonts.medium, // 16
        ),
        bodyLarge: TextStyle(
          color: AppColors.bodyTextLight,
          fontSize: AppFonts.large, // 18
        ),
        titleLarge: TextStyle(
          color: AppColors.bodyTextLight,
          fontSize: AppFonts.xl, // 20
          fontWeight: FontWeight.bold,
        ),
        displaySmall: TextStyle(
          color: AppColors.bodyTextLight,
          fontWeight: FontWeight.bold,
          fontFamily: AppFonts.primary,
          fontSize: AppFonts.xl, // 20
        ),
        displayMedium: TextStyle(
          color: AppColors.primary,
          fontWeight: FontWeight.bold,
          fontFamily: AppFonts.primary,
          fontSize: AppFonts.jumbo,
        ),
      ),
      tabBarTheme: TabBarTheme(
        labelColor: AppColors.secondaryLight,
        unselectedLabelColor: AppColors.secondaryLight,
        indicator: UnderlineTabIndicator(
          borderSide: BorderSide(
            width: 4,
            color: AppColors.secondaryLight,
          ),
        ),
        unselectedLabelStyle: TextStyle(
          fontWeight: FontWeight.bold,
          fontFamily: AppFonts.primary,
        ),
        labelStyle: TextStyle(
          fontWeight: FontWeight.bold,
          fontFamily: AppFonts.primary,
        ),
        indicatorSize: TabBarIndicatorSize.label,
      ),
      drawerTheme: DrawerThemeData(
        backgroundColor: AppColors.white,
      ),
      iconTheme: IconThemeData(
        color: AppColors.primary,
      ),
      listTileTheme: ListTileThemeData(
        selectedColor: AppColors.secondaryLight,
        iconColor: AppColors.primary,
        selectedTileColor: AppColors.tertiary,
      ),
    );
  }

  ThemeData darkTheme() {
    return ThemeData(
      brightness: Brightness.dark,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      scaffoldBackgroundColor: AppColors.slate,
      fontFamily: AppFonts.primary,
      secondaryHeaderColor: AppColors.primary,
      inputDecorationTheme: InputDecorationTheme(
        focusColor: AppColors.white,
      ),
      colorScheme: ColorScheme.dark(
        outline: AppColors.bodyTextDark,
        background: AppColors.slate,
        primary: AppColors.primary,
        onPrimary: AppColors.onPrimary,
        primaryContainer: AppColors.primaryContainer,
        secondary: AppColors.secondaryDark,
        secondaryContainer: AppColors.secondaryContainer,
        onSecondary: AppColors.onSecondary,
        error: AppColors.error,
        tertiary: AppColors.tertiary,
        onTertiary: AppColors.onTertiaryDark,
        surface: AppColors.slate,
        onSurfaceVariant: AppColors.lightBlueGrey,
        surfaceTint: AppColors.lighterBlueGrey,
        onSecondaryContainer: AppColors.slate,
      ),
      appBarTheme: AppBarTheme(
        centerTitle: true,
        backgroundColor: AppColors.slate,
        foregroundColor: AppColors.primary,
        titleTextStyle: TextStyle(
          fontSize: AppFonts.large, // 18
          color: AppColors.white,
          fontWeight: FontWeight.w600,
          fontFamily: AppFonts.primary,
        ),
      ),
      textTheme: TextTheme(
        titleSmall: TextStyle(
          color: AppColors.secondaryDark,
          fontSize: AppFonts.xs, // 12
        ),
        titleMedium: TextStyle(
          color: AppColors.bodyTextDark,
          fontSize: AppFonts.small, // 14
          fontWeight: FontWeight.w500,
        ),
        headlineMedium: TextStyle(
          color: AppColors.bodyTextDark,
          fontSize: AppFonts.medium, // 16
          fontWeight: FontWeight.w600,
        ),
        labelSmall: TextStyle(
          color: AppColors.error,
          fontSize: AppFonts.large, // 18
        ),
        labelMedium: TextStyle(
          color: AppColors.primary,
          fontSize: AppFonts.medium, // 16
        ),
        bodySmall: TextStyle(
          color: AppColors.bodyTextDark,
          fontSize: AppFonts.small, // 14
        ),
        bodyMedium: TextStyle(
          color: AppColors.bodyTextDark,
          fontSize: AppFonts.medium, // 16
        ),
        bodyLarge: TextStyle(
          color: AppColors.bodyTextDark,
          fontSize: AppFonts.large, // 18
        ),
        titleLarge: TextStyle(
          color: AppColors.bodyTextDark,
          fontSize: AppFonts.xl, // 20
          fontWeight: FontWeight.bold,
        ),
        displaySmall: TextStyle(
          color: AppColors.bodyTextDark,
          fontWeight: FontWeight.bold,
          fontFamily: AppFonts.primary,
          fontSize: AppFonts.xl, // 20
        ),
        displayMedium: TextStyle(
          color: AppColors.primary,
          fontWeight: FontWeight.bold,
          fontFamily: AppFonts.primary,
          fontSize: AppFonts.jumbo,
        ),
      ),
      tabBarTheme: TabBarTheme(
        labelColor: AppColors.secondaryDark,
        unselectedLabelColor: AppColors.secondaryDark,
        indicator: UnderlineTabIndicator(
          borderSide: BorderSide(
            width: 4,
            color: AppColors.secondaryDark,
          ),
        ),
        unselectedLabelStyle: TextStyle(
          fontWeight: FontWeight.bold,
          fontFamily: AppFonts.primary,
        ),
        labelStyle: TextStyle(
          fontWeight: FontWeight.bold,
          fontFamily: AppFonts.primary,
        ),
        indicatorSize: TabBarIndicatorSize.label,
      ),
      drawerTheme: DrawerThemeData(
        backgroundColor: AppColors.white,
      ),
      iconTheme: IconThemeData(
        color: AppColors.primary,
      ),
      listTileTheme: ListTileThemeData(
        selectedColor: AppColors.secondaryDark,
        iconColor: AppColors.primary,
        selectedTileColor: AppColors.tertiary,
      ),
    );
  }
}
