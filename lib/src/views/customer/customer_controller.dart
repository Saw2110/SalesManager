import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'db/customer_db.dart';
import 'model/customer_model.dart';

class CustomerController extends GetxController {
  CustomerController();

  final formKey = GlobalKey<FormState>();
  late TextEditingController _customerIdController = TextEditingController();
  late TextEditingController _customerNameController = TextEditingController();
  late TextEditingController _emailController = TextEditingController();
  late TextEditingController _phoneController = TextEditingController();
  late TextEditingController _addressController = TextEditingController();

  TextEditingController get customerIdController => _customerIdController;
  TextEditingController get customerNameController => _customerNameController;
  TextEditingController get emailController => _emailController;
  TextEditingController get phoneController => _phoneController;
  TextEditingController get addressController => _addressController;

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
    getCustomerFromDatabase();
  }

  @override
  void onReady() {
    super.onReady();
    debugPrint("onInit");
  }

  @override
  void onClose() {
    _customerIdController.dispose();
    _customerNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
  }

  bool isEdit = false;
  set getIsEdit(bool value) {
    isEdit = value;

    update();
    notifyChildrens();
  }

  clear() async {
    _customerIdController = TextEditingController(text: "");
    _customerNameController = TextEditingController(text: "");
    _emailController = TextEditingController(text: "");
    _phoneController = TextEditingController(text: "");
    _addressController = TextEditingController(text: "");
  }

  deleteAllCustomer() async {
    await CustomerDatabase.instance.deleteData();
    await getCustomerFromDatabase();
    navigator.pop();
  }

  saveCustomer() async {
    CustomerModel customerData = CustomerModel(
      customerId: _phoneController.text.trim(),
      customerName: _customerNameController.text.trim(),
      address: _addressController.text.trim(),
      phoneNumber: _phoneController.text.trim(),
      emailAddress: _emailController.text.trim(),
    );
    return customerData;
  }

  getDataFromCustomerNumber({required String productID}) async {
    await CustomerDatabase.instance
        .getCustomerFromId(customerId: productID)
        .then((value) {
      getIsEdit = true;
      for (var element in value) {
        _customerNameController.text = element.customerName;
        _addressController.text = element.address;
        _phoneController.text = element.phoneNumber;
        _emailController.text = element.emailAddress;
      }
    });

    update();

    ///
    notifyChildrens();
  }

  checkProductExist() async {
    await CustomerDatabase.instance
        .isAlreadyExist(customerId: _phoneController.text.trim())
        .then((value) async {
      if (!value) {
        await insertIntoDatabase();
      } else {
        await updateIntoDatabase();
      }
    });

    if (context.mounted) navigator.pop(context);
    await getCustomerFromDatabase();
  }

  insertIntoDatabase() async {
    await CustomerDatabase.instance.insertData(await saveCustomer());
    Get.snackbar('Success', 'Successfully Added.',
        snackPosition: SnackPosition.TOP);
  }

  updateIntoDatabase() async {
    await CustomerDatabase.instance.updateData(await saveCustomer());
    Get.snackbar('Success', 'Update Successfully.',
        snackPosition: SnackPosition.TOP);
  }

  late final RxList<CustomerModel> _customerList = <CustomerModel>[].obs;
  RxList<CustomerModel> get customerList => _customerList;

  getCustomerFromDatabase() async {
    await CustomerDatabase.instance.getCustomerList().then((value) {
      _customerList.value = value;
    });

    update();

    ///
    notifyChildrens();
  }
}
