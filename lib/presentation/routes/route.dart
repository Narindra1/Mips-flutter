import 'package:mips/common/di/injections.dart';
import 'package:mips/data/data.dart';
import 'package:mips/presentation/bloc/annonce_bloc.dart';
import 'package:mips/presentation/bloc/app_bloc.dart';
import 'package:mips/presentation/bloc/follow_bloc.dart';
import 'package:mips/presentation/bloc/menu_screen_bloc.dart';
import 'package:mips/presentation/screens/avatar_faka/achat_avatar_finalisation_screen.dart';
import 'package:mips/presentation/screens/avatar_faka/bloc/avatar_bloc.dart';
import 'package:mips/presentation/screens/choose_lang/choose_lang_screen.dart';
import 'package:mips/presentation/screens/avis/avis_detail_screen.dart';
import 'package:mips/presentation/screens/delete_account/delete_account_screen.dart';
import 'package:mips/presentation/screens/detail/detail_global_screen.dart';
import 'package:mips/presentation/screens/exchange_rate/exchange_rate_screen.dart';
import 'package:mips/presentation/screens/followers/followers_screen.dart';
import 'package:mips/presentation/screens/kara_partner/bloc/kara_partner_bloc.dart';
import 'package:mips/presentation/screens/kara_partner/kara_partner_screen.dart';
import 'package:mips/presentation/screens/kara_partner/kara_subscription_screen.dart';
import 'package:mips/presentation/screens/list/list_global_content.dart';
import 'package:mips/presentation/screens/kara_partner/kara_list_screen.dart';
import 'package:mips/presentation/screens/maha_partenaire/maha_partenaire_screen.dart';
import 'package:mips/presentation/screens/base/base_screen.dart';
import 'package:mips/presentation/screens/change_password/change_password_screen.dart';
import 'package:mips/presentation/screens/demande_pub/demande_pub_screen.dart';
import 'package:mips/presentation/screens/detail/detail_screen.dart';
import 'package:mips/presentation/screens/login/login_screen.dart';
import 'package:mips/presentation/screens/menu/menu_screen.dart';
import 'package:mips/presentation/screens/mes_annonces/mes_annonces_screen.dart';
import 'package:mips/presentation/screens/modify_user_info/modify_user_info_screen.dart';
import 'package:mips/presentation/screens/mips_info/mips_info_screen.dart';
import 'package:mips/presentation/screens/my_menu_profil/bloc/my_menu_profil_bloc.dart';
import 'package:mips/presentation/screens/my_wallet/my_wallet_screen.dart';
import 'package:mips/presentation/screens/my_wallet/todays_rewards_screen.dart';
import 'package:mips/presentation/screens/password_guard/password_guard_screen.dart';
import 'package:mips/presentation/screens/profil/profil_screen.dart';
import 'package:mips/presentation/screens/register/register_screen.dart';
import 'package:mips/presentation/screens/resetpassword/reset_password_screen.dart';
import 'package:mips/presentation/screens/about/about_screen.dart';
import 'package:mips/presentation/screens/settings/setttings_screen.dart';
import 'package:mips/presentation/widgets/empty_list_widget.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../domain/entities/menu.dart';
import '../screens/avatar_faka/achat_avatar_screen.dart';
import '../screens/avatar_faka/historique_faka_screen.dart';
import '../screens/avis/avis_list_screen.dart';
import '../screens/demande_pub/demande_plaintes_screen.dart';
import '../screens/demande_pub/demande_pub_partenaire_screen.dart';
import '../screens/list/list_screen.dart';
import '../screens/main_screen/main_screen.dart';
import '../screens/messages/messages_screen.dart';
import '../screens/my_menu_profil/my_menu_profil_screen.dart';
import '../screens/avatar_faka/transfert_faka_screen.dart';
import '../screens/my_menu_profil/view_saved_annonce_menu_screen.dart';
import '../screens/sondage/sondage_list_screen.dart';

abstract class RoutesNames {
  static String home = "/home";
  static String portal = "/portal";
  static String list = "/list";
  static String karaList = "/karaList";
  static String mipsInfo = "/mipsInfo";
  static String globalSearch = "/globalSearch";
  static String appSettings = "/appSettings";
  static String mahaPartenaireList = "/mahaPartenaireList";
  static String demandePubPartenaire = "/demandePubPartenaire";
  static String appAbout = "/apropos";
  static String menu = "/menu";
  static String passwordGuard = "/passwordGuard";
  static String menuProfile = "/menuProfile";
  static String mesAnnonces = "/mesAnnonces";
  static String myMenuDetail = "/menu/mymenu/detail";
  static String detail = "/detail";
  static String profilDetail = "/profilDetail";
  static String detailGlobal = "/detailGlobal";
  static String login = "/login";
  static String deleteAccount = "/deleteAccount";
  static String message = "/message";
  static String achatAvatar = "/achatAvatar";
  static String achatAvatarFinalisation = "/achatAvatarFinalisation";
  static String messageDetail = "/messageDetail";
  static String avis = "/avis";
  static String avisDetail = "/avisDetail";
  static String transfertFaka = "/transfertFaka";
  static String empty = "/empty";
  static String demandePub = "/demandePub";
  static String changeUserInfo = "/changeUserInfo";
  static String followers = "/followers";
  static String myWallet = "/myWallet";
  static String rewards = "/rewards";
  static String exchangeRate = "/exchangeRate";
  static String register = "/register";
  static String resetPassword = "/resetPassword";
  static String changePassword = "/changePassword";
  static String viewImage = "/viewImage";
  static String chooseLang = "/chooseLang";
  static String sondageList = "/sondageList";
  static String karaPartner = "/karaPartner";
  static String karaSubscription = "/karaSubscription";
  static String demandePlainte = "/demandePlainte";
  static String historiqueFaka = "/historiqueFaka";
}

final _parentKey = GlobalKey<NavigatorState>();
final _shellKey = GlobalKey<NavigatorState>();

abstract class AppRoute {
  static final GoRouter router = GoRouter(
    navigatorKey: _parentKey,
    observers: [BotToastNavigatorObserver()],
    redirect: (context, state) {
      // final appLinks = AppLinks(); // AppLinks is singleton

      // // Subscribe to all events (initial link and further)
      // appLinks.uriLinkStream.listen((uri) {
      //   // Do something (navigation, ...)
      //   print("DEEP LINK: $uri");
      //   if (context.mounted) {
      //     AppRouter.go(
      //       context,
      //       RoutesNames.profilDetail,
      //       queryParameters: {"authorID": "26"},
      //     );
      //   }
      // });
      final userState = context.read<AppBloc>().state;
      final isAuthenticated = userState.isLogged;

      if (getIt<UserPrefRepositoryImpl>().getIsFirstTime() &&
          !((state.fullPath?.startsWith(RoutesNames.chooseLang)) ?? true)) {
        return RoutesNames.chooseLang;
      }

      final isMyMenuDetail =
          (state.fullPath?.startsWith(RoutesNames.myMenuDetail)) ?? false;
      final isMenuProfile =
          (state.fullPath?.startsWith(RoutesNames.menuProfile)) ?? false;

      /// Si l'utilisateur consulte des pages qui ont besoin d'authentification
      /// on redirige vers Login
      if (!isAuthenticated && (isMyMenuDetail || isMenuProfile)) {
        return RoutesNames.login;
      }
      return null;
    },
    initialLocation: '/',
    // initialLocation: RoutesNames.home,
    routes: [
      ShellRoute(
        navigatorKey: _shellKey,
        builder: (context, state, child) {
          return MainScreen(child: child); // Wrap all screens inside MainScreen
        },
        routes: [
          GoRoute(
            name: RoutesNames.home,
            path: '/',
            builder: (BuildContext context, GoRouterState state) {
              return MenuScreen(
                // screenId: "0000",
                // pageName: "Mahafaka",
                // getScreenByIDRouteUseCase:
                // GetIt.instance<GetScreenByIDRouteUseCase>(),
              );
            },
            routes: [
              GoRoute(
                parentNavigatorKey: _parentKey,
                name: RoutesNames.chooseLang,
                path: RoutesNames.chooseLang,
                builder: (BuildContext context, GoRouterState state) {
                  return const ChooseLangScreen();
                },
              ),
            ],
          ),
          // GoRoute(
          //   // parentNavigatorKey: _parentKey,
          //   name: RoutesNames.chooseLang,
          //   path: RoutesNames.chooseLang,
          //   builder: (BuildContext context, GoRouterState state) {
          //     return const ChooseLangScreen();
          //   },
          // ),
          GoRoute(
            name: RoutesNames.menu,
            path: RoutesNames.menu,
            builder: (BuildContext context, GoRouterState state) {
              return MenuScreen(
                // screenId: state.uri.queryParameters['id'] ?? "0000",
                // pageName: state.uri.queryParameters['name'] ?? "Mahafaka",
                // getScreenByIDRouteUseCase:
                //     GetIt.instance<GetScreenByIDRouteUseCase>(),
              );
            },
          ),
          GoRoute(
            name: RoutesNames.menuProfile,
            path: RoutesNames.menuProfile,
            builder: (BuildContext context, GoRouterState state) {
              return const MyMenuProfilScreen();
            },
          ),
          GoRoute(
            name: RoutesNames.profilDetail,
            path: RoutesNames.profilDetail,
            builder: (BuildContext context, GoRouterState state) {
              int authorID = int.parse(
                state.uri.queryParameters["authorID"] ?? "0",
              );
              print("AUTHOR ID : ${authorID}");
              return BlocProvider(
                create: (context) =>
                    GetIt.instance<MenuScreenBloc>()
                      ..add(LoadMenuScreenEvent(id: "0")),
                child: BlocProvider(
                  create: (context) {
                    if (context.read<AppBloc>().state.isLogged) {
                      return GetIt.instance<FollowBloc>()
                        ..add(CheckFollowingEvent(id: authorID))
                        ..add(FollowersLoadedEvent())
                        ..add(FollowingLoadedEvent());
                    }
                    return GetIt.instance<FollowBloc>();
                  },
                  child:
                      // BlocBuilder<FollowBloc, FollowState>(
                      //   builder: (context, state) {
                      // return
                      ProfilScreen(
                        authorID: authorID,
                        // isFollowing: state.isFollowing,
                      ),
                  // },
                  // ),
                ),
              );
            },
          ),
          GoRoute(
            name: RoutesNames.myWallet,
            path: RoutesNames.myWallet,
            builder: (BuildContext context, GoRouterState state) {
              return const MyWalletScreen();
            },
          ),
          GoRoute(
            name: RoutesNames.followers,
            path: RoutesNames.followers,
            builder: (BuildContext context, GoRouterState state) {
              return const FollowersScreen();
            },
          ),
          GoRoute(
            name: RoutesNames.rewards,
            path: RoutesNames.rewards,
            builder: (BuildContext context, GoRouterState state) {
              return TodaysRewardsScreen(
                solde: int.parse(state.uri.queryParameters["solde"] ?? "0"),
              );
            },
          ),
          GoRoute(
            name: RoutesNames.exchangeRate,
            path: RoutesNames.exchangeRate,
            builder: (BuildContext context, GoRouterState state) {
              return const ExchangeRateScreen();
            },
          ),
          GoRoute(
            name: RoutesNames.deleteAccount,
            path: RoutesNames.deleteAccount,
            builder: (BuildContext context, GoRouterState state) {
              return const DeleteAccountScreen();
            },
          ),
          GoRoute(
            name: RoutesNames.achatAvatar,
            path: RoutesNames.achatAvatar,
            builder: (BuildContext context, GoRouterState state) {
              return const AchatAvatarScreen();
            },
          ),
          GoRoute(
            name: RoutesNames.changeUserInfo,
            path: RoutesNames.changeUserInfo,
            builder: (BuildContext context, GoRouterState state) {
              return const ModifyUserInfoScreen();
            },
          ),
          GoRoute(
            name: RoutesNames.message,
            path: RoutesNames.message,
            builder: (BuildContext context, GoRouterState state) {
              return const MessagesScreen();
            },
          ),
          GoRoute(
            name: RoutesNames.achatAvatarFinalisation,
            path: RoutesNames.achatAvatarFinalisation,
            builder: (BuildContext context, GoRouterState state) {
              return BlocProvider.value(
                value: (state.extra as AvatarBloc),
                child: const AchatAvatarFinalisationScreen(),
              );
            },
          ),
          GoRoute(
            name: RoutesNames.karaPartner,
            path: RoutesNames.karaPartner,
            builder: (BuildContext context, GoRouterState state) {
              return KaraPartnerScreen(
                title: state.uri.queryParameters['title'] ?? "Partenaires KARA",
              );
            },
          ),
          GoRoute(
            name: RoutesNames.karaSubscription,
            path: RoutesNames.karaSubscription,
            builder: (BuildContext context, GoRouterState state) {
              return BlocProvider(
                create: (context) =>
                    GetIt.instance<KaraPartnerBloc>()
                      ..add(KaraProvinceLoaded()),
                child: KaraSubscriptionScreen(),
              );
            },
          ),
          GoRoute(
            name: RoutesNames.avis,
            path: RoutesNames.avis,
            builder: (BuildContext context, GoRouterState state) {
              return AvisListScreen(
                title: state.uri.queryParameters['title'] ?? "MIPS",
              );
            },
          ),
          GoRoute(
            name: RoutesNames.avisDetail,
            path: RoutesNames.avisDetail,
            builder: (BuildContext context, GoRouterState state) {
              return AvisDetailScreen(
                // title: state.uri.queryParameters['title'] ?? "Mahafaka",
                title: state.uri.queryParameters['title'] ?? "MIPS",
                id: state.uri.queryParameters['id'] ?? "0",
                pageUrl: state.uri.queryParameters['pageUrl'] ?? "0",
              );
            },
          ),
          GoRoute(
            name: RoutesNames.passwordGuard,
            path: RoutesNames.passwordGuard,
            builder: (BuildContext context, GoRouterState state) {
              if (state.extra != null && state.extra is String) {
                return PasswordGuardScreen(nextRoute: state.extra as String);
              } else {
                return PasswordGuardScreen(nextRoute: RoutesNames.home);
              }
            },
          ),
          GoRoute(
            name: RoutesNames.list,
            path: RoutesNames.list,
            builder: (BuildContext context, GoRouterState state) {
              return ListScreen(initialMenuInfoScreen: state.extra as Menu);
            },
          ),
          GoRoute(
            name: RoutesNames.karaList,
            path: RoutesNames.karaList,
            builder: (BuildContext context, GoRouterState state) {
              return KaraListScreen(
                initialMenuInfoScreen: state.extra as Menu,
                province: state.uri.queryParameters["province"] ?? "",
              );
            },
          ),
          GoRoute(
            name: RoutesNames.globalSearch,
            path: RoutesNames.globalSearch,
            builder: (BuildContext context, GoRouterState state) {
              final onSearch = state.uri.queryParameters["onSearch"];
              return ListGlobalContent(
                onSearch: onSearch == "true" ? true : false,
                initialMenuInfoScreen: state.extra as Menu,
              );
              // return GlobalSearchScreen(onSearch: true);
            },
          ),
          GoRoute(
            name: RoutesNames.transfertFaka,
            path: RoutesNames.transfertFaka,
            builder: (BuildContext context, GoRouterState state) {
              return TransfertFakaScreen();
            },
          ),
          GoRoute(
            name: RoutesNames.changePassword,
            path: RoutesNames.changePassword,
            builder: (BuildContext context, GoRouterState state) {
              return const ChangePasswordScreen();
            },
          ),
          GoRoute(
            name: RoutesNames.historiqueFaka,
            path: RoutesNames.historiqueFaka,
            builder: (BuildContext context, GoRouterState state) {
              return const HistoriqueFakaScreen();
            },
          ),
          GoRoute(
            name: RoutesNames.sondageList,
            path: RoutesNames.sondageList,
            builder: (BuildContext context, GoRouterState state) {
              return SondageListScreen(
                title: state.uri.queryParameters['title'] ?? "MIPS",
              );
            },
          ),
          GoRoute(
            name: RoutesNames.mipsInfo,
            path: RoutesNames.mipsInfo,
            builder: (BuildContext context, GoRouterState state) {
              return MipsInfoScreen(
                title: state.uri.queryParameters['title'] ?? "MIPS",
              );
            },
          ),
          GoRoute(
            name: RoutesNames.empty,
            path: RoutesNames.empty,
            builder: (BuildContext context, GoRouterState state) {
              return const BaseScreen(
                // title: Text("Mahafaka"),
                title: Text("MIPS"),
                content: Center(
                  child: EmptyListWidget(listType: ListType.availableSoon),
                ),
              );
            },
          ),
          GoRoute(
            name: RoutesNames.myMenuDetail,
            path: RoutesNames.myMenuDetail,
            builder: (BuildContext context, GoRouterState state) {
              if (state.extra != null) {
                return BlocProvider.value(
                  value: (state.extra! as MyMenuProfilBloc)
                    ..add(LoadAnnoncesFavorisCount()),
                  child: BlocProvider(
                    create: (context) => GetIt.instance<AnnonceBloc>(),
                    child: BlocProvider(
                      create: (context) =>
                          GetIt.instance<FollowBloc>()
                            ..add(LoadAnnonceListFollow(pageIndex: 1)),
                      child: ViewSavedAnnonceMenuScreen(
                        isAnnonceFavsScreen: bool.parse(
                          state.uri.queryParameters['isAnnonceMode'] ?? "true",
                        ),
                        title: state.uri.queryParameters['name'] ?? "",
                      ),
                    ),
                  ),
                );
              } else {
                return BlocProvider(
                  create: (context) => GetIt.instance<AnnonceBloc>(),
                  child: BlocProvider(
                    create: (context) =>
                        GetIt.instance<MyMenuProfilBloc>()
                          ..add(LoadAnnoncesFavorisCount()),
                    child: BlocProvider(
                      create: (context) =>
                          GetIt.instance<FollowBloc>()
                            ..add(LoadAnnonceListFollow(pageIndex: 1)),
                      child: ViewSavedAnnonceMenuScreen(
                        isAnnonceFavsScreen: bool.parse(
                          state.uri.queryParameters['isAnnonceMode'] ?? "true",
                        ),
                        title: state.uri.queryParameters['name'] ?? "",
                      ),
                    ),
                  ),
                );
              }
            },
          ),
          GoRoute(
            name: RoutesNames.mesAnnonces,
            path: RoutesNames.mesAnnonces,
            builder: (BuildContext context, GoRouterState state) {
              return const MesAnnoncesScreen();
            },
          ),

          /// Place those routes outside the shell if no need navigationBar
          GoRoute(
            name: RoutesNames.resetPassword,
            path: RoutesNames.resetPassword,
            builder: (BuildContext context, GoRouterState state) {
              return const ResetPasswordScreen();
            },
          ),
          GoRoute(
            name: RoutesNames.appSettings,
            path: RoutesNames.appSettings,
            builder: (BuildContext context, GoRouterState state) {
              return SettingsScreen(
                langInitial: context
                    .read<AppBloc>()
                    .userPrefRepositoryImpl
                    .getLang(),
              );
            },
            routes: [
              GoRoute(
                name: RoutesNames.appAbout,
                path: RoutesNames.appAbout,
                builder: (BuildContext context, GoRouterState state) {
                  return const AboutScreen();
                },
              ),
            ],
          ),

          GoRoute(
            name: RoutesNames.detail,
            path: RoutesNames.detail,
            builder: (BuildContext context, GoRouterState state) {
              print("EXTRA GLOBAL : ${state.extra}");
              if (state.extra != null) {
                return BlocProvider.value(
                  value: (state.extra! as AnnonceBloc),
                  child: DetailScreen(
                    idRoute: state.uri.queryParameters['id'] ?? "0",
                    title: state.uri.queryParameters['name'] ?? "",
                  ),
                );
              } else {
                return DetailScreen(
                  idRoute: state.uri.queryParameters['id'] ?? "0",
                  title: state.uri.queryParameters['name'] ?? "",
                );
              }
            },
          ),
          GoRoute(
            name: RoutesNames.detailGlobal,
            path: RoutesNames.detailGlobal,
            builder: (BuildContext context, GoRouterState state) {
              print("EXTRA GLOBAL : ${state.extra}");
              if (state.extra != null) {
                return BlocProvider.value(
                  value: (state.extra! as AnnonceBloc),
                  child: DetailGlobalScreen(
                    idRoute: state.uri.queryParameters['id'] ?? "0",
                    title: state.uri.queryParameters['name'] ?? "",
                  ),
                );
              } else {
                return DetailGlobalScreen(
                  idRoute: state.uri.queryParameters['id'] ?? "0",
                  title: state.uri.queryParameters['name'] ?? "",
                );
              }
            },
          ),
          GoRoute(
            name: RoutesNames.login,
            path: RoutesNames.login,
            builder: (BuildContext context, GoRouterState state) {
              return const LoginScreen();
            },
          ),
          GoRoute(
            name: RoutesNames.register,
            path: RoutesNames.register,
            builder: (BuildContext context, GoRouterState state) {
              return const RegisterScreen();
            },
          ),
          GoRoute(
            name: RoutesNames.mahaPartenaireList,
            path: RoutesNames.mahaPartenaireList,
            builder: (BuildContext context, GoRouterState state) {
              return const MahaPartenaireScreen();
            },
          ),
          GoRoute(
            name: RoutesNames.demandePub,
            path: RoutesNames.demandePub,
            builder: (BuildContext context, GoRouterState state) {
              if (state.extra != null) {
                return BlocProvider.value(
                  value: state.extra! as AnnonceBloc,
                  child: DemandePubScreen(
                    idMenu: state.uri.queryParameters['idMenu'] ?? "0",
                    menuParentRef:
                        state.uri.queryParameters['menuParentRef'] ?? "",
                    title: state.uri.queryParameters['title'] ?? "",
                    idAnnonce: state.uri.queryParameters['idAnnonce'] ?? "0",
                    isTarifVIPOnlyMode: bool.parse(
                      state.uri.queryParameters['modeVIPOnly'] ?? "false",
                    ),
                    isFreeAnnonceMode: bool.parse(
                      state.uri.queryParameters['isFreeMode'] ?? "false",
                    ),
                    isExtendValidityMode: bool.parse(
                      state.uri.queryParameters['isExtendValidityMode'] ??
                          "false",
                    ),
                  ),
                );
              } else {
                return DemandePubScreen(
                  idMenu: state.uri.queryParameters['idMenu'] ?? "0",
                  menuParentRef:
                      state.uri.queryParameters['menuParentRef'] ?? "",
                  title: state.uri.queryParameters['title'] ?? "",
                  idAnnonce: state.uri.queryParameters['idAnnonce'] ?? "0",
                  isTarifVIPOnlyMode: bool.parse(
                    state.uri.queryParameters['modeVIPOnly'] ?? "false",
                  ),
                  isFreeAnnonceMode: bool.parse(
                    state.uri.queryParameters['isFreeMode'] ?? "false",
                  ),
                  isExtendValidityMode: bool.parse(
                    state.uri.queryParameters['isExtendValidityMode'] ??
                        "false",
                  ),
                );
              }
            },
          ),
          GoRoute(
            name: RoutesNames.demandePubPartenaire,
            path: RoutesNames.demandePubPartenaire,
            builder: (BuildContext context, GoRouterState state) {
              if (state.extra != null) {
                return BlocProvider.value(
                  value: state.extra! as AnnonceBloc,
                  child: DemandePubPartenaireScreen(
                    idMenu: state.uri.queryParameters['idMenu'] ?? "0",
                    title: state.uri.queryParameters['title'] ?? "",
                    annonceType: state.uri.queryParameters['type'] ?? "",
                  ),
                );
              } else {
                return DemandePubPartenaireScreen(
                  idMenu: state.uri.queryParameters['idMenu'] ?? "0",
                  title: state.uri.queryParameters['title'] ?? "",
                  annonceType: state.uri.queryParameters['type'] ?? "",
                );
              }
            },
          ),
          GoRoute(
            name: RoutesNames.demandePlainte,
            path: RoutesNames.demandePlainte,
            builder: (BuildContext context, GoRouterState state) {
              if (state.extra != null) {
                return BlocProvider.value(
                  value: state.extra! as AnnonceBloc,
                  child: DemandePlaintesScreen(
                    idMenu: state.uri.queryParameters['idMenu'] ?? "0",
                    title: state.uri.queryParameters['title'] ?? "",
                  ),
                );
              } else {
                return DemandePlaintesScreen(
                  idMenu: state.uri.queryParameters['idMenu'] ?? "0",
                  title: state.uri.queryParameters['title'] ?? "",
                );
              }
            },
          ),
        ],
      ),
    ],
  );
}
