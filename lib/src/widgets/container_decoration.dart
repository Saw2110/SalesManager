import 'package:flutter/material.dart';

import '../config/config.dart';

class ContainerDecoration {
  static decoration({
    Color? bColor,
    Color? color,
    BorderRadiusGeometry? borderRadius,
  }) {
    return BoxDecoration(
      color: color ?? Colors.white,
      border: Border.all(color: bColor ?? borderColor),
      borderRadius: borderRadius ?? BorderRadius.circular(5.0),
    );
  }
}
