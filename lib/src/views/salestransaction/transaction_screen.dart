import 'package:flutter/material.dart';
import 'package:flutter_multi_select_items/flutter_multi_select_items.dart';
import 'package:get/get.dart';
import 'package:sales_transaction/src/utils/utils.dart';

import '../../config/config.dart';
import '../../widgets/widgets.dart';
import 'db/sales_transaction_db.dart';
import 'salestransaction.dart';

class SalesTransactionScreen extends GetView<SalesTransactionController> {
  const SalesTransactionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar:
            AppBar(title: const Text("Sales Transaction History"), actions: [
          IconButton(
            onPressed: () async {
              await SalesTransactionDatabase.instance.deleteData();
            },
            icon: const Icon(Icons.delete),
          ),
        ]),
        body: Column(children: [
          verticalSpace(space: 10.0),
          Expanded(
            child: controller.customerInfoList.isNotEmpty
                ? ListView.builder(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemCount: controller.customerInfoList.length,
                    itemBuilder: (BuildContext context, int index) {
                      SalesTransactionModel indexData =
                          controller.customerInfoList[index];
                      return Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 5.0),
                        decoration: ContainerDecoration.decoration(),
                        child: InkWell(
                          onTap: () async {
                            await controller
                                .getTransactionDetailOfCustomerFromDatabase(
                              indexData.customerId,
                            );
                            controller.getIsSelectedForInvoice = false;
                            Future.delayed(const Duration(seconds: 0), () {
                              MyButtomSheet(
                                  title: indexData.customerName,
                                  body: _buildExpandableContent(
                                    controller: controller,
                                    index: index,
                                    value: controller.transactionList,
                                  )).show(context);
                            });
                          },
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                CustomRichText(
                                  title: "",
                                  value: indexData.customerName,
                                ),
                                CustomRichText(
                                  title: "Contact : ",
                                  applyStyle: false,
                                  value: indexData.customerId,
                                ),
                              ]).pa(10.0),
                        ),
                      );
                      // return StatefulBuilder(
                      //   builder: (BuildContext context,
                      //       void Function(void Function()) setState) {
                      //     return ExpansionTile(
                      //       onExpansionChanged: (value) async {
                      //
                      //         setState(() {});
                      //       },
                      //       title:
                      //       children: [
                      //         FutureBuilder(
                      //             future: controller
                      //                 .getTransactionDetailOfCustomerFromDatabase(
                      //               indexData.customerId,
                      //             ),
                      //
                      //             ///
                      //             builder: (BuildContext context,
                      //                 AsyncSnapshot<dynamic> snapshot) {
                      //               debugPrint("VALUE =>  $snapshot");
                      //               if (snapshot.data == ConnectionState.done) {
                      //                 return _buildExpandableContent(
                      //                   controller: controller,
                      //                   index: index,
                      //                   value: controller.transactionList,
                      //                 );
                      //               } else if (snapshot.hasError) {
                      //                 return Container(
                      //                     height: 100.0, color: successColor);
                      //               } else {
                      //                 return const LinearProgressIndicator()
                      //                     .paddingSymmetric(
                      //                   horizontal: 20.0,
                      //                   vertical: 5.0,
                      //                 );
                      //               }
                      //             }),
                      //       ],
                      //     );
                      //   },
                      // );
                    })
                : const NoDataWidget(),
          ),
        ]),
      ),
    );
  }

  _buildExpandableContent({
    required SalesTransactionController controller,
    required int index,
    required RxList value,
  }) {
    return StatefulBuilder(
      builder: (BuildContext context, void Function(void Function()) setState) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            controller.transactionList.isNotEmpty
                ? MultiSelectCheckList(
                    onChange: (allSelectedItems, selectedItem) {
                      controller.getIsSelectedForInvoice =
                          allSelectedItems.isNotEmpty ? true : false;
                      debugPrint("allSelectedItems => $allSelectedItems");
                      controller.getInvoiceList = allSelectedItems;
                      setState(() {});
                    },
                    items: List.generate(
                      value.length,
                      (index) {
                        SalesTransactionModel indexValue = value[index];
                        return CheckListCard(
                          value: indexValue,
                          title: CustomRichText(
                              title: "", value: indexValue.productName),
                          subtitle: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      CustomRichText(
                                        title: "Qty : ",
                                        applyStyle: false,
                                        value: indexValue.productQuantity,
                                      ),
                                      CustomRichText(
                                        title: "Price : ",
                                        applyStyle: false,
                                        value: indexValue.productPrice,
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: CustomRichText(
                                    title: "Total :",
                                    applyStyle: false,
                                    value: indexValue.totalAmount,
                                  ),
                                ),
                              ]).paddingSymmetric(
                              horizontal: 10.0, vertical: 5.0),
                        );
                      },
                    ),
                  )
                : const NoDataWidget(text: "Invoice Already Generated")
                    .pa(20.0),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("CANCEL", style: TextStyle(color: errorColor)),
                  ),
                ),
                if (controller.isListSelectedForInvoice) ...[
                  horizantalSpace(space: 10.0),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        await controller.onInvoiceGenerateFromSaveList(context);
                      },
                      child: const Text("Get Invoice"),
                    ),
                  ),
                ],
              ],
            ),
          ],
        );
      },
    );
  }
}
