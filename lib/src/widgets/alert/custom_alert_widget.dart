import 'package:flutter/material.dart';
import 'package:sales_transaction/src/utils/utils.dart';

import '../../config/config.dart';
import '../widgets.dart';

class CustomAlertWidget extends StatelessWidget {
  final String title, description;
  final void Function()? confirm;
  const CustomAlertWidget({
    super.key,
    required this.title,
    required this.description,
    this.confirm,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          verticalSpace(space: 10.0),
          Text(title, style: kTitleText),
          verticalSpace(space: 15.0),
          Text(description, style: kSubTitleText),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "CANCLE",
                    style: TextStyle(color: errorColor),
                  ),
                ),
              ),
              Flexible(
                child: TextButton(
                  onPressed: confirm,
                  child: const Text("CONFRIM"),
                ),
              ),
            ],
          ),
        ],
      ).pa(10.0),
    );
  }
}
