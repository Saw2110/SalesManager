import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'config/config.dart';
import 'services/services.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Sales Manager',
      theme: ThemeData(
        primarySwatch: primarySwatch,
        primaryColor: primaryColor,
      ),

      // home: const IndexScreen(),
      initialRoute: splashPath,
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
