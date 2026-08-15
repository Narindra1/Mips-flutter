import 'package:mips/common/common.dart';
import 'package:mips/common/services/environment_wrapper.dart';
import 'package:mips/presentation/bloc/app_bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../data/repositories/userpref_repository_impl.dart';

/// Service pour les opérations réseau.
///
/// [UserPrefRepository] permet de récupérer le token depuis les préférences partagées.
/// [EnvironmentWrapper] permet d’obtenir la bonne URL de base,
/// selon l’environnement ('dev' ou 'prod').
class NetworkService {
  AppBloc? appBloc;
  late InternetConnectionChecker internetConnectionChecker;
  final UserPrefRepositoryImpl userPrefRepositoryImpl;
  final EnvironmentWrapper environmentWrapper;

  NetworkService({
    required this.userPrefRepositoryImpl,
    required this.environmentWrapper,
    this.appBloc,
  }) {
    internetConnectionChecker = InternetConnectionChecker.createInstance(
      addresses: [
        // AddressCheckOptions(hostname: defaultInternetCheckHostName, port: 80),
        // AddressCheckOptions(hostname: environmentWrapper.hostName, port: 80),
        AddressCheckOption(uri: Uri.parse(defaultInternetCheckHostName)),
        AddressCheckOption(uri: Uri.parse(environmentWrapper.hostName)),
      ],
    );
  }

  void setAppBloc(AppBloc appBloc) {
    this.appBloc = appBloc;
  }

  Dio getDioInstance() {
    Dio dio = Dio(
      BaseOptions(
        contentType: Headers.jsonContentType,
        headers: {'accept': 'application/json'},
        baseUrl: environmentWrapper.baseUrlAPI,
        connectTimeout: const Duration(seconds: 30),
        sendTimeout: const Duration(seconds: 40),
      ),
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
          /// Set token
          String token = userPrefRepositoryImpl.getToken();
          options.headers['Authorization'] = 'Bearer $token';

          /// Set lang
          String lang = userPrefRepositoryImpl.getLangHeader();
          options.headers['X-Language'] = lang;

          /// Force l'utilisation de l'URL de production pour la vérification des mises à jour.
          if (options.path.isNotEmpty &&
              options.path.contains("app/getUpdate")) {
            options.baseUrl = baseUrlApiPROD;
          }
          AppUtils.showDebugLog(
            runtimeType,
            "${options.baseUrl}${options.path}\n${options.headers}\n${options.data}",
          );
          return handler.next(options);
        },
        onResponse: (Response response, ResponseInterceptorHandler handler) {
          AppUtils.showDebugLog(
            runtimeType,
            "Response: StatusCode:${response.statusCode} ${response.headers} ${response.data}",
          );
          return handler.next(response);
        },
        onError: (DioException error, ErrorInterceptorHandler handler) async {
          AppUtils.showDebugLog(
            runtimeType,
            "Response: StatusCode:${error.response?.statusCode} ${error.response?.headers} ${error.response?.data} ${error.message}",
          );

          /// Si le token est expiré ou si l'utilisateur n'est pas connecté, notifie [AppLoc].
          if (error.response?.statusCode == 401 &&
              error.requestOptions.uri.toString().replaceAll(
                    environmentWrapper.baseUrlAPI,
                    "",
                  ) !=
                  "/profil" &&
              error.response?.data.toString() ==
                  "{message: Authentication required, status: 0}") {
            _notityDeconnection();
          }
          return handler.next(error);
        },
      ),
    );
    return dio;
  }

  /// Notifie [AppBloc] du statut déconnecté.
  void _notityDeconnection() {
    if (appBloc != null) {
      /// Actualise les informations de l'utilisateur.
      appBloc!.add(GetUserInfoEvent());
    }
  }

  Future<bool> isConnected() async {
    final bool isConnected = await internetConnectionChecker.hasConnection;
    return isConnected;
  }

  void runNetworkStateListener(
    Function() onConnectionRestored,
    Function() onConnectionLost,
  ) {
    internetConnectionChecker.onStatusChange.listen((event) {
      if (event == InternetConnectionStatus.connected) {
        if (kDebugMode) {
          print("Connection restored");
        }
        onConnectionRestored();
      } else {
        if (kDebugMode) {
          print("Connection lost");
        }
        onConnectionLost();
      }
    });
  }
}
