import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sales_transaction/src/utils/utils.dart';
import 'package:sales_transaction/src/widgets/container_decoration.dart';

import '../../config/config.dart';
import '../invoice/invoice.dart';
import '../salestransaction/salestransaction.dart';

class IndexScreen extends StatelessWidget {
  const IndexScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("INDEX"),
        automaticallyImplyLeading: false,
      ),
      body: CustomScrollView(
        slivers: [
          SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 20,
              crossAxisSpacing: 20,
            ),
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final item = indexList[index];
                return Container(
                  decoration: ContainerDecoration.decoration(
                      color: Colors.blueGrey.shade100,
                      borderRadius: BorderRadius.circular(10.0)),
                  child: InkWell(
                    onTap: () {
                      if (item[1] == "Sales Trasactions") {
                        Get.find<SalesTransactionController>().onInit();
                      } else if (item[1] == "Invoices") {
                        Get.find<InvoiceController>().onInit();
                      }
                      Navigator.pushNamed(context, item.last);
                    },
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                            child: Image.asset(item.first).pa(5.0),
                          ),
                          Text(
                            item[1],
                            textAlign: TextAlign.center,
                            style: kSubTitleText.copyWith(
                                fontWeight: FontWeight.bold),
                          ).pa(10.0),
                        ]),
                  ),
                );
              },
              childCount: indexList.length,
            ),
          ),
        ],
      ).pa(20.0),
    );
  }
}
