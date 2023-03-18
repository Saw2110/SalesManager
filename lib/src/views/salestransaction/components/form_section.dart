import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sales_transaction/src/utils/utils.dart';

import '../../../config/config.dart';
import '../../../services/services.dart';
import '../../../widgets/widgets.dart';
import '../../customer/model/customer_model.dart';
import '../../product/product.dart';
import '../model/orderlist_model.dart';
import '../transaction_controller.dart';
import 'add_quantity_section.dart';

class SalesTransactionForm extends GetView<SalesTransactionController> {
  const SalesTransactionForm({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Obx(
      () => Scaffold(
        appBar: AppBar(title: const Text("Add Sales Transaction"), actions: [
          IconButton(
            onPressed: () async {
              await controller
                  .getCustomerListFromTransactionDatabase()
                  .whenComplete(() {
                Navigator.pushNamed(context, salesTransactionPath);
              });
            },
            icon: const Icon(Icons.history),
          ),
        ]),
        bottomNavigationBar: (controller.orderList.isNotEmpty)
            ? Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // ElevatedButton(
                  //   onPressed: () async {
                  //     // await controller.onInvoiceGenerateFromFrom(context);
                  //   },
                  //   child: const Text("Generate Invoice"),
                  // ),
                  Row(children: [
                    Expanded(
                        child: OutlinedButton(
                      onPressed: () async {
                        await controller.updateClear();
                      },
                      child: Text("CLEAR", style: TextStyle(color: errorColor)),
                    )),
                    horizantalSpace(space: 20.0),
                    Expanded(
                        child: ElevatedButton(
                      onPressed: () async {
                        await controller.onConfirm();
                      },
                      child: const Text("CONFIRM"),
                    )),
                  ]),
                ],
              ).paddingSymmetric(horizontal: 20.0, vertical: 10.0)
            : null,
        body: Container(
          constraints: bottomSheetConstraints(context, expandeMinHeight: true),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ///
                ///
                verticalSpace(space: 10.0),
                TextFieldFormat(
                  textFieldName: "Select Customer",
                  textFormField: Form(
                    key: controller.customerFormKey,
                    child: CustomDropdownWidget<CustomerModel>(
                      controller: controller.searchCustomerController,
                      search: (item, searchValue) {
                        return item.value!.phoneNumber.startsWith(searchValue);
                      },
                      items: controller.customerList
                          .map((item) => DropdownMenuItem<CustomerModel>(
                                value: item,
                                child: Text(
                                  item.phoneNumber,
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ))
                          .toList(),
                      hintText: 'Select Customer',
                      validator: (value) {
                        if (value == null) {
                          return 'Please select customer.';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        controller.getCustomerById(value!.phoneNumber);
                        controller.productFormKey.currentState!.reset();
                        controller.getProductList();
                      },
                      onSaved: (value) {
                        debugPrint("SAVED VALUE => $value");
                      },
                    ),
                  ),
                ),

                if (controller.isCustomerDetailShown) ...[
                  verticalSpace(space: 5.0),
                  Container(
                    decoration: ContainerDecoration.decoration(),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          CustomRichText(
                            title: "",
                            value: controller.customerDetail.customerName,
                          ),
                          CustomRichText(
                            title: "",
                            applyStyle: false,
                            value: controller.customerDetail.emailAddress,
                          ),
                        ]).pa(10.0),
                  ).ph(15.0),
                ],

                ///
                Form(
                  key: controller.productFormKey,
                  child: TextFieldFormat(
                    textFieldName: "Select Product",
                    textFormField: CustomDropdownWidget<ProductModel>(
                      controller: controller.selectedProductController,
                      search: (item, searchValue) {
                        return item.value!.productName.startsWith(searchValue);
                      },
                      items: controller.productList
                          .map((item) => DropdownMenuItem<ProductModel>(
                                value: item,
                                child: Text(
                                  item.productName,
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ))
                          .toList(),
                      hintText: 'Select Product',
                      validator: (value) {
                        if (value == null) {
                          return 'Please select product.';
                        }
                        return null;
                      },
                      onChanged: (value) async {
                        await controller.getProductDetailById(value!);
                        controller.quantityController.text = "";
                        debugPrint("Change VALUE => $value");
                        Future.delayed(const Duration(seconds: 0), () {
                          MyCustomAlert(
                            title: "Enter Quantity",
                            showCancle: true,
                            child: const AddQuantitySection(),
                          ).show(context);
                        });
                      },
                      onSaved: (value) {
                        debugPrint("SAVED VALUE => $value");
                      },
                    ),
                  ).pv(20.0),
                ),

                ///

                if (controller.orderList.isNotEmpty) ...[
                  const CustomDottedDivider(color: primaryColor),
                  verticalSpace(space: 10.0),
                  Text(
                    "Order Product List",
                    style: kTitleText.copyWith(color: Colors.black54),
                  ),
                  verticalSpace(space: 5.0),
                  Wrap(
                    children:
                        List.generate(controller.orderList.length, (index) {
                      OrderProductData indexData = controller.orderList[index];

                      return Container(
                        width: screenWidth / 2.5,
                        margin: const EdgeInsets.all(5.0),
                        decoration: ContainerDecoration.decoration(),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CustomRichText(
                              title: "",
                              value: indexData.productName,
                            ),
                            CustomRichText(
                              title: "Qty : ",
                              applyStyle: false,
                              value: indexData.quantity,
                            ),
                            CustomRichText(
                              title: "Price",
                              applyStyle: false,
                              value: indexData.productPrice,
                            ),
                            // Text(indexData.customerId),
                          ],
                        ).pa(10.0),
                      );
                    }),
                  ),
                ],
              ],
            ).ph(10.0),
          ),
        ),
      ),
    );
  }
}

class CustomRichText extends StatelessWidget {
  const CustomRichText({
    super.key,
    required this.title,
    required this.value,
    this.applyStyle = true,
  });

  final String title, value;
  final bool? applyStyle;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
          style: applyStyle == true
              ? kTitleText
              : TextStyle(color: hintColor, fontSize: 13.0),
          children: <TextSpan>[
            TextSpan(
              text: title,
              style: TextStyle(color: hintColor),
            ),
            TextSpan(
              text: value,
            ),
          ]),
      textScaleFactor: 1.0,
    );
  }
}
