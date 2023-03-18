import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../config/config.dart';
import 'widgets.dart';

class TextFieldFormat extends StatelessWidget {
  final String textFieldName;
  final Widget textFormField;

  const TextFieldFormat(
      {Key? key, required this.textFieldName, required this.textFormField})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(textFieldName,
            style: kTitleText.copyWith(
              fontSize: 16.0,
              fontWeight: FontWeight.normal,
              color: Colors.grey.shade600,
            )).paddingSymmetric(horizontal: 8.0),
        verticalSpace(space: 5.0),
        textFormField.paddingSymmetric(horizontal: 4.0),
      ],
    );
  }
}
