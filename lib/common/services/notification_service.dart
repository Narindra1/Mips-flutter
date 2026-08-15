import 'package:mips/common/common.dart';
import 'package:dart_pusher_channels/dart_pusher_channels.dart';

import '../../data/repositories/userpref_repository_impl.dart';
import 'environment_wrapper.dart';

class NotificationService {
  final UserPrefRepositoryImpl userPrefRepositoryImpl;
  final EnvironmentWrapper environmentWrapper;

  NotificationService({
    required this.userPrefRepositoryImpl,
    required this.environmentWrapper,
  });

  void connectToReverb({
    required String userId,
    required String token,
    required String host,
    required Function() onNewNotification, // ex: 'example.com'
  }) async {
    // Activer les logs pour debug
    PusherChannelsPackageLogger.enableLogs();

    // Configuration équivalente à ton objet JS
    final options = PusherChannelsOptions.fromHost(
      scheme: 'ws',
      // ou 'wss' si TLS activé
      host: host,
      key: '7wqjsxiyjmyih2om8x0j',
      port: 8081,
      shouldSupplyMetadataQueries: true,
    );

    final client = PusherChannelsClient.websocket(
      options: options,
      connectionErrorHandler: (exception, stack, refresh) async {
        AppUtils.showDebugLog(
          runtimeType,
          '🔄 Erreur de connexion : $exception',
        );
        refresh();
      },
    );

    // Channel privé + authentification via endpoint Laravel
    final channel = client.privateChannel(
      'user.$userId.notifications',
      authorizationDelegate:
          EndpointAuthorizableChannelTokenAuthorizationDelegate.forPrivateChannel(
            authorizationEndpoint: Uri.parse(
              '${EnvironmentWrapper(userPrefRepositoryImpl: userPrefRepositoryImpl).baseUrlAPI}/broadcasting/auth',
            ),
            headers: {
              'Authorization': 'Bearer ${userPrefRepositoryImpl.getToken()}',
              'Accept': 'application/json',
            },
          ),
    );
    // final StreamSubscription connectionSubs =
    client.onConnectionEstablished.listen((_) {
      // Subscribes to the channel if didn't unsubscribe from it intentionally
      channel.subscribeIfNotUnsubscribed();
    });
    // Connexion
    await client.connect();

    // StreamSubscription<ChannelReadEvent> somePrivateChannelEventSubs =
    channel.bind('private-MyEvent').listen((event) {
      AppUtils.showDebugLog(
        runtimeType,
        'Event from the private channel fired! ${event.data.toString()}',
      );
    });
    // Abonnement
    channel.subscribe();
    AppUtils.showDebugLog(
      runtimeType,
      '✅ Connecté et abonné au canal user.$userId.notifications',
    );
  }
}
