import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'src/my_app.dart';
import 'src/views/customer/customer.dart';
import 'src/views/invoice/invoice.dart';
import 'src/views/product/product.dart';
import 'src/views/salestransaction/salestransaction.dart';

void main() {
  Get.put<CustomerController>(CustomerController());
  Get.put<ProductController>(ProductController());
  Get.put<SalesTransactionController>(SalesTransactionController());
  Get.put<InvoiceController>(InvoiceController());

  runApp(const MyApp());
}
