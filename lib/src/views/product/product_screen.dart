
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sales_transaction/src/utils/utils.dart';

import '../../config/config.dart';
import '../../widgets/widgets.dart';
import '../salestransaction/salestransaction.dart';
import 'components/form_section.dart';
import 'model/product_model.dart';
import 'product_controller.dart';

class ProductScreen extends GetView<ProductController> {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    controller.getContext = context;
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          title: const Text("Products"),
          actions: [
            IconButton(
              onPressed: () {
                MyCustomAlert(
                  title: "Delete All Products",
                  child: CustomAlertWidget(
                    title: "Are you sure?",
                    description: "You want to delete all products",
                    confirm: () {
                      controller.deleteAllProduct();
                    },
                  ),
                  showCancle: true,
                ).show(context);
              },
              icon: const Icon(Icons.delete_forever_outlined),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          label: const Text("Add Product"),
          onPressed: () {
            controller.clear();
            controller.getIsEdit = false;
            MyButtomSheet(
              title: "Add Product",
              body: const ProductForm(),
            ).show(context);
          },
        ),
        body: controller.productList.isNotEmpty
            ? ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: controller.productList.length,
                itemBuilder: (context, index) {
                  ProductModel indexData = controller.productList[index];
                  return Stack(
                    alignment: Alignment.topRight,
                    children: [
                      Container(
                        decoration: ContainerDecoration.decoration(),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(indexData.productName,
                                style: kTitleText.copyWith(fontSize: 18.0)),
                            verticalSpace(),
                            CustomRichText(
                              title: "",
                              applyStyle: false,
                              value: indexData.productDescription,
                            ),
                            verticalSpace(space: 8.0),
                            CustomRichText(
                              title: "Stock Qty : ",
                              applyStyle: false,
                              value: indexData.productQuantity,
                            ),
                            verticalSpace(),
                            CustomRichText(
                              title: "Price : ",
                              applyStyle: false,
                              value: indexData.productPrice,
                            ),
                          ],
                        ).pa(10.0),
                      ).paddingSymmetric(horizontal: 10.0, vertical: 5.0),
                      Column(
                        children: [
                          IconButton(
                            onPressed: () {
                              MyCustomAlert(
                                title: "Edit Product Details",
                                child: CustomAlertWidget(
                                  title: "Are you sure?",
                                  description:
                                      "You want to edit product details.",
                                  confirm: () {
                                    Navigator.pop(context);
                                    controller.getDataFromProductId(
                                      productID: indexData.productId,
                                    );
                                    MyButtomSheet(
                                      title: "Edit Product",
                                      body: const ProductForm(),
                                    ).show(context);
                                  },
                                ),
                                showCancle: true,
                              ).show(context);
                            },
                            icon: Icon(Icons.edit, color: successColor),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              )
            : const NoDataWidget(text: "No Product Found"),
      ),
    );
  }
}
