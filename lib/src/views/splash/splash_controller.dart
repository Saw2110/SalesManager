import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../services/services.dart';

class SplashController extends GetxController {
  SplashController({required this.context});
  late BuildContext context;

  @override
  void onReady() {
    super.onReady();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, indexPath);
    });
  }
}
