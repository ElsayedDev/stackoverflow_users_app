import 'package:flutter/material.dart';
import 'package:stackoverflow_users_app/generated/colors.gen.dart';

abstract class SOFTheme {
  static ThemeData light = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: ColorName.sofBg,
    colorScheme: ColorScheme.fromSeed(
      seedColor: ColorName.sofOrange,
      primary: ColorName.sofOrange,
      secondary: ColorName.sofBlue,
      surface: Colors.white,
    ),
    appBarTheme: const AppBarTheme(
      elevation: 0,
      backgroundColor: Colors.white,
      foregroundColor: ColorName.sofText,
      centerTitle: false,
      titleTextStyle: TextStyle(
        color: ColorName.sofText,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
    ),
    dividerColor: ColorName.sofBorder,
    cardColor: Colors.white,
    textTheme: const TextTheme(
      bodyLarge: TextStyle(fontSize: 16, color: ColorName.sofText),
      bodyMedium: TextStyle(fontSize: 14, color: ColorName.sofText),
      bodySmall: TextStyle(fontSize: 12, color: ColorName.sofMuted),
      titleMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: ColorName.sofText,
      ),
      labelSmall: TextStyle(fontSize: 12, color: ColorName.sofMuted),
    ),
    chipTheme: const ChipThemeData(
      side: BorderSide(color: ColorName.sofBorder),
      backgroundColor: Colors.white,
      labelStyle: TextStyle(color: ColorName.sofText),
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      shape: StadiumBorder(),
    ),
    listTileTheme: const ListTileThemeData(
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      dense: true,
    ),
  );
}
