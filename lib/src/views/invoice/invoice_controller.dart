import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../salestransaction/db/sales_transaction_db.dart';
import '../salestransaction/salestransaction.dart';
import 'components/invoice_view.dart';
import 'db/invoice_db.dart';

class InvoiceController extends GetxController {
  InvoiceController();

  // final formKey = GlobalKey<FormState>();
  // final _firstNameController = TextEditingController();
  // final _lastNameController = TextEditingController();
  // final _emailController = TextEditingController();
  // final _phoneController = TextEditingController();
  // final _addressController = TextEditingController();
  //
  // TextEditingController get firstNameController => _firstNameController;
  // TextEditingController get lastNameController => _lastNameController;
  // TextEditingController get emailController => _emailController;
  // TextEditingController get phoneController => _phoneController;
  // TextEditingController get addressController => _addressController;

  late BuildContext _context;
  BuildContext get context => _context;
  late final NavigatorState navigator = Navigator.of(_context);
  set getContext(BuildContext value) {
    _context = value;
  }

  @override
  void onInit() {
    super.onInit();
    debugPrint("onInit");
    clear();
    getInvoiceDateFromDatabase();
  }

  @override
  void onReady() {
    super.onReady();
    debugPrint("onReady");
    getInvoiceDateFromDatabase();
  }

  @override
  void onClose() {}

  clear() async {
    _invoiceDateList.clear();
  }

  late RxList _invoiceDateList = [].obs;

  RxList get invoiceDateList => _invoiceDateList;

  set getInvoiceDateList(RxList value) {
    _invoiceDateList = value;
    update();
  }

  getInvoiceDateFromDatabase() async {
    await InvoiceDatabase.instance.getInvoiceDateList().then((value) {
      getInvoiceDateList = value;
    });
    update();
    notifyChildrens();
  }

  late RxList _transactionList = [].obs;

  RxList get transactionList => _transactionList;

  set getTransactionList(RxList value) {
    _transactionList = value;
    update();
  }

  // getTransactionDetailsFromDatabase(invoiceId) async {
  //   _transactionList.clear();
  //   await SalesTransactionDatabase.instance
  //       .getSalesListFromInvoiceId(invoiceId)
  //       .then((value) {
  //     getTransactionList = value;
  //   });
  //   return _transactionList;
  //
  //   // update();
  // }

  onInvoiceGenerate(context, invoiceId) async {
    late List<SalesTransactionModel> invoiceList = [];
    await SalesTransactionDatabase.instance
        .getInvoiceFromInvoiceId(invoiceId)
        .then((value) {
      invoiceList = value;
    });

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => InvoiceView(dataList: invoiceList),
      ),
    );
  }
}
