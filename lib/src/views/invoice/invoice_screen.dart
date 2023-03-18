import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:sales_transaction/src/utils/utils.dart';
import 'package:sales_transaction/src/widgets/empty_widget.dart';

import '../salestransaction/salestransaction.dart';
import 'invoice_controller.dart';

class InvoiceScreen extends GetView<InvoiceController> {
  const InvoiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    controller.getContext = context;

    return Scaffold(
      appBar: AppBar(title: const Text("Invoice")),
      // floatingActionButton: FloatingActionButton.extended(
      //   label: const Text("Add Invoice"),
      //   onPressed: () {
      //     MyButtomSheet(
      //       title: "Add Invoice",
      //       body: const InvoiceForm(),
      //     ).show(context);
      //   },
      // ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: controller.invoiceDateList.isNotEmpty
                ? GroupedListView<dynamic, String>(
                    elements: controller.invoiceDateList,
                    groupBy: (element) => element.invoiceDueDate,
                    groupSeparatorBuilder: (String groupByValue) => Align(
                      alignment: Alignment.topLeft,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const CustomRichText(
                                title: "Issue Date : ",
                                value: "",
                                applyStyle: false),
                            CustomRichText(title: "", value: groupByValue),
                          ]).paddingOnly(
                          left: 0.0, right: 0.0, top: 20.0, bottom: 5.0),
                    ),
                    itemBuilder: (context, dynamic element) => Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          InkWell(
                            onTap: () {
                              controller.onInvoiceGenerate(
                                  context, element.invoiceId);
                            },
                            child: Card(
                                elevation: 3,
                                child: ListTile(
                                  title: Text(element.customerName),
                                  subtitle: Text(element.invoiceId),
                                  trailing: const Icon(
                                    Icons.arrow_forward_ios,
                                    size: 15.0,
                                  ),
                                )),
                          ),
                        ]),
                    itemComparator: (item1, item2) =>
                        item1.invoiceDueDate.compareTo(item2.invoiceDueDate),
                    useStickyGroupSeparators: true,
                    floatingHeader: true,
                    order: GroupedListOrder.DESC,
                  ).ph(10.0)
                : const NoDataWidget(),
          ),
        ],
      ),
    );
  }
}
