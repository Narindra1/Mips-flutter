import 'dart:async';
import 'dart:convert';

import 'package:MIPS/common/common.dart';
import 'package:MIPS/common/di/injections.dart';
import 'package:MIPS/common/services/navigation_service.dart';
import 'package:MIPS/presentation/bloc/annonce_bloc.dart';
import 'package:MIPS/presentation/bloc/app_bloc.dart';
import 'package:MIPS/presentation/configurations/colors_list.dart';
import 'package:MIPS/presentation/l10n/app_localizations.dart';
import 'package:MIPS/presentation/routes/route.dart';
import 'package:MIPS/presentation/routes/router.dart';
import 'package:app_links/app_links.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:device_preview/device_preview.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:json_theme/json_theme.dart';
import 'dart:io';

import 'package:terminate_restart/terminate_restart.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  TerminateRestart.instance.initialize();
  // await EasyLocalization.ensureInitialized();
  await init();

  if (Platform.isAndroid) {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    // Compatibilité réseau avec anciennes versions Android
    if (androidInfo.version.sdkInt < 26) {
      HttpOverrides.global = NetworkHttpOverrides();
    }
  }
  final themeStr = await rootBundle.loadString('assets/theme/theme_v4.json');
  final themeJson = jsonDecode(themeStr);
  final theme = (ThemeDecoder.decodeThemeData(themeJson)!)
    ..copyWith(brightness: Brightness.dark);

  runApp(MyApp(theme: theme));
}

class MyApp extends StatefulWidget {
  final ThemeData theme;
  const MyApp({super.key, required this.theme});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final AppLinks _appLinks;
  StreamSubscription? _linkSubscription;
  bool _initialUriHandled = false;

  @override
  void initState() {
    super.initState();
    _appLinks = AppLinks();
    _initDeepLinks();
  }

  @override
  void dispose() {
    _linkSubscription?.cancel();
    super.dispose();
  }

  void _initDeepLinks() async {
    // Écoute d'abord le stream
    _linkSubscription = _appLinks.uriLinkStream.listen((uri) {
      // Ignore le premier event si on a déjà géré l'initial link
      if (!_initialUriHandled) {
        _initialUriHandled = true;
        return;
      }
      _handleUri(uri);
    });

    // Vérifie ensuite le cold start
    final uri = await _appLinks.getInitialLink();
    if (uri != null) {
      _initialUriHandled = true;
      _handleUri(uri);
    }
  }

  void _handleUri(Uri uri) {
    debugPrint("DEEP LINK RECEIVED: $uri");

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      debugPrint("PATH SEGMENTS : ${uri.pathSegments}");
      if (uri.pathSegments.isNotEmpty) {
        // 1. Va à home (remplace tout l'historique)
        AppRoute.router.goNamed(RoutesNames.home);
        if (uri.pathSegments.contains("profil")) {
          debugPrint("PATH PROFIL");
          // 2. Une fois les données chargées, PUSH vers le profil
          //    (ajoute au stack au lieu de remplacer)
          await Future.delayed(const Duration(milliseconds: 50), () {
            AppRoute.router.pushNamed(
              RoutesNames.profilDetail,
              queryParameters: {"authorID": uri.pathSegments.last},
            );
          });
        } else if (uri.pathSegments.contains("annonces")) {
          debugPrint("PATH ANNONCE");
          // 2. Une fois les données chargées, PUSH vers le profil
          //    (ajoute au stack au lieu de remplacer)
          await Future.delayed(const Duration(milliseconds: 50), () {
            AppRoute.router.pushNamed(RoutesNames.detailGlobal,
                queryParameters: {
                  "id": uri.pathSegments.last,
                  // "name": state.mesAnnonces[index].title,
                },
                extra: GetIt.instance<AnnonceBloc>()
                  ..add(LoadAnnonceWithPartnerSponsor(
                      id: uri.pathSegments.last)));
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.instance<AppBloc>()..add(InitEvent()),
      child: BlocBuilder<AppBloc, AppState>(
        builder: (context, state) {
          GetIt.instance<NetworkService>().setAppBloc(context.read<AppBloc>());
          return MaterialApp.router(
            builder: BotToastInit(),
            // restorationScopeId: "Mahafaka",
            restorationScopeId: "MIPS",
            scaffoldMessengerKey: GlobalContextService.snackbarKey,
            theme: widget.theme.copyWith(
              outlinedButtonTheme: OutlinedButtonThemeData(
                  style: ButtonStyle(
                side: WidgetStatePropertyAll(
                    const BorderSide(color: tertiaryColor)),
              )),
              filledButtonTheme: FilledButtonThemeData(
                style: FilledButton.styleFrom(foregroundColor: Colors.white),
              ),
              navigationBarTheme: NavigationBarThemeData(
                labelTextStyle: WidgetStatePropertyAll(
                  const TextStyle(
                    color: tertiaryColor,
                  ),
                ),
              ),
              textTheme: Theme.of(context).textTheme.apply(
                    fontSizeFactor: state.textScale,
                    fontSizeDelta: state.textScale,
                    fontFamily: "Pretendard",
                  ),
            ),
            title: "MIPS",
            // title: "Mahafaka",
            debugShowCheckedModeBanner: false,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            // localizationsDelegates: AppLocalizations.localizationsDelegates,
            // supportedLocales: AppLocalizations.supportedLocales,
            locale: state.lang,
            supportedLocales: [
              Locale('fr'),
              Locale('en'),
              Locale('ko'),
              Locale('zh'),
              Locale('af'),
            ],
            routerConfig: AppRoute.router,
          );
        },
      ),
    );
  }

  /// Si on n'utilise pas le theme.json
  ThemeData _buildTheme(BuildContext context, AppState state) {
    var baseTheme = ThemeData(
        useMaterial3: true,
        textTheme: Theme.of(context).textTheme.apply(
              fontSizeFactor: state.textScale,
              fontSizeDelta: state.textScale,
            ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: tertiaryColor,
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: tertiaryColor, // Text and icon color
            backgroundColor: Colors.white, // Background color
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        iconButtonTheme: IconButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.white),
            iconColor: MaterialStateProperty.all(tertiaryColor),
          ),
        ),
        scaffoldBackgroundColor: const Color(0xfff3f3f3));

    return baseTheme.copyWith(
      textTheme: GoogleFonts.openSansTextTheme(baseTheme.textTheme),
    );
  }
}
