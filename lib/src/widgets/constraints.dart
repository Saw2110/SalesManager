import 'package:flutter/material.dart';

BoxConstraints bottomSheetConstraints(context,
    {bool? expandeMinHeight = false}) {
  return BoxConstraints(
    maxHeight: MediaQuery.of(context).size.height / 1.5,
    minHeight: expandeMinHeight == true
        ? MediaQuery.of(context).size.height / 1.6
        : 0.0,
  );
}
