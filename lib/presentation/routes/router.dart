import 'package:go_router/go_router.dart';

class AppRouter {
  static Future<T?> go<T>(context, String routeName,
      {Map<String, String> queryParameters = const {}, Object? extra}) {
    return GoRouter.of(context).pushNamed<T>(routeName,
        queryParameters: queryParameters, extra: extra);
  }

  /// Remplace la route actuelle par une nouvelle route nommée.
  ///
  /// Fonctionne en :
  /// - Remplaçant la route actuelle (pas de retour possible à la route remplacée).
  /// - Ne modifie pas les autres routes en-dessous dans la pile.
  static goReplace(context, String routeName,
      {Map<String, String> queryParameters = const {}, Object? extra}) {
    GoRouter.of(context).replaceNamed(routeName,
        queryParameters: queryParameters, extra: extra);
  }

  /// Navigue vers une nouvelle route nommée en vidant complètement la pile de navigation précédente.
  ///
  /// Fonctionne en :
  /// 1. Retirant toutes les routes existantes (pop jusqu'à ce que la pile soit vide).
  /// 2. Naviguant vers la nouvelle route via `pushNamed`.
  ///
  static Future<T?> goPushNamedAndRemoveUntil<T>(context, String routeName,
      {Map<String, String> queryParameters = const {}, Object? extra}) {
    while (GoRouter.of(context).canPop()) {
      GoRouter.of(context).pop();
    }
    return GoRouter.of(context).pushNamed<T>(routeName,
        queryParameters: queryParameters, extra: extra);
  }

  static pop(context) => GoRouter.of(context).pop();
}
