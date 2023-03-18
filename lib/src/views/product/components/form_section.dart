import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../widgets/widgets.dart';
import '../product_controller.dart';

class ProductForm extends GetView<ProductController> {
  const ProductForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 10.0,
        right: 10.0,
      ),
      child: Container(
        constraints: bottomSheetConstraints(context),
        child: Form(
          key: controller.formKey,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextFormField(
                  controller: controller.productIdController,
                  decoration: const InputDecoration(labelText: 'Product Id'),
                  readOnly: controller.isEdit ? true : false,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      controller.formKey.currentState!.validate();
                    }
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter product Id';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: controller.productNameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      controller.formKey.currentState!.validate();
                    }
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter product name';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: controller.productDescriptionController,
                  decoration: const InputDecoration(labelText: 'Description'),
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      controller.formKey.currentState!.validate();
                    }
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter product description';
                    }

                    return null;
                  },
                ),
                TextFormField(
                  controller: controller.productPriceController,
                  decoration: const InputDecoration(labelText: 'Price'),
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      controller.formKey.currentState!.validate();
                    }
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter product price';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: controller.productQuantityController,
                  decoration: const InputDecoration(labelText: 'Quantity'),
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      controller.formKey.currentState!.validate();
                    }
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter quantity';
                    }
                    return null;
                  },
                ),

                verticalSpace(space: 20.0),

                ///
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("CANCEL"),
                      ),
                    ),
                    horizantalSpace(space: 10.0),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          if (controller.formKey.currentState!.validate()) {
                            controller.checkProductExist();
                          }
                        },
                        child: const Text("CONFIRM"),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
