import 'package:mips/presentation/configurations/colors_list.dart';
import 'package:mips/presentation/configurations/extension_for_localization.dart';
import 'package:mips/presentation/routes/route.dart';
import 'package:mips/presentation/routes/router.dart';
import 'package:mips/presentation/screens/my_menu_profil/bloc/my_menu_profil_bloc.dart';
import 'package:mips/presentation/widgets/message_displayer_utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../bloc/app_bloc.dart';

class MainScreen extends StatelessWidget {
  final Widget child;

  const MainScreen({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    int seletedIndex = _getSelectedIndex(context);
    int sizeOfBottomNavElement = 4;
    if (GoRouterState.of(context).uri.toString().startsWith(RoutesNames.list)) {
      sizeOfBottomNavElement = sizeOfBottomNavElement + 1;
      if (seletedIndex > 2) {
        seletedIndex = seletedIndex + 1;
      }
    }
    return BlocConsumer<AppBloc, AppState>(
      listener: (context, state) {
        if (state.popupAnnonceStatus == PopupAnnonceStatus.loaded &&
            context.read<AppBloc>().popUpAnnonce != null) {
          /// Vérifie si c’est le premier utilisateur (langue à choisir)
          if (!context
              .read<AppBloc>()
              .userPrefRepositoryImpl
              .getIsFirstTime()) {
            MessageDisplayerUtils.showPopupAnnonce(
              context,
              context.read<AppBloc>().popUpAnnonce!,
            );
          }
        }
      },
      listenWhen: (previous, current) =>
          previous.popupAnnonceStatus != current.popupAnnonceStatus,
      builder: (context, state) {
        return Scaffold(
          body: child,
          bottomNavigationBar: NavigationBar(
            labelPadding: EdgeInsets.zero,
            labelTextStyle: WidgetStateProperty.resolveWith<TextStyle?>((
              Set<WidgetState> states,
            ) {
              if (states.contains(WidgetState.selected)) {
                return const TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                  // color: tertiaryColor,
                  fontSize: 14,
                  overflow: TextOverflow.ellipsis,
                );
              }
              return const TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.black,
                // color: tertiaryColor,
                overflow: TextOverflow.ellipsis,
                fontSize: 14,
              );
            }),
            height: kToolbarHeight,
            onDestinationSelected: (int index) {
              context.read<AppBloc>().add(
                SetAnnonceSponsorPartenaireNavEvent(
                  annoncesPartenaire: null,
                  annoncesSponsor: null,
                ),
              );

              if (index != seletedIndex || index == 0) {
                if (index == sizeOfBottomNavElement - 1) {
                  AppRouter.goPushNamedAndRemoveUntil(
                    context,
                    RoutesNames.menuProfile,
                  );
                } else if (index == 1) {
                  if (state.isLogged) {
                    AppRouter.goPushNamedAndRemoveUntil(
                      context,
                      RoutesNames.myMenuDetail,
                      queryParameters: {
                        "isAnnonceMode": "true",
                        "name": context.appLoc.announce_favs,
                      },
                      extra: GetIt.instance<MyMenuProfilBloc>()
                        // ..add(LoadUserMenuProfilEvent())
                        ..add(LoadAnnoncesFavoris(pageIndex: 1)),
                    );
                  } else {
                    MessageDisplayerUtils.showAuthRequiredDialog(
                      context,
                      GoRouterState.of(
                        context,
                      ).uri.toString().startsWith(RoutesNames.login),
                    );
                  }
                } else if (index == 0) {
                  context.read<AppBloc>().add(GetUnreadMessageCountEvent());
                  AppRouter.goPushNamedAndRemoveUntil(
                    context,
                    RoutesNames.menu,
                    queryParameters: {
                      "id": "0000",
                      "name": context.appLoc.app_name,
                    },
                  );
                } else if (index == sizeOfBottomNavElement - 2) {
                  if (state.isLogged) {
                    AppRouter.goPushNamedAndRemoveUntil(
                      context,
                      RoutesNames.mesAnnonces,
                    );
                  } else {
                    MessageDisplayerUtils.showAuthRequiredDialog(
                      context,
                      GoRouterState.of(
                        context,
                      ).uri.toString().startsWith(RoutesNames.login),
                    );
                  }
                }
              }
            },
            indicatorColor: Colors.transparent,
            selectedIndex: seletedIndex,
            destinations: <Widget>[
              NavigationDestination(
                icon: const Icon(
                  Icons.home_outlined,
                  // Symbols.home_rounded,
                  color: Colors.black,
                  // color: tertiaryColor,
                  size: 24,
                ),
                label: context.appLoc.home,
                selectedIcon: const Icon(
                  Icons.home,
                  // Symbols.home_rounded,
                  fill: 1,
                  color: Colors.black,
                  size: 24,
                ),
              ),
              NavigationDestination(
                icon: const Icon(
                  size: 26,
                  Icons.favorite_outline,
                  color: Colors.black,
                  // color: tertiaryColor,
                ),
                label: context.appLoc.favorite,
                selectedIcon: const Icon(
                  // Symbols.favorite_rounded,
                  Icons.favorite,
                  color: Colors.black,
                  size: 26,
                ),
              ),
              if (GoRouterState.of(
                context,
              ).uri.toString().startsWith(RoutesNames.list))
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // ElevatedButton(
                    //   style: ButtonStyle(
                    //       shape: WidgetStatePropertyAll(CircleBorder())),
                    //   onPressed: () {
                    //     if (state.isLogged) {
                    //       AppRouter.go(context, RoutesNames.demandePub,
                    //           queryParameters: {
                    //             "menuParentRef": state
                    //                 .selectedMenuCategoriesNavigation.reference,
                    //             "idMenu": state
                    //                 .selectedMenuCategoriesNavigation.id
                    //                 .toString(),
                    //             "title":
                    //                 state.selectedMenuCategoriesNavigation.name,
                    //             "idAnnonce": "0",
                    //             "isFreeMode": (state
                    //                     .selectedMenuCategoriesNavigation
                    //                     .isFree)
                    //                 .toString(),
                    //           },
                    //           extra: context.read<AppBloc>().annonceBloc);
                    //     } else {
                    //       MessageDisplayerUtils.showAuthRequiredDialog(
                    //           context,
                    //           GoRouterState.of(context)
                    //               .uri
                    //               .toString()
                    //               .startsWith(RoutesNames.login));
                    //     }
                    //   },
                    //   child: const Icon(Ionicons.add, color: Colors.white),
                    // )
                    IconButton.filled(
                      style: IconButton.styleFrom(
                        elevation: 2,
                        shape: CircleBorder(),
                        overlayColor: Colors.purple,
                        shadowColor: Colors.black,
                      ),
                      onPressed: () {
                        if (state.isLogged) {
                          AppRouter.go(
                            context,
                            RoutesNames.demandePub,
                            queryParameters: {
                              "menuParentRef": state
                                  .selectedMenuCategoriesNavigation
                                  .reference,
                              "idMenu": state
                                  .selectedMenuCategoriesNavigation
                                  .id
                                  .toString(),
                              "title":
                                  state.selectedMenuCategoriesNavigation.name,
                              "idAnnonce": "0",
                              "isFreeMode":
                                  (state
                                          .selectedMenuCategoriesNavigation
                                          .isFree)
                                      .toString(),
                            },
                            extra: context.read<AppBloc>().annonceBloc,
                          );
                        } else {
                          MessageDisplayerUtils.showAuthRequiredDialog(
                            context,
                            GoRouterState.of(
                              context,
                            ).uri.toString().startsWith(RoutesNames.login),
                          );
                        }
                      },
                      icon: const Icon(Icons.add, color: Colors.white),
                    ),
                  ],
                ),
              NavigationDestination(
                icon: const Icon(
                  Icons.book_outlined,
                  // Symbols.book_rounded,
                  color: Colors.black,
                  // color: tertiaryColor,
                  size: 24,
                ),
                label: context.appLoc.my_ads,
                selectedIcon: const Icon(
                  Icons.book,
                  // Symbols.book_rounded,
                  fill: 1,
                  color: Colors.black,
                  size: 24,
                ),
              ),
              NavigationDestination(
                icon: state.isLogged
                    ? Container(
                        width: 26, // diameter = radius * 2
                        height: 26,
                        decoration: seletedIndex == 3
                            ? BoxDecoration(
                                shape: BoxShape.circle,
                                // color: Colors.black,
                                border: Border.all(
                                  color: tertiaryColor, // border color
                                  // width: 2.0, // border thickness
                                ),
                              )
                            : null,
                        child: CircleAvatar(
                          // radius: 60,
                          backgroundColor: Colors.white,
                          foregroundImage: CachedNetworkImageProvider(
                            context.read<AppBloc>().state.user!.avatarUrl,
                          ),
                        ),
                      )
                    : const Icon(
                        Icons.person_outline,
                        // Symbols.person_filled_rounded,
                        color: Colors.black,
                        size: 24,
                        // color: tertiaryColor,
                      ),
                // label: context.appLoc.profil,
                label: context.appLoc.account,
                selectedIcon: state.isLogged
                    ? null
                    : const Icon(
                        Icons.person,
                        // Symbols.person_filled_rounded,
                        fill: 1,
                        color: Colors.black,
                        size: 24,
                      ),
              ),
            ],
          ),
        );
      },
    );
  }

  int _getSelectedIndex(BuildContext context) {
    final String location = GoRouterState.of(context).uri.toString();

    if (location.startsWith(RoutesNames.menuProfile)) {
      return 3;
    } else if (location.startsWith(RoutesNames.login)) {
      return 3;
    } else if (location.startsWith(RoutesNames.mesAnnonces)) {
      return 2;
    } else if (location.startsWith(RoutesNames.myMenuDetail)) {
      return 1;
    }
    return 0; // Default to Home
  }
}
