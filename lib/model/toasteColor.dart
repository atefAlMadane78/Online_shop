import 'package:flutter/material.dart';

enum ToasteColor { SUCCESS, ERROR, WARNING }

Color chooseToasteColor(ToasteColor state) {
  Color color;

  switch (state) {
    case ToasteColor.SUCCESS:
      color = Colors.green;
      break;
    case ToasteColor.ERROR:
      color = Colors.red;
      break;
    case ToasteColor.WARNING:
      color = Colors.amber;
      break;
  }

  return color;
  }
