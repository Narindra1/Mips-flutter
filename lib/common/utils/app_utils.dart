import 'dart:convert';

import 'package:MIPS/presentation/configurations/extension_for_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'dart:io';

// import 'package:image_compression_flutter/image_compression_flutter.dart';
import 'package:intl/intl.dart';

import '../constants/constant.dart';

/// Class utilitaire
class AppUtils {
  static Color stringToColor(String colorString) {
    // Remove the hash (#) if it exists
    String formattedColor = colorString.replaceFirst('#', '');

    // Ensure the string has 8 characters for ARGB format
    if (formattedColor.length == 6) {
      formattedColor = 'FF$formattedColor'; // Add alpha if not provided
    }

    // Parse the string as an integer and create a Color
    return Color(int.parse(formattedColor, radix: 16));
  }

  static void showDebugLog(Type runtimeType, String message) {
    if (kDebugMode) {
      debugPrint("${runtimeType.toString()}: $message");
    }
  }

  static String fileImageToBase64(File file) {
    return base64Encode(file.readAsBytesSync());
  }

  static String uint8ListImageToBase64(Uint8List image) {
    return base64Encode(image);
  }

  static String formatNumberWithSpaces(int number) {
    final formatter = NumberFormat("#,##0", "en_US");
    return formatter.format(number).replaceAll(',', ' ');
  }

  // static Future<Uint8List?> compressImageFile(File file) async {
  //   Configuration config = const Configuration(
  //     outputType: ImageOutputType.jpg,
  //     useJpgPngNativeCompressor: false,
  //     // set quality between 0-100
  //     quality: 25,
  //   );
  //   final param = ImageFileConfiguration(
  //       input: ImageFile(
  //           filePath: file.absolute.path, rawBytes: file.readAsBytesSync()),
  //       config: config);
  //   final output = await compressor.compress(param);
  //   double fileInputSize = await file.length() / 1024;
  //   showDebugLog(AppUtils,
  //       "compression :  compressed ${output.sizeInBytes / 1024}KB original $fileInputSize");
  //   return output.rawBytes;
  // }

  static Future<Uint8List?> compressImageFile(File file) async {
    try {
      // Get original size
      final fileInputSize = await file.length() / 1024;

      // Compress using flutter_image_compress
      final result = await FlutterImageCompress.compressWithFile(
        file.absolute.path,
        quality: 25, // quality between 0–100
        format: CompressFormat.jpeg,
      );

      if (result == null) return null;

      // Show debug log
      final compressedSize = result.length / 1024;
      print(
          "compression : compressed ${compressedSize.toStringAsFixed(2)}KB original ${fileInputSize.toStringAsFixed(2)}KB");

      return Uint8List.fromList(result);
    } catch (e) {
      print("Image compression failed: $e");
      return null;
    }
  }

  static String formatTodaysDate(BuildContext context, String dateString) {
    // Parse the input date
    DateTime date = DateTime.parse(dateString);

    // Format the date using the specified format (dd MMMM yyyy)
    String formattedDate =
        DateFormat('dd MMMM yyyy', Localizations.localeOf(context).languageCode)
            .format(date);

    // Replace the {date} placeholder with the formatted date
    return context.appLoc.todays_date_prompt(formattedDate);
  }

  static String formatDateDDMMYY(BuildContext context, String dateString) {
    // Parse the input date
    DateTime date = DateTime.parse(dateString);

    // Format the date using the specified format (dd MMMM yyyy)
    String formattedDate =
        DateFormat('dd MMMM yyyy', Localizations.localeOf(context).languageCode)
            .format(date);

    // Replace the {date} placeholder with the formatted date
    return context.appLoc.format_date_ddmmyy(formattedDate);
  }

  static String formatDate(BuildContext context, String dateString) {
    // Parse the input date
    DateTime date = DateTime.parse(dateString);

    // Format the date using the specified format (dd MMMM yyyy)
    String formattedDate =
        DateFormat('dd MMMM yyyy', Localizations.localeOf(context).languageCode)
            .format(date);

    // Replace the {date} placeholder with the formatted date
    return context.appLoc.available_date_prompt(formattedDate);
  }

  static String dateAvailablity(
      BuildContext context, AnnonceType annonceType, String dateString) {
    // Parse the input date
    DateTime date = DateTime.parse(dateString);

    String formattedDate = DateFormat('dd/MM/yy').format(date);

    // Replace the {date} placeholder with the formatted date
    switch (annonceType) {
      case AnnonceType.premium:
        return context.appLoc.available_premium_date_prompt(formattedDate);
      case AnnonceType.vip:
        return context.appLoc.available_vip_date_prompt(formattedDate);
      default:
        return context.appLoc.available_date_prompt(formattedDate);
    }
  }

  static String formatDateMin(String dateString) {
    // Parse the input date
    DateTime date = DateTime.parse(dateString);

    // Format the date using the specified format (dd MMMM yyyy)
    String formattedDate = DateFormat('dd/MM/yy').format(date);

    // Replace the {date} placeholder with the formatted date
    return formattedDate;
  }

  static String formatDateWithHHMMMin(String dateString) {
    // Parse the input date
    DateTime date = DateTime.parse(dateString);

    // Format the date using the specified format (dd MMMM yyyy)
    String formattedDate = DateFormat('dd/MM/yy HH:mm').format(date);

    // Replace the {date} placeholder with the formatted date
    return formattedDate;
  }

  static String formatDateReadableWithMonth(
      BuildContext context, String dateString) {
    // Parse the input date
    DateTime date = DateTime.parse(dateString);

    // Format the date using the specified format (dd MMMM yyyy)
    String formattedDate = DateFormat(
            "d MMMM y HH:mm", Localizations.localeOf(context).languageCode)
        .format(date);

    // Replace the {date} placeholder with the formatted date
    return formattedDate;
  }

  static String formatNumber(String number) {
    // Clean input: remove spaces, +, and non-digits
    String text = number.replaceAll(' ', '').replaceAll("+", '');

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

    return text;
  }

  static String getDate(String dateInput) {
    DateTime inputDate;
    try {
      // Attempt to parse the input ISO string (e.g., "2025-02-03T12:52:31.000000Z")
      inputDate = DateTime.parse(dateInput).toLocal();
    } catch (e) {
      // If parsing fails, return an error message or a default value.
      return "N/A";
    }

    DateTime now = DateTime.now();
    Duration diff = now.difference(inputDate);

    if (diff.inDays < 7) {
      if (diff.inDays >= 1) {
        return "${diff.inDays} j";
      } else if (diff.inHours >= 1) {
        return "${diff.inHours} h";
      } else if (diff.inMinutes >= 1) {
        return "${diff.inMinutes} mn";
      } else {
        return " ";
      }
    } else {
      if (inputDate.year == now.year) {
        return DateFormat('dd MMM').format(inputDate);
      }
      // Otherwise, include the year ("dd MMM yyyy" e.g., "03 Feb 2024").
      else {
        return DateFormat('dd MMM yyyy').format(inputDate);
      }
    }
  }

  String formatPhoneNumber(String phoneNumber) {
    // Remove all spaces first to standardize
    phoneNumber = phoneNumber.replaceAll(' ', '');

    if (phoneNumber.startsWith('261') && phoneNumber.length == 12) {
      // Format as "261 34 00 000 00"
      final formatter = NumberFormat("000 00 00 000 00");
      return formatter.format(int.tryParse(phoneNumber) ?? 0);
    } else if (phoneNumber.length == 10) {
      // Format as "034 00 000 00"
      final formatter = NumberFormat("000 00 000 00");
      return formatter.format(int.tryParse(phoneNumber) ?? 0);
    }

    // If it doesn't match known formats, return the original string
    return phoneNumber;
  }

  static String sanitizeNumber(String tel) {
    String ret = tel.replaceAll(" ", "");
    if (ret.startsWith("+261")) {
      ret = ret.replaceAll("+261", "0");
    } else if (ret.startsWith("261")) {
      ret = ret.replaceAll("261", "0");
    }
    return ret;
  }
}
