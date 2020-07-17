import 'package:flutter/material.dart';
import 'dart:math';

class ToDosColor {
  static const primaryColorInt = 0xffcc4e5c;
  static const secondaryColorInt = 0xff3c5a78;
  static const myBlack = Colors.black87;

  static ToDosColor sharedInstance = ToDosColor._();

  List<Color> storedColors;

  ToDosColor._() {
    storedColors = List.generate(100, (pos) {
      return Color.fromARGB(0xff - pos * 10, Random().nextInt(255),
          Random().nextInt(255), Random().nextInt(255));
    });
  }

  Color leadingTaskColor(int pos) {
    switch (pos) {
      case 0:
        return Colors.red[900];
      case 1:
        return Colors.green[900];
      case 2:
        return Colors.blue[900];
    }

    if (pos < storedColors.length) {
      return storedColors[pos];
    }

    // default case when need more than 100 colors
    return Color.fromARGB(0xff - pos * 10, Random().nextInt(255),
        Random().nextInt(255), Random().nextInt(255));
  }
}
