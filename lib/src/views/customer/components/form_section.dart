import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../widgets/widgets.dart';
import '../customer_controller.dart';

class CustomerForm extends GetView<CustomerController> {
  const CustomerForm({super.key});

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
                  controller: controller.phoneController,
                  decoration: const InputDecoration(
                    counter: Offstage(),
                    labelText: 'Phone Number',
                  ),
                  readOnly: controller.isEdit ? true : false,
                  keyboardType: TextInputType.number,
                  maxLength: 10,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      controller.formKey.currentState!.validate();
                    }
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter phone number';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: controller.customerNameController,
                  decoration: const InputDecoration(labelText: 'Full Name'),
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      controller.formKey.currentState!.validate();
                    }
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter full name';
                    }
                    return null;
                  },
                ),
                // TextFormField(
                //   controller: controller.customerIdController,
                //   decoration: const InputDecoration(labelText: 'Last Name'),
                //   validator: (value) {
                //     if (value!.isEmpty) {
                //       return 'Please enter last name';
                //     }
                //     return null;
                //   },
                // ),
                TextFormField(
                  controller: controller.emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      controller.formKey.currentState!.validate();
                    }
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter email address';
                    }
                    if (!RegExp(r'\b[\w\.-]+@[\w\.-]+\.\w{2,4}\b')
                        .hasMatch(value)) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                ),

                TextFormField(
                  controller: controller.addressController,
                  decoration: const InputDecoration(labelText: 'Address'),
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      controller.formKey.currentState!.validate();
                    }
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter address';
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
