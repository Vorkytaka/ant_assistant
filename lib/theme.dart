import 'package:flutter/material.dart';

ThemeData createLightTheme() {
  const MaterialColor _lightThemeColor = Colors.red;
  const Brightness _lightPrimaryColorBrightness = Brightness.dark;
  const Brightness _lightAccentColorBrightness = Brightness.dark;
  const Color _lightCardColor = Color(0xffeceff1);

  return ThemeData(
    brightness: Brightness.light,
    primarySwatch: _lightThemeColor,
    primaryColor: _lightThemeColor.shade600,
    primaryColorLight: _lightThemeColor.shade400,
    primaryColorDark: _lightThemeColor.shade900,
    primaryColorBrightness: _lightPrimaryColorBrightness,
    accentColor: _lightThemeColor.shade500,
    accentColorBrightness: _lightAccentColorBrightness,
    canvasColor: _lightCardColor,
    cardColor: _lightCardColor,
    scaffoldBackgroundColor: _lightCardColor,
    focusColor: ThemeData.light().focusColor,
    hoverColor: ThemeData.light().hoverColor,
    highlightColor: ThemeData.light().highlightColor,
    splashColor: ThemeData.light().splashColor,
    splashFactory: InkRipple.splashFactory,
  );
}

ThemeData createDarkTheme() {
  return ThemeData.dark();
}
