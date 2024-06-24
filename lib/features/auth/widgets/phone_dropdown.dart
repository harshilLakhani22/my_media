import 'package:coonch/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class PhoneNumberDropDown extends StatelessWidget {
  const PhoneNumberDropDown({
    super.key,
    required this.dropDownValue,
    required this.onChanged,
  });

  final String dropDownValue;
  final Function(String?) onChanged;

  static const List<String> phoneCode = ["+91", "+84", "+79", "+69"];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(MSizes.borderRadiusLg) ,
        border: Border.all(
          color: Colors.grey.shade700, // Set border color
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: DropdownButton<String>(
          value: dropDownValue,
          items: phoneCode.map((String code) {
            return DropdownMenuItem<String>(
              value: code,
              child: Text(code),
            );
          }).toList(),
          onChanged: onChanged,
          icon: const Icon(Icons.keyboard_arrow_down),
          borderRadius: BorderRadius.circular(MSizes.borderRadiusLg),
          underline: const SizedBox(),
        ),
      ),
    );
  }
}
