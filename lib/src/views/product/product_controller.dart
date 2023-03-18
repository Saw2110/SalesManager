import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'db/product_db.dart';
import 'model/product_model.dart';

class ProductController extends GetxController {
  ProductController();

  final formKey = GlobalKey<FormState>();
  late TextEditingController _productIdController = TextEditingController();
  late TextEditingController _productNameController = TextEditingController();
  late TextEditingController _productDescriptionController =
      TextEditingController();
  late TextEditingController _productPriceController = TextEditingController();
  late TextEditingController _productQuantityController =
      TextEditingController();

  TextEditingController get productIdController => _productIdController;
  TextEditingController get productNameController => _productNameController;
  TextEditingController get productDescriptionController =>
      _productDescriptionController;
  TextEditingController get productPriceController => _productPriceController;
  TextEditingController get productQuantityController =>
      _productQuantityController;

  late BuildContext _context;
  BuildContext get context => _context;
  late final NavigatorState navigator = Navigator.of(_context);
  set getContext(BuildContext value) {
    _context = value;

    getProductFromDatabase();
  }

  @override
  void onInit() {
    super.onInit();
    debugPrint("onInit");
    getProductFromDatabase();
  }

  @override
  void onReady() {
    super.onReady();
    debugPrint("onInit");
    getProductFromDatabase();
  }

  @override
  void onClose() {
    _productIdController.dispose();
    _productNameController.dispose();
    _productDescriptionController.dispose();
    _productPriceController.dispose();
    _productQuantityController.dispose();
  }

  bool isEdit = false;
  set getIsEdit(bool value) {
    isEdit = value;

    update();
    notifyChildrens();
  }

  clear() async {
    _productIdController = TextEditingController(text: "");
    _productNameController = TextEditingController(text: "");
    _productDescriptionController = TextEditingController(text: "");
    _productPriceController = TextEditingController(text: "");
    _productQuantityController = TextEditingController(text: "");
  }

  deleteAllProduct() async {
    await ProductDatabase.instance.deleteData();
    await getProductFromDatabase();
    navigator.pop();
  }

  saveProduct() async {
    ProductModel productData = ProductModel(
      productId: _productIdController.text.trim(),
      productName: _productNameController.text.trim(),
      productDescription: _productDescriptionController.text.trim(),
      productPrice: _productPriceController.text.trim(),
      productQuantity: _productQuantityController.text.trim(),
    );
    return productData;
  }

  // late final RxList<ProductModel> _productData = <ProductModel>[].obs;
  // RxList<ProductModel> get productData => _productData;
  getDataFromProductId({required String productID}) async {
    await ProductDatabase.instance
        .getProductFromId(productId: productID)
        .then((value) {
      getIsEdit = true;
      for (var element in value) {
        _productIdController.text = element.productId;
        _productNameController.text = element.productName;
        _productDescriptionController.text = element.productDescription;
        _productPriceController.text = element.productPrice;
        _productQuantityController.text = element.productQuantity;
      }
    });

    update();

    ///
    notifyChildrens();
  }

  checkProductExist() async {
    await ProductDatabase.instance
        .isAlreadyExist(productId: _productIdController.text.trim())
        .then((value) async {
      if (!value) {
        await insertIntoDatabase();
      } else {
        await updateIntoDatabase();
      }
    });

    if (context.mounted) navigator.pop(context);
    await getProductFromDatabase();
  }

  insertIntoDatabase() async {
    await ProductDatabase.instance.insertData(await saveProduct());
    Get.snackbar('Success', 'Successfully Added.',
        snackPosition: SnackPosition.TOP);
  }

  updateIntoDatabase() async {
    await ProductDatabase.instance.updateData(await saveProduct());
    Get.snackbar('Success', 'Update Successfully.',
        snackPosition: SnackPosition.TOP);
  }

  late final RxList<ProductModel> _productList = <ProductModel>[].obs;
  RxList<ProductModel> get productList => _productList;

  getProductFromDatabase() async {
    _productList.clear();
    await ProductDatabase.instance.getProductList().then((value) {
      _productList.value = value;
    });

    update();

    ///
    notifyChildrens();
  }
}
