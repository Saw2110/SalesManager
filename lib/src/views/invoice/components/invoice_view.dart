import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nepali_utils/nepali_utils.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

import '../../../utils/utils.dart';
import '../../../widgets/widgets.dart';
import '../../salestransaction/salestransaction.dart';

class InvoiceView extends StatefulWidget {
  final List<SalesTransactionModel> dataList;
  // final List<Map<String, dynamic>> products;
  // final double totalAmount;

  const InvoiceView({
    super.key,
    // required this.products,
    // required this.totalAmount,
    required this.dataList,
  });

  @override
  State<InvoiceView> createState() => _InvoiceViewState();
}

class _InvoiceViewState extends State<InvoiceView> {
  ScreenshotController screenshotController = ScreenshotController();
  shareInvoice() async {
    String fileName =
        "Date ${myDateFormat(NepaliDateTime.now())}".replaceAll("/", "_");
//
    final directory = (await getApplicationDocumentsDirectory()).path;
//
    screenshotController.capture().then((image) async {
      ///
      if (image != null) {
        try {
          File imagePath = await File('$directory/$fileName.png').create();
          if (imagePath.isAbsolute) {
            await imagePath.writeAsBytes(image);
            // ignore: deprecated_member_use
            Share.shareFiles([imagePath.path]);
          }
        } catch (error) {
          debugPrint('Error --->> $error');
        }
      }

      ///
    }).catchError((onError) {
      debugPrint('On Error --->> $onError');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Invoice'), actions: [
        TextButton(
          onPressed: () async {
            await shareInvoice();
          },
          child: const Text(
            "Share Invoice",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ]),
      body: Container(
        decoration: ContainerDecoration.decoration(
          color: Colors.white,
        ),
        child: Screenshot(
          controller: screenshotController,
          child: Container(
            decoration: ContainerDecoration.decoration(
              color: Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                verticalSpace(space: 15.0),
                CustomRichText(
                  title: "Name : ",
                  value: '${getCustomerName()}',
                ),
                CustomRichText(
                  title: "Contact No. : ",
                  applyStyle: false,
                  value: '${getCustomerContact()}',
                ),
                verticalSpace(space: 15.0),
                Text(
                  'Date: ${myDateFormat(NepaliDateTime.now())}',
                  textAlign: TextAlign.end,
                  style: const TextStyle(fontSize: 16),
                ),
                verticalSpace(space: 16.0),
                const Text(
                  'Invoice',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                verticalSpace(space: 20.0),
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: DataTable(
                        columnSpacing: 40.0,
                        dataRowHeight: 40.0,
                        columns: const [
                          DataColumn(
                            label: Text('Product'),
                            tooltip: 'Product name',
                            numeric: false,
                          ),
                          DataColumn(
                            label: Text('Quantity'),
                            tooltip: 'Quantity',
                            numeric: true,
                          ),
                          DataColumn(
                            label: Text('Price'),
                            tooltip: 'Price per unit',
                            numeric: true,
                          ),
                          DataColumn(
                            label: Text('Total'),
                            tooltip: 'Total amount',
                            numeric: true,
                          ),
                        ],
                        rows: widget.dataList.map((product) {
                          final name = product.productName;
                          final quantity = product.productQuantity;
                          final price = product.productPrice;
                          final total = product.totalAmount;

                          return DataRow(cells: [
                            DataCell(Text(name)),
                            DataCell(Text(quantity.toString())),
                            DataCell(Text('Rs $price')),
                            DataCell(Text('Rs $total')),
                          ]);
                        }).toList(),
                      ),
                    ),
                  ),
                ),
                verticalSpace(space: 16.0),
                const Divider(thickness: 2),
                verticalSpace(space: 8.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Total',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Rs ${getTotalAmount()}',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ).paddingSymmetric(horizontal: 10.0, vertical: 10.0),
          ),
        ),
      ),
    );
  }

  getTotalAmount() {
    int totalAmount = 0;
    for (var element in widget.dataList) {
      debugPrint("\n\nTotal Amount => ${element.totalAmount}");
      totalAmount += int.parse(element.totalAmount);
    }
    return totalAmount.toStringAsFixed(2);
  }

  getCustomerName() {
    String value = "";
    for (var element in widget.dataList) {
      value = element.customerName;
    }
    return value;
  }

  getCustomerContact() {
    String value = "";
    for (var element in widget.dataList) {
      value = element.customerId;
    }
    return value;
  }
}
