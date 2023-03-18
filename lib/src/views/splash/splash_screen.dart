import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sales_transaction/src/utils/utils.dart';

import '../../config/config.dart';
import 'splash_controller.dart';

class SplashScreen extends GetView<SplashController> {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SplashController(context: context));

    return Scaffold(
      body: Center(
        child: ListView(
          shrinkWrap: true,
          children: [
            ///
            AnimatedTextKit(
              repeatForever: true,
              pause: const Duration(microseconds: 100),
              animatedTexts: [
                TypewriterAnimatedText(
                  'Welcome To SALES MANAGEMENT ',
                  // textStyle: kLoginTitleTextStyle.copyWith(fontSize: 20),
                  textAlign: TextAlign.center,
                  speed: const Duration(milliseconds: 100),
                ),
              ],
              onTap: () {},
            ).ph(5),

            ///
            Lottie.asset(AssetsList.loading, height: 80.0),
          ],
        ),
      ),
    );
  }
}
