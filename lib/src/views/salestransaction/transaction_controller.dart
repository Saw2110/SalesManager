import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nepali_utils/nepali_utils.dart';

import '../../enum/enum.dart';
import '../../utils/utils.dart';
import '../customer/db/customer_db.dart';
import '../customer/model/customer_model.dart';
import '../invoice/components/invoice_view.dart';
import '../invoice/db/invoice_db.dart';
import '../invoice/model/invoice_model.dart';
import '../product/product.dart';
import 'db/sales_transaction_db.dart';
import 'model/orderlist_model.dart';
import 'model/salestransaction_model.dart';

class SalesTransactionController extends GetxController {
  SalesTransactionController();

  final alertFormKey = GlobalKey<FormState>();
  final customerFormKey = GlobalKey<FormState>();
  final productFormKey = GlobalKey<FormState>();

  ///
  final _searchCustomerController = TextEditingController();

  TextEditingController get searchCustomerController =>
      _searchCustomerController;

  //
  final _selectedProductController = TextEditingController();

  TextEditingController get selectedProductController =>
      _selectedProductController;

  //
  final _quantityController = TextEditingController();

  TextEditingController get quantityController => _quantityController;

  @override
  void onInit() async {
    super.onInit();
    debugPrint("onInit");
    await clear();
    await getCustomerListFromTransactionDatabase();
  }

  clear() async {
    isCustomerDetailShown = false;
    _checkStockAvailable = false;
    _orderList.clear();
    _productList.clear();

    ///
    _quantityController.text = "";
    _transactionList.clear();

    await getCustomerList();
  }

  @override
  void onReady() {
    super.onReady();
    debugPrint("onInit");
  }

  late bool isCustomerDetailShown = false;

  set showCustomerDetail(bool value) {
    isCustomerDetailShown = value;

    debugPrint("is Show => $isCustomerDetailShown");

    update();
  }

  @override
  void onClose() {
    _searchCustomerController.dispose();
    _selectedProductController.dispose();
    _quantityController.dispose();
  }

  late final RxList<CustomerModel> _customerList = <CustomerModel>[].obs;

  RxList<CustomerModel> get customerList => _customerList;

  getCustomerList() async {
    await CustomerDatabase.instance.getCustomerList().then((value) {
      _customerList.value = value;
    });
    update();
    notifyChildrens();
  }

  late ProductModel _productDetail = ProductModel.fromJson({});

  ProductModel get productDetail => _productDetail;

  getProductDetailById(ProductModel value) async {
    await ProductDatabase.instance
        .getProductFromId(productId: value.productId)
        .then((value) {
      for (var element in value) {
        _productDetail = element;
      }
    });

    getCheckStockAvailable = (_productDetail.productQuantity != "0");

    update();
  }

  late bool _checkStockAvailable = false;

  bool get checkStockAvailable => _checkStockAvailable;

  set getCheckStockAvailable(bool value) {
    _checkStockAvailable = value;
    update();
  }

  late CustomerModel _customerDetail = CustomerModel.fromJson({});

  CustomerModel get customerDetail => _customerDetail;

  set getCustomerDetail(CustomerModel value) {
    _customerDetail = value;
    update();
  }

  getCustomerById(String value) async {
    showCustomerDetail = true;

    await CustomerDatabase.instance
        .getCustomerFromId(customerId: value)
        .then((value) {
      for (var element in value) {
        getCustomerDetail = element;
      }
    });
    update();
    notifyChildrens();
  }

  late final RxList<ProductModel> _productList = <ProductModel>[].obs;

  RxList<ProductModel> get productList => _productList;

  getProductList() async {
    _orderList.clear();
    await ProductDatabase.instance.getProductList().then((value) {
      _productList.value = value;
    });

    update();
    notifyChildrens();
  }

  late final List<OrderProductData> _orderList = [];

  List<OrderProductData> get orderList => _orderList;

  addOrderList() async {
    _orderList.add(
      OrderProductData(
        customerId: _customerDetail.customerId,
        customerName: _customerDetail.customerName,
        productId: _productDetail.productId,
        productName: _productDetail.productName,
        quantity: _quantityController.text.trim(),
        productPrice: _productDetail.productPrice,
      ),
    );

    final updatedQuantity = int.parse(_productDetail.productQuantity) -
        int.parse(_quantityController.text);
    ProductDatabase.instance.updateStockByProductId(
      productId: _productDetail.productId,
      updateQuantity: "$updatedQuantity",
    );

    ///

    update();
  }

  late final List<SalesTransactionModel> _finalOrderList = [];

  List<SalesTransactionModel> get finalOrderList => _finalOrderList;

  onConfirm() async {
    _finalOrderList.clear();

    debugPrint("Order List => $_orderList");

    for (var element in _orderList) {
      _finalOrderList.add(SalesTransactionModel(
        transactionId: getRandomString(8),
        customerId: _customerDetail.customerId,
        transactionDate: "${myDateFormat(NepaliDateTime.now())}",
        paymentMethod: PaymentEnum.cashInHand.name,
        remarks: "",
        invoiceId: "0",
        productId: element.productId,
        productQuantity: element.quantity,
        totalAmount:
            "${int.parse(element.quantity) * int.parse(_productDetail.productPrice)}",
        customerName: element.customerName,
        productName: element.productName,
        productPrice: element.productPrice,
      ));
    }
    debugPrint("Final List => ${jsonEncode(_finalOrderList)}");

    for (var value in _finalOrderList) {
      await SalesTransactionDatabase.instance.insertData(value);
    }

    ///
    Get.snackbar('Success', 'Successfully Added.',
        snackPosition: SnackPosition.TOP);
    await updateClear();
  }

  updateClear() async {
    customerList.clear();
    customerFormKey.currentState!.reset();
    await getCustomerList();
    productList.clear();
    productFormKey.currentState!.reset();
    isCustomerDetailShown = false;
    _orderList.clear();
    _finalOrderList.clear();

    update();
  }

  late RxList<SalesTransactionModel> _customerInfoList =
      <SalesTransactionModel>[].obs;

  RxList<SalesTransactionModel> get customerInfoList => _customerInfoList;

  set getCustomerInfoList(RxList<SalesTransactionModel> value) {
    _customerInfoList = value;
    update();
    notifyChildrens();
  }

  Future getCustomerListFromTransactionDatabase() async {
    _customerInfoList.clear();
    await SalesTransactionDatabase.instance
        .getCustomerList()
        .then((customerList) {
      getCustomerInfoList = customerList;
    });

    update();
    notifyChildrens();
  }

  ///
  late RxList _transactionList = [].obs;

  RxList get transactionList => _transactionList;

  set getTransactionList(RxList<SalesTransactionModel> value) {
    _transactionList = value;
    update();
    notifyChildrens();
  }

  late RxList<ProductModel> _productInfoList = <ProductModel>[].obs;

  RxList<ProductModel> get productInfoList => _productInfoList;

  set getProductInfoList(RxList<ProductModel> value) {
    _productInfoList = value;
    update();
    notifyChildrens();
  }

  getTransactionDetailOfCustomerFromDatabase(customerId) async {
    _transactionList.clear();
    await SalesTransactionDatabase.instance
        .getTransactionListBytransCustomerId(customerId)
        .then((value) {
      getTransactionList = value;
    });

    List<SalesTransactionModel> test = [];
    // List <SalesTransactionModel> _transactionList= [];
    for (var element in test) {
      await ProductDatabase.instance
          .getProductFromId(productId: element.productId)
          .then((value) {
        for (var element in value) {
          _productInfoList.add(element);
        }
        update();
      });
    }

    update();
    notifyChildrens();
  }

  bool isListSelectedForInvoice = false;

  set getIsSelectedForInvoice(bool value) {
    isListSelectedForInvoice = value;
    debugPrint("Select Check => $isListSelectedForInvoice");
    update();
    notifyChildrens();
  }

  late List<SalesTransactionModel> _invoiceList = [];

  List<SalesTransactionModel> get invoiceList => _invoiceList;

  set getInvoiceList(List<SalesTransactionModel> value) {
    _invoiceList = value;
    update();
  }

  onInvoiceGenerateFromSaveList(context) async {
    String randomId = getRandomString(10);
    List<InvoiceModel> insertInvoiceList = [];
    double grandTotalAmount = 0.00;
    for (var element in _invoiceList) {
      grandTotalAmount += double.parse(element.totalAmount);
      await SalesTransactionDatabase.instance.updateForInvoiceGeneration(
        invoiceId: randomId,
        transId: element.transactionId,
        customerId: element.customerId,
      );

      ///
      insertInvoiceList.add(InvoiceModel(
        invoiceId: randomId,
        transactionId: element.transactionId,
        invoiceDate: element.transactionDate,
        invoiceDueDate: myDateFormat(NepaliDateTime.now()),
        totalAmount: grandTotalAmount.toStringAsFixed(2),
        remarks: "",
        customerId: element.customerId,
        customerName: element.customerName,
      ));

      ///
    }

    for (var element in insertInvoiceList) {
      await InvoiceDatabase.instance.insertData(element);
    }
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => InvoiceView(dataList: _invoiceList),
      ),
    );
  }

  // onInvoiceGenerateFromFrom(context) async {
  //   String invoiceId = getRandomString(10);
  //   String randomId = getRandomString(10);
  //   List<InvoiceModel> insertInvoiceList = [];
  //   List<SalesTransactionModel> dataList = [];

  //   double grandTotalAmount = 0.00;
  //   for (var element in _orderList) {
  //     grandTotalAmount +=
  //         double.parse(element.quantity) * double.parse(element.productPrice);

  //     await SalesTransactionDatabase.instance.updateForInvoiceGeneration(
  //       invoiceId: invoiceId,
  //       transId: randomId,
  //       customerId: element.customerId,
  //     );

  //     ///
  //     insertInvoiceList.add(InvoiceModel(
  //       invoiceId: invoiceId,
  //       transactionId: randomId,
  //       invoiceDate: myDateFormat(NepaliDateTime.now()),
  //       invoiceDueDate: myDateFormat(NepaliDateTime.now()),
  //       totalAmount: grandTotalAmount.toStringAsFixed(2),
  //       remarks: "",
  //       customerId: element.customerId,
  //       customerName: element.customerName,
  //     ));

  //     dataList.add(SalesTransactionModel(
  //       transactionId: randomId,
  //       customerId: element.customerId,
  //       customerName: element.customerName,
  //       transactionDate: myDateFormat(NepaliDateTime.now()),
  //       totalAmount:
  //           "${int.parse(element.quantity) * int.parse(element.productPrice)}",
  //       paymentMethod: PaymentEnum.cashInHand.name,
  //       remarks: "",
  //       invoiceId: invoiceId,
  //       productId: element.productId,
  //       productQuantity: element.quantity,
  //       productName: element.productName,
  //       productPrice: element.productPrice,
  //     ));
  //   }

  //   for (var element in insertInvoiceList) {
  //     await InvoiceDatabase.instance.insertData(element);
  //   }

  //   Navigator.pop(context);
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) => InvoiceView(dataList: dataList),
  //     ),
  //   );
  // }


}
