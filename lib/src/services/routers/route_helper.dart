import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../../views/customer/customer.dart';
import '../../views/index/index.dart';
import '../../views/invoice/invoice.dart';
import '../../views/product/product.dart';
import '../../views/salestransaction/salestransaction.dart';
import '../../views/splash/splash.dart';
import 'error_route.dart';
import 'route_name.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splashPath:
        return PageTransition(
          type: PageTransitionType.rightToLeft,
          child: const SplashScreen(),
        );

      ///
      case indexPath:
        return PageTransition(
          type: PageTransitionType.rightToLeft,
          child: const IndexScreen(),
        );

      ///
      case customerPath:
        return PageTransition(
          type: PageTransitionType.rightToLeft,
          child: const CustomerScreen(),
        );

      ///
      case productPath:
        return PageTransition(
          type: PageTransitionType.rightToLeft,
          child: const ProductScreen(),
        );

      ///
      case salesTransactionPath:
        return PageTransition(
          type: PageTransitionType.rightToLeft,
          child: const SalesTransactionScreen(),
        );
      case salesTransactionAddPath:
        return PageTransition(
          type: PageTransitionType.rightToLeft,
          child: const SalesTransactionForm(),
        );

      ///
      case invoicePath:
        return PageTransition(
          type: PageTransitionType.rightToLeft,
          child: const InvoiceScreen(),
        );

      /// ==============End=================
      ///
      default:
        return PageTransition(
          type: PageTransitionType.rightToLeft,
          child: const ErrorRoute(),
        );
    }
  }
}
