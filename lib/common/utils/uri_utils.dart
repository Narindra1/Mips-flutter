import 'package:url_launcher/url_launcher.dart';

/// Facilite les actions uri
class UriUtils {
  static Future<void> trylaunchUrl(String url) async {
    final Uri params = Uri.parse(url);
    // bool encounterError = false;
    if (await canLaunchUrl(params)) {
      if (!await launchUrl(params)) {
        // encounterError = true;
      }
    } else {
      // encounterError = true;
    }
  }

  static Future<void> trylaunchTel(String tel) async {
    final Uri params = Uri(
      scheme: 'tel',
      path: tel,
    );
    // bool encounterError = false;
    if (await canLaunchUrl(params)) {
      if (!await launchUrl(params)) {
        // encounterError = true;
      }
    } else {
      // encounterError = true;
    }
  }

  static Future<void> trySendMail(String contactAdress, String subject,
      {String body = ""}) async {
    final Uri params = Uri(
        scheme: 'mailto',
        path: contactAdress,
        queryParameters: {'subject': subject, 'body': body});
    // bool encounterError = false;
    if (await canLaunchUrl(params)) {
      if (!await launchUrl(params)) {
        // encounterError = true;
      }
    } else {
      // encounterError = true;
    }
  }
}
