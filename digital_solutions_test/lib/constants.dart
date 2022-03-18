import 'package:flutter/material.dart';

class TextStyles {
  static const TextStyle header = TextStyle(
    fontSize: 56,
    fontFamily: "Inter",
    fontWeight: FontWeight.w800,
  );
  static const TextStyle task = TextStyle(
    fontSize: 18,
    fontFamily: "Inter",
    fontWeight: FontWeight.w500,
  );
}

class GlobalKeys{
  static GlobalKey tasksList = GlobalKey(debugLabel: "tasksList");
}