import 'dart:io';

/// Classe permettant de corriger les erreurs de certificat HTTP sur Android 6 et versions inférieures.
class NetworkHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
