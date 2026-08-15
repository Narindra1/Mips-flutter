import 'package:flutter/services.dart';

/// Formatteur de numero telephone
class PhoneNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String text = newValue.text.replaceAll(' ', '').replaceAll("+", '');

    if (text.length > 3) {
      text = '${text.substring(0, 3)} ${text.substring(3)}';
    }
    if (text.length > 6) {
      text = '${text.substring(0, 6)} ${text.substring(6)}';
    }
    if (text.length > 10) {
      text =
          '${text.substring(0, 10)} ${text.substring(10)}'; // Ensure max length is enforced
    }
    if (text.length > 12) {
      text = text.substring(0, 13); // Ensure max length is enforced
    }

    return newValue.copyWith(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }
}
