import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import 'error_route.dart';

class NavigationHelper {
  NavigationHelper(this.context);
  BuildContext context;

  errorRoute() {
    Navigator.push(
      context,
      PageTransition(
        type: PageTransitionType.rightToLeft,
        child: const ErrorRoute(),
      ),
    );
  }
}
