import 'package:flutter/material.dart';

ThemeData makeAppTheme() {
  final primaryColor = Color.fromRGBO(229, 33, 37, 1);
  final primaryColorLight = Colors.white;
  final primaryColorDark = Colors.black;
  final scaffoldBackgroundColor = Colors.black;
  final backgroundColor = Color.fromRGBO(134, 134, 134, 1);
  final disabledColor = primaryColor.withAlpha(150);

  return ThemeData(
      primaryColor: primaryColor,
      primaryColorDark: primaryColorDark,
      primaryColorLight: primaryColorLight,
      scaffoldBackgroundColor: scaffoldBackgroundColor,
      backgroundColor: backgroundColor,
      disabledColor: disabledColor,
      accentColor: primaryColor,
      inputDecorationTheme: InputDecorationTheme(
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: backgroundColor),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: primaryColor),
        ),
        alignLabelWithHint: true,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          textStyle: MaterialStateProperty.all<TextStyle>(
            TextStyle(color: Colors.white),
          ),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.pressed))
                return disabledColor;
              else if (states.contains(MaterialState.disabled))
                return disabledColor;
              return primaryColor; // Use the component's default.
            },
          ),
          overlayColor: MaterialStateProperty.all<Color>(primaryColor),
          padding: MaterialStateProperty.all<EdgeInsets>(
            EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          ),
        ),
      ),
      buttonTheme: ButtonThemeData(
        colorScheme: ColorScheme.light(primary: primaryColor),
      ),
      appBarTheme: AppBarTheme(backgroundColor: primaryColorDark));
}
