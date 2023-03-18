import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../config/config.dart';
import '../widgets.dart';

abstract class CustomBottomSheet {
  Widget create(BuildContext context);
  Future<void> show(BuildContext context) {
    var child = create(context);
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: false,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      builder: (BuildContext _) {
        return child;
      },
    );
  }
}

class MyButtomSheet extends CustomBottomSheet {
  late final String? title;
  late final Widget? body;
  MyButtomSheet({required this.title, this.body});

  @override
  Widget create(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25.0),
          topRight: Radius.circular(25.0),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            decoration: ContainerDecoration.decoration(
              color: primaryColor,
              bColor: primaryColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      title ?? "",
                      style: const TextStyle(
                        color: Colors.white,
                      ).copyWith(fontSize: 16.0),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ).paddingSymmetric(horizontal: 10.0, vertical: 10.0),
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: body ?? verticalSpace(),
            ),
          ),
          verticalSpace(space: 10.0),
        ],
      ),
    );
  }
}

// class ShowBottomSheet {
//   BuildContext context;
//   ShowBottomSheet(this.context);

//   sheet({required String title, required Widget child}) {
//     return showModalBottomSheet(
//       context: context,
//       isDismissible: false,
//       shape: const RoundedRectangleBorder(
//           borderRadius: BorderRadius.only(
//         topLeft: Radius.circular(20.0),
//         topRight: Radius.circular(20.0),
//       )),
//       builder: (context) {
//         return StatefulBuilder(
//           builder: (BuildContext context, StateSetter setState) {
//             return Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Container(
//                   decoration: ContainerDecoration.decoration(
//                     color: primaryColor,
//                     bColor: primaryColor,
//                     borderRadius: const BorderRadius.only(
//                       topLeft: Radius.circular(20.0),
//                       topRight: Radius.circular(20.0),
//                     ),
//                   ),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Flexible(
//                         child: Align(
//                           alignment: Alignment.center,
//                           child: Text(
//                             title,
//                             style: const TextStyle(
//                               color: Colors.white,
//                             ).copyWith(fontSize: 16.0),
//                             textAlign: TextAlign.center,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ).paddingSymmetric(horizontal: 10.0, vertical: 10.0),
//                 ),
//                 Expanded(child: child),
//               ],
//             );
//           },
//         );
//       },
//     );
//   }
// }
