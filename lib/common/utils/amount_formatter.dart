import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

/// Formatteur de montant en separant les milliemes : XXX XXX XXX XXX ...
class AmountFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) {
      return newValue;
    }

    // Remove all non-digit characters
    String newText = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');

    // Format the number with spaces every 3 digits from the right
    String formattedText = '';
    for (int i = 0; i < newText.length; i++) {
      if (i > 0 && (newText.length - i) % 3 == 0) {
        formattedText += ' ';
      }
      formattedText += newText[i];
    }

    // Return the new formatted value
    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
}

class SingleDecimalInputFormatter extends TextInputFormatter {
  final NumberFormat formatter = NumberFormat("#,##0.##");

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // If text was deleted, return as-is
    if (newValue.text.length < oldValue.text.length) {
      return newValue;
    }

    String text = newValue.text;

    // Remove all non-digit characters except one decimal point
    text = text.replaceAll(RegExp(r'[^\d.]'), '');

    // Handle multiple decimal points - keep only the first one
    final dotIndex = text.indexOf('.');
    if (dotIndex != -1) {
      final beforeDot = text.substring(0, dotIndex + 1);
      final afterDot = text.substring(dotIndex + 1).replaceAll('.', '');
      text = beforeDot + afterDot;
    }

    // Don't format if text is empty or just a dot
    if (text.isEmpty || text == '.') {
      return TextEditingValue(
        text: text,
        selection: TextSelection.collapsed(offset: text.length),
      );
    }

    // Split into integer and decimal parts
    final parts = text.split('.');
    String integerPart = parts[0];
    String decimalPart = parts.length > 1 ? parts[1] : '';

    // Limit decimal part to 4 digits
    if (decimalPart.length > 4) {
      decimalPart = decimalPart.substring(0, 4);
    }

    // Format the integer part with thousands separators
    if (integerPart.isNotEmpty) {
      try {
        // Remove existing commas before parsing
        final cleanInteger = integerPart.replaceAll(',', '');
        if (cleanInteger.isNotEmpty) {
          final parsedInt = int.parse(cleanInteger);
          integerPart = formatter.format(parsedInt);
        }
      } catch (e) {
        // If parsing fails, use the original integer part
      }
    }

    // Reconstruct the text
    String formattedText = integerPart;
    if (decimalPart.isNotEmpty) {
      formattedText = '$integerPart.$decimalPart';
    } else if (text.endsWith('.')) {
      formattedText = '$integerPart.';
    }

    // Handle the case where user starts with a decimal point
    if (text.startsWith('.') && integerPart.isEmpty) {
      formattedText = '0.$decimalPart';
      integerPart = '0';
    }

    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
}
