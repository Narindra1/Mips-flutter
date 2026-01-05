import 'package:MIPS/presentation/routes/route.dart';
import 'package:flutter/material.dart';

class NavigationService {
  static NavigationService? _instance;
  static NavigationService get instance => _instance ??= NavigationService._();

  NavigationService._();

  bool _isProcessing = false;

  Future<void> handleDeepLink(Uri uri) async {
    if (_isProcessing) return;

    _isProcessing = true;
    try {
      debugPrint("Processing deep link: $uri");

      WidgetsBinding.instance.addPostFrameCallback((_) {
        // Use goNamed to ensure unique navigation
        AppRoute.router.pushNamed(RoutesNames.home);

        Future.delayed(const Duration(seconds: 2), () {
          final authorID =
              uri.pathSegments.isNotEmpty ? uri.pathSegments.last : '26';

          AppRoute.router.pushNamed(
            RoutesNames.profilDetail,
            queryParameters: {"authorID": authorID},
          );
        });
      });

      // Small delay to prevent rapid successive calls
      await Future.delayed(const Duration(milliseconds: 100));
    } finally {
      _isProcessing = false;
    }
  }
}
