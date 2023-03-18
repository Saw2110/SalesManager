import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class CustomDropdownWidget<T> extends StatelessWidget {
  const CustomDropdownWidget({
    super.key,
    required this.items,
    required this.hintText,
    this.validator,
    this.onChanged,
    this.onSaved,
    required this.controller,
    this.search,
  });

  final List<DropdownMenuItem<T>>? items;
  final String hintText;
  final String? Function(T?)? validator;
  final void Function(T?)? onChanged, onSaved;
  final TextEditingController controller;
  final bool Function(DropdownMenuItem<T>, String)? search;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField2<T>(
      decoration: InputDecoration(
        isDense: true,
        contentPadding: EdgeInsets.zero,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      isExpanded: true,
      hint: Text(hintText, style: const TextStyle(fontSize: 12)),
      items: items,
      validator: validator,
      onChanged: onChanged,
      onSaved: onSaved,
      buttonStyleData: const ButtonStyleData(
        height: 40,
        padding: EdgeInsets.only(right: 10.0),
      ),
      dropdownStyleData: DropdownStyleData(
        maxHeight: 150.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
        ),
      ),

      ///
      ///
      dropdownSearchData: DropdownSearchData(
        searchController: controller,
        searchInnerWidgetHeight: 50,
        searchInnerWidget: Container(
          height: 50,
          padding: const EdgeInsets.only(
            top: 8,
            bottom: 4,
            right: 8,
            left: 8,
          ),
          child: TextFormField(
            expands: true,
            maxLines: null,
            controller: controller,
            decoration: InputDecoration(
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 8,
              ),
              hintText: 'Search for an item...',
              hintStyle: const TextStyle(fontSize: 12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
        searchMatchFn: search,
        // searchMatchFn: (item, searchValue) {
        //   return (item.value.toString().toLowerCase().contains(
        //         searchValue.toString().toLowerCase(),
        //       ));
        // },
      ),
      //This to clear the search value when you close the menu
      onMenuStateChange: (isOpen) {
        if (!isOpen) {
          controller.clear();
        }
      },

      ///
      ///
    );
  }
}
