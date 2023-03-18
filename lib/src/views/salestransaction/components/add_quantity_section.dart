import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sales_transaction/src/utils/utils.dart';

import '../../../config/config.dart';
import '../../../widgets/widgets.dart';
import '../transaction_controller.dart';

class AddQuantitySection extends GetView<SalesTransactionController> {
  const AddQuantitySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: TextFormField(
                  initialValue: controller.productDetail.productName,
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: 'Product Name',
                    hintText: controller.productDetail.productName,
                  )),
            ),
            horizantalSpace(space: 10.0),
            Expanded(
              child: TextFormField(
                initialValue: !controller.checkStockAvailable
                    ? "Out Of Stock"
                    : controller.productDetail.productQuantity,
                readOnly: true,
                decoration: InputDecoration(
                  labelText: 'Available Stock',
                  hintText: controller.productDetail.productQuantity,
                ),
              ),
            ),
          ],
        ),
        Form(
          key: controller.alertFormKey,
          child: TextFormField(
            controller: controller.quantityController,
            decoration: const InputDecoration(
              labelText: 'Quantity',
            ),
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            autofocus: true,
            onChanged: (value) {
              if (value.isNotEmpty) {
                controller.alertFormKey.currentState!.validate();
              }
            },
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter quantity';
              } else if (int.parse(controller.productDetail.productQuantity) <
                  int.parse(value)) {
                return "Out of Stock";
              }
              return null;
            },
          ),
        ),
        verticalSpace(space: 10.0),
        Align(
          alignment: Alignment.bottomRight,
          child: controller.checkStockAvailable
              ? TextButton(
                  child: const Text("CONFIRM"),
                  onPressed: () {
                    if (controller.alertFormKey.currentState!.validate()) {
                      Navigator.pop(context);
                      controller.addOrderList();
                    } else {}
                  },
                )
              : TextButton(
                  child: Text("CANCEL", style: TextStyle(color: errorColor)),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
        ).pr(10.0)
      ],
    ).paddingSymmetric(horizontal: 20.0, vertical: 10.0);
  }
}
