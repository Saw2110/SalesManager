import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sales_transaction/src/config/color.dart';

import '../../config/font.dart';
import '../../utils/utils.dart';
import '../../widgets/widgets.dart';
import '../salestransaction/salestransaction.dart';
import 'components/form_section.dart';
import 'customer_controller.dart';
import 'model/customer_model.dart';

class CustomerScreen extends GetView<CustomerController> {
  const CustomerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    controller.getContext = context;

    return Scaffold(
      appBar: AppBar(title: const Text("Customer")),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text("Add Customer"),
        onPressed: () {
          controller.clear();
          controller.getIsEdit = false;
          MyButtomSheet(
            title: "Add Customer",
            body: const CustomerForm(),
          ).show(context);
        },
      ),
      body: Obx(
        () => controller.customerList.isNotEmpty
            ? ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: controller.customerList.length,
                itemBuilder: (context, index) {
                  CustomerModel indexData = controller.customerList[index];
                  return Stack(
                    alignment: Alignment.topRight,
                    children: [
                      Container(
                        decoration: ContainerDecoration.decoration(),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(indexData.customerName,
                                style: kTitleText.copyWith(fontSize: 18.0)),
                            verticalSpace(),
                            Text(indexData.address),
                            verticalSpace(space: 8.0),
                            CustomRichText(
                              title: "Contact : ",
                              applyStyle: false,
                              value: indexData.phoneNumber,
                            ),
                            verticalSpace(),
                            CustomRichText(
                              title: "Email : ",
                              applyStyle: false,
                              value: indexData.emailAddress,
                            ),
                          ],
                        ).pa(10.0),
                      ).paddingSymmetric(horizontal: 10.0, vertical: 5.0),
                      IconButton(
                        onPressed: () {
                          MyCustomAlert(
                            title: "Edit Customer Details",
                            child: CustomAlertWidget(
                              title: "Are you sure?",
                              description: "You want to edit customer details.",
                              confirm: () {
                                Navigator.pop(context);
                                controller.getDataFromCustomerNumber(
                                  productID: indexData.phoneNumber,
                                );
                                MyButtomSheet(
                                  title: "Edit Customer",
                                  body: const CustomerForm(),
                                ).show(context);
                              },
                            ),
                            showCancle: true,
                          ).show(context);
                        },
                        icon: Icon(Icons.edit, color: successColor),
                      ),
                    ],
                  );
                },
              )
            : const NoDataWidget(text: "No Costumer Found"),
      ),
    );
  }
}
