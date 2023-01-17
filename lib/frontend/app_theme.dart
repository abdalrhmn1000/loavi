import 'package:flutter/material.dart';

class AppTheme {
  static const Color accent7 = Color(0xFFFF5959);
  static const Color lightGrey = Color(0xFFF5F5F5);

  static const TextStyle interRegular = TextStyle(fontFamily: 'Inter Regular');
  static const TextStyle interMedium = TextStyle(fontFamily: 'Inter Medium');
  static const TextStyle interSemiBold =
      TextStyle(fontFamily: 'Inter Semi Bold');
  static const TextStyle interBold = TextStyle(fontFamily: 'Inter Bold');
  static showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: const Duration(milliseconds: 1500), content: Text(message),backgroundColor: accent7,));
  }
}
