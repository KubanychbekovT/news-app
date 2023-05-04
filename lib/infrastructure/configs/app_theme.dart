import 'package:flutter/material.dart';
import 'package:news_app/infrastructure/configs/app_core_theme.dart';

class AppTheme {
  static final _core = AppCoreTheme(
    primary: const Color(0xff5ba897),
    primaryDark: const Color(0xff46536d),
    accent: Color(0xfff8a488),
    shadow: Colors.black.withOpacity(0.20),
    shadowSub: Colors.black.withOpacity(0.12),
    textSub: Color(0xff828282),
  );
  
  static AppCoreTheme light = _core.copyWith(
    background: Colors.white,
    backgroundSub: Color(0xfff0f0f),
    scaffold: Color(0xfffefefe),
    scaffoldDark: Color(0xfffcfcfc),
    text: Color(0xff484848),
    textSub2: Colors.black.withOpacity(0.25),
  );
  
  static AppCoreTheme dark = _core.copyWith(
    background: Color(0xff1c1c1e),
    backgroundSub: Color(0xff1c1c1e),
    scaffold: Color(0xff0e0e0e),
    text: Colors.white,
    textSub2: Colors.white.withOpacity(0.25),
  );

  static AppCoreTheme? c;

  static init(BuildContext context) {
    c = isDark(context) ? dark : light;
  }

  static bool isDark(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark;
}