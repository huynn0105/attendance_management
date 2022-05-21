import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextStyleUtils {
  static TextStyle medium(double size) => TextStyle(
        fontSize: size,
        fontWeight: FontWeight.w500,
      );
  static TextStyle light(double size) => TextStyle(
        fontSize: size,
        fontWeight: FontWeight.w300,
      );
  static TextStyle regular(double size) => TextStyle(
        fontSize: size,
        fontWeight: FontWeight.w400,
      );
  static TextStyle bold(double size) => TextStyle(
        fontSize: size,
        fontWeight: FontWeight.w700,
      );
}
