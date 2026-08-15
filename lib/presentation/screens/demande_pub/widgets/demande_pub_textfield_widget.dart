import 'package:flutter/material.dart';

import '../../../../common/constants/constant.dart';
import '../../../../common/utils/phone_number_formatter.dart';
import '../../../configurations/colors_list.dart';

class DemandePubTextFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hintText;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final int maxLines;
  final bool isReadOnly;

  const DemandePubTextFieldWidget(
      {super.key,
      required this.controller,
      required this.label,
      required this.hintText,
      this.validator,
      this.keyboardType = TextInputType.text,
      this.maxLines = 1,
      this.isReadOnly = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(label, style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(
          height: smallPadding,
        ),
        TextFormField(
          readOnly: isReadOnly,
          autovalidateMode: AutovalidateMode.onUnfocus,
          controller: controller,
          inputFormatters: keyboardType == TextInputType.phone
              ? [PhoneNumberFormatter()]
              : [],
          style: const TextStyle(),
          decoration: InputDecoration(
            errorStyle: const TextStyle(fontWeight: FontWeight.bold),
            errorMaxLines: 3,
            hintStyle: TextStyle(color: Colors.grey.shade700),
            floatingLabelBehavior: FloatingLabelBehavior.never,
            filled: true,
            fillColor: Colors.white,
            hintText: hintText,
            labelStyle: const TextStyle(color: Colors.grey),
            border: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.grey),
              borderRadius: BorderRadius.circular(mediumPadding),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: tertiaryColor),
              borderRadius: BorderRadius.circular(8.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.grey),
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          textInputAction:
              maxLines > 1 ? TextInputAction.newline : TextInputAction.done,
          keyboardType: maxLines > 1 ? TextInputType.multiline : keyboardType,
          maxLines: maxLines,
          validator: validator,
        ),
      ],
    );
  }
}
