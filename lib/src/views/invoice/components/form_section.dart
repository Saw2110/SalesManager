// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../../../widgets/widgets.dart';
// import '../invoice_controller.dart';
//
// class InvoiceForm extends GetView<InvoiceController> {
//   const InvoiceForm({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.only(
//         bottom: MediaQuery.of(context).viewInsets.bottom,
//         left: 10.0,
//         right: 10.0,
//       ),
//       child: Container(
//         constraints: bottomSheetConstraints(context),
//         child: Form(
//           key: controller.formKey,
//           child: SingleChildScrollView(
//             physics: const BouncingScrollPhysics(),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisSize: MainAxisSize.min,
//               children: <Widget>[
//                 TextFormField(
//                   controller: controller.firstNameController,
//                   decoration: const InputDecoration(labelText: 'First Name'),
//                   validator: (value) {
//                     if (value!.isEmpty) {
//                       return 'Please enter first name';
//                     }
//                     return null;
//                   },
//                 ),
//                 TextFormField(
//                   controller: controller.lastNameController,
//                   decoration: const InputDecoration(labelText: 'Last Name'),
//                   validator: (value) {
//                     if (value!.isEmpty) {
//                       return 'Please enter last name';
//                     }
//                     return null;
//                   },
//                 ),
//                 TextFormField(
//                   controller: controller.emailController,
//                   decoration: const InputDecoration(labelText: 'Email'),
//                   validator: (value) {
//                     if (value!.isEmpty) {
//                       return 'Please enter email address';
//                     }
//                     if (!RegExp(r'\b[\w\.-]+@[\w\.-]+\.\w{2,4}\b')
//                         .hasMatch(value)) {
//                       return 'Please enter a valid email address';
//                     }
//                     return null;
//                   },
//                 ),
//                 TextFormField(
//                   controller: controller.phoneController,
//                   decoration: const InputDecoration(labelText: 'Phone Number'),
//                   validator: (value) {
//                     if (value!.isEmpty) {
//                       return 'Please enter phone number';
//                     }
//                     return null;
//                   },
//                 ),
//                 TextFormField(
//                   controller: controller.addressController,
//                   decoration: const InputDecoration(labelText: 'Address'),
//                   validator: (value) {
//                     if (value!.isEmpty) {
//                       return 'Please enter address';
//                     }
//                     return null;
//                   },
//                 ),
//
//                 verticalSpace(space: 20.0),
//
//                 ///
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Expanded(
//                       child: ElevatedButton(
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.redAccent,
//                         ),
//                         onPressed: () {
//                           Navigator.pop(context);
//                         },
//                         child: const Text("CANCEL"),
//                       ),
//                     ),
//                     horizantalSpace(space: 10.0),
//                     Expanded(
//                       child: ElevatedButton(
//                         onPressed: () {
//                           if (controller.formKey.currentState!.validate()) {
//                             Map<String, dynamic> newCustomer = {
//                               'firstName': controller.firstNameController.text,
//                               'lastName': controller.lastNameController.text,
//                               'email': controller.emailController.text,
//                               'phone': controller.phoneController.text,
//                               'address': controller.addressController.text
//                             };
//                             //
//                             debugPrint("NEW CUSTOMER => $newCustomer");
//                           }
//                         },
//                         child: const Text("CONFIRM"),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
