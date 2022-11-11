import 'package:flutter/material.dart';

class CustomTextStyle {
  static const Color color = Colors.black;

  static TextStyle _baseTextStyle(TextStyle style) {
    return style.copyWith(fontFamily: 'Graphik');
  }

  static TextStyle titleSmall(BuildContext context) {
    const style = TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w500,
      color: color,
    );

    return _baseTextStyle(style);
  }

  static TextStyle titleMedium(BuildContext context) {
    const style = TextStyle(
      fontSize: 19,
      fontWeight: FontWeight.w500,
      color: color,
    );

    return _baseTextStyle(style);
  }

  static TextStyle titleLarge(BuildContext context) {
    const style = TextStyle(
      fontSize: 23,
      fontWeight: FontWeight.w600,
      color: color,
    );

    return _baseTextStyle(style);
  }

  static TextStyle headlineSmall(BuildContext context) {
    const style = TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.w600,
      color: color,
    );

    return _baseTextStyle(style);
  }

  static TextStyle bodySmall(BuildContext context) {
    const style = TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: Colors.grey,
    );

    return _baseTextStyle(style);
  }

  static TextStyle bodyMedium(BuildContext context) {
    const style = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: color,
    );

    return _baseTextStyle(style);
  }

  static TextStyle bodyLarge(BuildContext context) {
    const style = TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w400,
      color: color,
    );

    return _baseTextStyle(style);
  }

  static TextStyle labelSmall(BuildContext context) {
    const style = TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w300,
      color: color,
    );

    return _baseTextStyle(style);
  }

  static TextStyle labelMedium(BuildContext context) {
    const style = TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: color,
    );

    return _baseTextStyle(style);
  }

  static TextStyle labelLarge(BuildContext context) {
    const style = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: color,
    );

    return _baseTextStyle(style);
  }

  static TextStyle caption(BuildContext context) {
    const style = TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w300,
      color: color,
    );

    return _baseTextStyle(style);
  }

  static TextStyle button(BuildContext context) {
    const style = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: color,
    );

    return _baseTextStyle(style);
  }
}
