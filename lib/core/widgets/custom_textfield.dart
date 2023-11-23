import 'package:flutter/material.dart';

import '../themes/default_underline_border.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({super.key, this.hintText});

  final String? hintText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        decoration: InputDecoration(
          hintText: hintText,
          border: const DefaulUnderlineBorder(),
          disabledBorder: const DefaulUnderlineBorder(),
          enabledBorder: const DefaulUnderlineBorder(),
        ),
      ),
    );
  }
}
