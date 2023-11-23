import 'package:flutter/material.dart';

import 'default_underline_border.dart';

Map<int, Color> colors = {
  50: const Color.fromRGBO(199, 75, 80, .1),
  100: const Color.fromRGBO(199, 75, 80, .2),
  200: const Color.fromRGBO(199, 75, 80, .3),
  300: const Color.fromRGBO(199, 75, 80, .4),
  400: const Color.fromRGBO(199, 75, 80, .5),
  500: const Color.fromRGBO(199, 75, 80, .6),
  600: const Color.fromRGBO(199, 75, 80, .7),
  700: const Color.fromRGBO(199, 75, 80, .8),
  800: const Color.fromRGBO(199, 75, 80, .9),
  900: const Color.fromRGBO(199, 75, 80, 1),
};

class AppTheme {
  static ThemeData dark() {
    return ThemeData(
      primaryColor: MaterialColor(0xFFC74B50, colors),
      colorScheme: ColorScheme.dark(primary: MaterialColor(0xFFC74B50, colors)),
      primarySwatch: MaterialColor(0xFFC74B50, colors),
      scaffoldBackgroundColor: Colors.black,
      primaryColorDark: MaterialColor(0xFFC74B50, colors),
      useMaterial3: true,
      buttonTheme: ButtonThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      scrollbarTheme: ScrollbarThemeData(
        thumbColor: MaterialStateProperty.all(MaterialColor(0xFFC74B50, colors))
      ),
      inputDecorationTheme:
          const InputDecorationTheme(border: DefaulUnderlineBorder()),
    );
  }
}
