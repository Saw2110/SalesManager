import 'package:flutter/material.dart';

import '../../config/config.dart';
import '../widgets.dart';

abstract class CustomAlert {
  Widget create(BuildContext context);
  Future<void> show(BuildContext context) {
    var child = create(context);
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: child,
      ),
    );
  }
}

class MyCustomAlert extends CustomAlert {
  final String title;
  final Widget child;
  final bool? showCancle;
  MyCustomAlert({
    required this.child,
    required this.title,
    this.showCancle = false,
  });

  @override
  Widget create(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: ContainerDecoration.decoration(
              color: primaryColor,
              bColor: primaryColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10.0),
                topRight: Radius.circular(10.0),
              ),
            ),
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: Align(
                    alignment:
                        showCancle! ? Alignment.centerLeft : Alignment.center,
                    child: Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                      ).copyWith(fontSize: 16.0),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                if (showCancle!)
                  Flexible(
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.close,
                        color: Colors.white,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10.0),
                bottomRight: Radius.circular(10.0),
              ),
              color: Colors.white,
            ),
            child: child,
          ),
        ],
      ),
    );
  }
}
