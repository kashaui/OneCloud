import 'package:flutter/material.dart';
import 'package:bedrive/config/themes/backend-theme-config.dart';

ThemeData buildTheme(BuildContext context, BackendThemeConfig themeConfig) {
  return ThemeData(
    brightness: themeConfig.isDark ? Brightness.dark : Brightness.light,
    primaryColor: themeConfig.colors['--be-accent-default'],
    buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary, buttonColor: themeConfig.colors['--be-accent-default']),
    primaryColorLight: themeConfig.colors['--be-accent-light'],
    primaryColorDark: themeConfig.colors['--be-accent-dark'],
    accentColor: themeConfig.colors['--be-accent-default'],
    selectedRowColor: themeConfig.colors['--be-accent-emphasis'],
    dividerColor: themeConfig.colors['--be-divider-color'],
    backgroundColor: themeConfig.colors['--be-accent-color-light'],
    cardColor: themeConfig.colors['--be-background'],
    scaffoldBackgroundColor: themeConfig.colors['--be-background-alternative'],
    dialogBackgroundColor: themeConfig.colors['--be-background'],
    hintColor: themeConfig.colors['--be-hint-text'],
    canvasColor: themeConfig.colors['--be-background'],
    appBarTheme: AppBarTheme(
      brightness: themeConfig.isDark ? Brightness.light : Brightness.dark,
      color: themeConfig.isDark ? themeConfig.colors['--be-background-alternative'] : themeConfig.colors['--be-accent-default'],
      iconTheme: IconThemeData(
        color: themeConfig.isDark ? themeConfig.colors['--be-primary-text'] : themeConfig.colors['--be-accent-contrast'],
      ),
    ),
    iconTheme: IconThemeData(
      color: themeConfig.colors['--be-secondary-text'],
    ),
    textTheme: Theme.of(context).textTheme.apply(
      bodyColor: themeConfig.colors['--be-text'],
      displayColor: themeConfig.colors['--be-secondary-text'],
    ),
    primaryTextTheme: Theme.of(context).textTheme.apply(
      bodyColor: themeConfig.colors['--be-accent-contrast'],
      displayColor: themeConfig.colors['--be-accent-contrast'],
    ),
    toggleableActiveColor: themeConfig.colors['--be-accent-default'],
  ).copyWith(
    pageTransitionsTheme: PageTransitionsTheme(
      builders: <TargetPlatform, PageTransitionsBuilder> {
        TargetPlatform.android: ZoomPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        TargetPlatform.linux: ZoomPageTransitionsBuilder(),
        TargetPlatform.macOS: ZoomPageTransitionsBuilder(),
      }
    )
  );
}