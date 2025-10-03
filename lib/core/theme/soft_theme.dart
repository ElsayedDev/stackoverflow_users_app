import 'package:flutter/material.dart';
import 'package:stackoverflow_users_app/core/theme/sof_colors.dart';

abstract class SOFTheme {
  static ThemeData light = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: SOFColors.bg,
    colorScheme: ColorScheme.fromSeed(
      seedColor: SOFColors.orange,
      primary: SOFColors.orange,
      secondary: SOFColors.blue,
      background: SOFColors.bg,
    ),
    appBarTheme: const AppBarTheme(
      elevation: 0,
      backgroundColor: Colors.white,
      foregroundColor: SOFColors.text,
      centerTitle: false,
      titleTextStyle: TextStyle(
        color: SOFColors.text,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
    ),
    dividerColor: SOFColors.border,
    cardColor: Colors.white,
    textTheme: const TextTheme(
      bodyLarge: TextStyle(fontSize: 16, color: SOFColors.text),
      bodyMedium: TextStyle(fontSize: 14, color: SOFColors.text),
      bodySmall: TextStyle(fontSize: 12, color: SOFColors.muted),
      titleMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: SOFColors.text,
      ),
      labelSmall: TextStyle(fontSize: 12, color: SOFColors.muted),
    ),
    chipTheme: const ChipThemeData(
      side: BorderSide(color: SOFColors.border),
      backgroundColor: Colors.white,
      labelStyle: TextStyle(color: SOFColors.text),
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      shape: StadiumBorder(),
    ),
    listTileTheme: const ListTileThemeData(
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      dense: true,
    ),
  );
}
