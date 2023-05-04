import 'package:flutter/material.dart';
import 'package:news_app/infrastructure/configs/app_theme.dart';

const fontFamily = 'Poppins';

final themeLight = ThemeData(
  primarySwatch: Colors.teal,
  fontFamily: fontFamily,
  accentColor: AppTheme.light.primary,
  primaryColor: AppTheme.light.primary,
  brightness: Brightness.light,
  backgroundColor: Colors.white,
  splashColor: Colors.transparent,
  scaffoldBackgroundColor: Colors.white,
  pageTransitionsTheme: PageTransitionsTheme(
    builders: {
      TargetPlatform.android: ZoomPageTransitionsBuilder(),
      TargetPlatform.iOS: ZoomPageTransitionsBuilder(),
    },
  ),
  colorScheme: ThemeData.light().colorScheme.copyWith(
    primary: AppTheme.light.primary,
    background: AppTheme.light.background,
  ),
);

final themeDark = ThemeData(
  fontFamily: fontFamily,
  primaryColor: AppTheme.light.primary,
  brightness: Brightness.dark,
  backgroundColor: Colors.grey[800],
  splashColor: Colors.transparent,
  scaffoldBackgroundColor: Colors.grey[900],
  pageTransitionsTheme: PageTransitionsTheme(
    builders: {
      TargetPlatform.android: ZoomPageTransitionsBuilder(),
      TargetPlatform.iOS: ZoomPageTransitionsBuilder(),
    }
  ),
  colorScheme: ThemeData.dark().colorScheme.copyWith(
    primary: AppTheme.light.primary,
    background: AppTheme.light.background,
    brightness: Brightness.dark,
  )
);