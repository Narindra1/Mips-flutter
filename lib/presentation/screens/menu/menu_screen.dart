import 'dart:math';

import 'package:MIPS/common/constants/constant.dart';
import 'package:MIPS/common/utils/app_utils.dart';
import 'package:MIPS/common/utils/globals.dart';
import 'package:MIPS/domain/entities/menu.dart';
import 'package:MIPS/presentation/bloc/menu_screen_bloc.dart';
import 'package:MIPS/presentation/configurations/colors_list.dart';
import 'package:MIPS/presentation/configurations/extension_for_localization.dart';
import 'package:MIPS/presentation/presentation.dart';
import 'package:MIPS/presentation/routes/route.dart';
import 'package:MIPS/presentation/routes/router.dart';
import 'package:MIPS/presentation/screens/base/base_content_item.dart';
import 'package:MIPS/presentation/screens/base/base_screen.dart';
import 'package:MIPS/presentation/screens/base/menu_item.dart';
import 'package:MIPS/presentation/screens/list/list_global_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:ionicons/ionicons.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  late final MenuScreenBloc _menuBloc;
  List<MenuItem> _menuItems = [];
  int _screenId = 0;
  // int _menuMainIndex = 0;
  int _selectedIndex = -1;
  String _langueDoesChange = "";
  String _actualLangue = "";

  @override
  void initState() {
    _menuBloc = GetIt.instance<MenuScreenBloc>()
      ..add(LoadMenuScreenEvent(id: "0"));
    menuRefColor.clear();
    super.initState();
  }

  @override
  void dispose() {
    _menuBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _menuBloc,
      child: BlocConsumer<AppBloc, AppState>(
        // listener: (context, state) {
        //   if (state.lang.toString() !=
        //       context.read<MenuScreenBloc>().state.lang) {
        //     context
        //         .read<MenuScreenBloc>()
        //         .add(MenuLangChangeEvent(lang: state.lang.toString()));
        //   }
        // },
        listener: (context, state) {
          if (state.lang.toString() != _menuBloc.state.lang) {
            _menuBloc.add(MenuLangChangeEvent(lang: state.lang.toString()));
          }
        },
        builder: (context, state) {
          _actualLangue = state.lang.toString();
          return MultiBlocListener(
            listeners: [
              BlocListener<MenuScreenBloc, MenuScreenState>(
                listenWhen: (previous, current) =>
                    (_screenId != 0) && (_langueDoesChange != _actualLangue),
                listener: (context, state) {
                  setState(() {
                    _menuBloc.add(LoadMenuScreenEvent(id: "0"));
                    _screenId = 0;
                    // _menuMainIndex = 0;
                    _selectedIndex = -1;
                  });
                },
              ),
              BlocListener<MenuScreenBloc, MenuScreenState>(
                listenWhen: (previous, current) {
                  return (previous.screenEntity != current.screenEntity &&
                      _screenId == 0 &&
                      current.screenEntity != null);
                },
                listener: (context, state) {
                  setState(() {
                    _langueDoesChange = _actualLangue;
                    _menuItems = state.screenEntity?.menusChildList ?? [];
                  });
                },
              ),
              BlocListener<MenuScreenBloc, MenuScreenState>(
                listenWhen: (previous, current) =>
                    previous.screenEntity != null &&
                    current.screenEntity != null &&
                    ((previous.screenEntity != current.screenEntity ||
                        previous.screenEntity != current.screenEntity)),
                listener: (context, state) {
                  if (state.screenEntity != null) {
                    if (_screenId == 0) {
                      context.read<AppBloc>().add(SetSponsAndPartenerEvent(
                          annonceSponsor: state.screenEntity?.annonceSponsor,
                          annoncePartenaire:
                              state.screenEntity?.annoncePartner));
                    } else {
                      context.read<AppBloc>().add(
                          SetAnnonceSponsorPartenaireNavEvent(
                              annoncesPartenaire:
                                  state.screenEntity?.annoncePartner,
                              annoncesSponsor:
                                  state.screenEntity?.annonceSponsor));
                    }
                  }
                },
              ),
            ],
            child: BlocBuilder<MenuScreenBloc, MenuScreenState>(
              builder: (context, state) {
                List<MenuItem> subMenus = [];
                if (_screenId != 0) {
                  subMenus = state.screenEntity?.menusChildList ?? [];
                }

                return BaseScreen(
                  useDefaultAnnonceSponsPart: false,
                  annoncePartner: state.screenEntity!.annoncePartner,
                  annonceSponsor: state.screenEntity!.annonceSponsor,
                  backgroundColor: Colors.grey.shade200,
                  // backgroundColor: Colors.white,
                  content: state.status == Status.loading && _screenId == 0
                      ? AppLoadingWidget()
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Material(
                              elevation: 2,
                              shadowColor: Colors.white,
                              color: Colors.white,
                              child: _buildMenuMain(context, _menuItems),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 0.5),
                              decoration: BoxDecoration(
                                color: _screenId == 0
                                    ? Colors.white
                                    : Colors.transparent,
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(
                                    top: 8,
                                    left: 8,
                                    right: 8,
                                    bottom: _screenId == 0 ? 4 : 0),
                                child: _screenId == 0
                                    ? Row(
                                        children: [
                                          Text(
                                            context.appLoc.recents_announces,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      )
                                    : const SizedBox(),
                              ),
                            ),
                            _screenId == 0
                                ? Divider(
                                    color: Colors.grey.shade400,
                                    thickness: 0.1,
                                    height: 1.2,
                                    // indent: 8,
                                    // endIndent: 8,
                                  )
                                : const SizedBox(),
                            _screenId == 0
                                ? Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8),
                                      child: RefreshIndicator(
                                        onRefresh: () async {
                                          _menuBloc.add(
                                              LoadMenuScreenEvent(id: "0"));
                                        },
                                        child: ListGlobalContent(
                                          onSearch: false,
                                          initialMenuInfoScreen:
                                              state.screenEntity!,
                                        ),
                                      ),
                                    ),
                                  )
                                : Expanded(
                                    child: SingleChildScrollView(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 3),
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children:
                                              state.status == Status.loading
                                                  ? [AppLoadingWidget()]
                                                  : [
                                                      _buildMenuGroup(
                                                          context, subMenus)
                                                    ]
                                          // : [
                                          //     _menuItems.isEmpty
                                          //         ? const SizedBox()
                                          //         : Text(
                                          //             _menuItems[_menuMainIndex]
                                          //                 .name),
                                          //     ...List.generate(subMenus.length,
                                          //         (index) {
                                          //       return Text(
                                          //           "//${subMenus[index].subMenu.length}");
                                          //     }),
                                          //     // ...List.generate(menuCombined.length, (index) {
                                          //     //   return BaseContentItem(
                                          //     //     menuItem: menuCombined[index],
                                          //     //   );
                                          //     // }),
                                          //   ],
                                          ),
                                    ),
                                  ),
                          ],
                        ),
                  leading: GestureDetector(
                    onTap: () {
                      AppRouter.go(context, RoutesNames.appAbout);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Badge(
                        backgroundColor: tertiaryColor,
                        isLabelVisible:
                            context.read<AppBloc>().state.updateStatus ==
                                UpdateStatus.updateVersionAvailable,
                        label: const Icon(
                          // Icons.arrow_upward,
                          Ionicons.arrow_up,
                          // Symbols.arrow_upward,
                          color: Colors.white,
                          size: 10,
                        ),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(mediumPadding),
                            child: Image.asset("assets/imgs/ic_mahafaka.png")),
                      ),
                    ),
                  ),
                  appBarAction: [
                    // Utilisateur n'est pas connectée.
                    // if (!context.read<AppBloc>().state.isLogged)
                    //   OutlinedButton(
                    //     onPressed: () {
                    //       AppRouter.go(context, RoutesNames.login);
                    //     },
                    //     child: Text(context.appLoc.connexion),
                    //   ),
                    IconButton(
                      onPressed: () {
                        AppRouter.go(
                          context,
                          RoutesNames.globalSearch,
                          extra: Menu(
                            annoncePartner: null,
                            annonceSponsor: null,
                            id: 9,
                            title: "Maha Nouvelles",
                            reference: "AA",
                            isFree: true,
                            menusChildList: [],
                            isFavs: false,
                          ),
                          queryParameters: {"onSearch": "true"},
                        );
                      },
                      icon: const Icon(
                        // Icons.search,
                        Ionicons.search_outline,
                        color: Colors.black,
                        // color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    // if (!context.read<AppBloc>().state.isLogged)
                    //   IconButton(
                    //       onPressed: () {
                    //         // AppRouter.go(context, RoutesNames.login);
                    //         MessageDisplayerUtils.showAuthRequiredDialog(
                    //             context,
                    //             GoRouterState.of(context)
                    //                 .uri
                    //                 .toString()
                    //                 .startsWith(RoutesNames.login));
                    //       },
                    //       icon: Badge(
                    //           backgroundColor:
                    //               Theme.of(context).colorScheme.primary,
                    //           isLabelVisible: false,
                    //           child: const Icon(Icons.notifications_outlined))),
                    if (context.read<AppBloc>().state.isLogged)
                      IconButton(
                          onPressed: () {
                            AppRouter.go(context, RoutesNames.message);
                          },
                          icon: Badge(
                              isLabelVisible: context
                                      .read<AppBloc>()
                                      .state
                                      .unreadMessageCount >
                                  0,
                              label: Text((context
                                          .read<AppBloc>()
                                          .state
                                          .unreadMessageCount >
                                      99)
                                  ? "+99"
                                  : context
                                      .read<AppBloc>()
                                      .state
                                      .unreadMessageCount
                                      .toString()),
                              backgroundColor:
                                  Theme.of(context).colorScheme.primary,
                              child: const Icon(
                                Ionicons.notifications_outline,
                                // Icons.notifications_outlined,
                                color: Colors.black,
                                size: 24,
                              ))),
                    // Paramètres pour modifier les langues, tailles de polices, ...
                    IconButton(
                        onPressed: () {
                          AppRouter.go(context, RoutesNames.appSettings);
                        },
                        icon: const Icon(
                          Ionicons.settings_outline,
                          // Icons.settings_outlined,
                          color: Colors.black,
                        )),
                  ],
                  title: Row(
                    children: [
                      Text(
                        context.appLoc.app_name,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: tertiaryColor,
                            ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  void _navigateScreenRoute(
      BuildContext context, MenuItem menuItem, Menu? screenMenuInfo) {
    String routeNames;
    switch (menuItem.screenTypeRoute) {
      case MenuTypeRoute.list:
      case MenuTypeRoute.listBasic:
        routeNames = RoutesNames.list;
        break;
      case MenuTypeRoute.menuScroll:
      case MenuTypeRoute.menuNotScroll:
        routeNames = RoutesNames.menu;
        break;
      case MenuTypeRoute.MAHA_SONDAGE:
        routeNames = RoutesNames.sondageList;
        break;
      case MenuTypeRoute.EXCHANGE_RATE:
        routeNames = RoutesNames.exchangeRate;
        break;
      case MenuTypeRoute.MAHA_PARTENAIRE:
        routeNames = RoutesNames.mahaPartenaireList;
        break;
      case MenuTypeRoute.MAHA_PLAINTE_SUGGESTION:
        routeNames = RoutesNames.demandePlainte;
        break;
      case MenuTypeRoute.MAHA_AVIS:
        routeNames = RoutesNames.avis;
        break;
      case MenuTypeRoute.KARA_PARTNER:
        routeNames = RoutesNames.karaPartner;
        break;
      case MenuTypeRoute.MIPS_INFO:
        routeNames = RoutesNames.mipsInfo;
        break;
      default:
        routeNames = RoutesNames.empty;
    }
    if (menuItem.reference == "8200") {
      AppRouter.go(context, RoutesNames.demandePub,
          queryParameters: {"idMenu": "0", "title": "Empty", "idAnnonce": "0"});
    } else {
      Object? extra;
      if ((menuItem.screenTypeRoute == MenuTypeRoute.list ||
              menuItem.screenTypeRoute == MenuTypeRoute.listBasic) &&
          screenMenuInfo != null) {
        extra = screenMenuInfo.copyWith(
            isBasicScreenWithoutPremium:
                menuItem.screenTypeRoute == MenuTypeRoute.listBasic);
        AppRouter.go(context, routeNames, extra: extra);
      } else if ((menuItem.screenTypeRoute == MenuTypeRoute.menuScroll ||
          menuItem.screenTypeRoute == MenuTypeRoute.menuNotScroll)) {
        AppRouter.go(context, routeNames, queryParameters: {
          "id": menuItem.id.toString(),
          "name": menuItem.name
        });
      } else if (routeNames == RoutesNames.sondageList) {
        AppRouter.go(context, routeNames,
            queryParameters: {"title": screenMenuInfo?.title ?? ""});
      } else if (routeNames == RoutesNames.demandePlainte) {
        AppRouter.go(context, routeNames, queryParameters: {
          "id": menuItem.id.toString(),
          "title": screenMenuInfo?.title ?? ""
        });
      } else if (routeNames == RoutesNames.avis) {
        AppRouter.go(context, routeNames,
            queryParameters: {"title": screenMenuInfo?.title ?? ""});
      } else if (routeNames == RoutesNames.exchangeRate) {
        AppRouter.go(context, routeNames);
      } else if (routeNames == RoutesNames.karaPartner) {
        AppRouter.go(context, routeNames,
            queryParameters: {"title": menuItem.name});
      } else if (routeNames == RoutesNames.mipsInfo) {
        AppRouter.go(context, routeNames,
            queryParameters: {"title": menuItem.name});
      } else {
        AppRouter.go(context, routeNames);
      }
    }
  }

  Widget _buildMenuGroup(BuildContext context, List<MenuItem> menuItems) {
    List<MenuItemHolder> leftMenuItems = [];
    List<MenuItemHolder> rigthMenuItems = [];
    List<MenuItemHolder> allItems = [];

    for (int i = 0; i < menuItems.length; i++) {
      MenuItemHolder menuItem;

      switch (menuItems[i].screenMenuItemType) {
        case MenuItemType.menuGroup:
          List<MenuItemHolder> subMenu = [];
          List<MenuItem>? subElement = menuItems[i].subMenu;
          if (subElement.isNotEmpty) {
            for (int j = 0; j < subElement.length; j++) {
              subMenu.add(MenuItemHolder(
                  reference: menuItems[i].reference,
                  isFav: menuItems[i].isFav,
                  isFree: menuItems[i].isFree,
                  menuItemType: MenuItemHolderType.normal,
                  title: subElement[j].name,
                  id: subElement[j].id,
                  annoncesTodayCount: subElement[j].annoncesTodayCount,
                  color: AppUtils.stringToColor(
                      colorsStringList[j % colorsStringList.length]),
                  onClick: () {
                    _navigateScreenRoute(
                        context,
                        subElement[j],
                        Menu(
                            annonceSponsor: null,
                            annoncePartner: null,
                            id: subElement[j].id,
                            title: subElement[j].name,
                            menusChildList: [],
                            isFavs: subElement[j].isFav,
                            isFree: subElement[j].isFree,
                            reference: subElement[j].reference));
                  },
                  iconPath: subElement[j].iconPath));
            }
          }
          menuItem = MenuItemHolder(
              annoncesTodayCount: menuItems[i].annoncesTodayCount,
              reference: menuItems[i].reference,
              menuItemType: MenuItemHolderType.group,
              title: menuItems[i].name,
              isFav: menuItems[i].isFav,
              isFree: menuItems[i].isFree,
              id: menuItems[i].id,
              color: AppUtils.stringToColor(
                  colorsStringList[i % colorsStringList.length]),
              onClick: () {},
              subMenu: subMenu);
          break;
        case MenuItemType.menu:
        default:
          print(
              "KARA PARTNER : ${menuItems[i].reference} & PARTNER : ${menuItems[i].subMenu.length}");
          if (menuItems[i].reference == "IP") {
            // continue;
          }
          menuItem = MenuItemHolder(
              annoncesTodayCount: menuItems[i].annoncesTodayCount,
              reference: menuItems[i].reference,
              menuItemType: MenuItemHolderType.normal,
              title: menuItems[i].name,
              id: menuItems[i].id,
              isFav: menuItems[i].isFav,
              isFree: menuItems[i].isFree,
              color: AppUtils.stringToColor(
                  colorsStringList[i % colorsStringList.length]),
              onClick: () {
                _navigateScreenRoute(
                    context,
                    menuItems[i],
                    Menu(
                        annonceSponsor: null,
                        annoncePartner: null,
                        id: menuItems[i].id,
                        title: menuItems[i].name,
                        menusChildList: [],
                        isFavs: menuItems[i].isFav,
                        isFree: menuItems[i].isFree,
                        reference: menuItems[i].reference));
              },
              iconPath: menuItems[i].iconPath);
      }
      if (i % 2 == 0) {
        leftMenuItems.add(menuItem);
      } else {
        rigthMenuItems.add(menuItem);
      }
    }

    for (int i = 0; i < max(leftMenuItems.length, rigthMenuItems.length); i++) {
      if (i < leftMenuItems.length) {
        allItems.add(leftMenuItems[i]);
      }
      if (i < rigthMenuItems.length) {
        allItems.add(rigthMenuItems[i]);
      }
    }

    double minItemHeight = 60;
    return Container(
      color: Colors.grey.shade200,
      child: Padding(
        // padding: const EdgeInsets.all(smallPadding),
        padding: const EdgeInsets.all(0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                children: leftMenuItems
                    .map((e) => Container(
                        constraints: BoxConstraints(minHeight: minItemHeight),
                        child: BaseContentItem(menuItem: e)))
                    .toList(),
              ),
            ),
            Expanded(
              child: Column(
                children: rigthMenuItems
                    .map((e) => Container(
                        constraints: BoxConstraints(minHeight: minItemHeight),
                        child: BaseContentItem(menuItem: e)))
                    .toList(),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildMenuMain(BuildContext context, List<MenuItem> menuItems) {
    List<MenuItemHolder> leftMenuItems = [];
    List<MenuItemHolder> rigthMenuItems = [];
    List<MenuItemHolder> menuCombined = [];

    for (int i = 0; i < menuItems.length; i++) {
      MenuItemHolder menuItem;
      print("MENU ITEM ID : ${menuItems[i].id} AND i : $i");

      menuRefColor.add(
        MenuRefColor(
          reference: menuItems[i].reference,
          color: AppUtils.stringToColor(
              colorsStringList[i % colorsStringList.length]),
        ),
      );

      menuItem = MenuItemHolder(
          annoncesTodayCount: menuItems[i].annoncesTodayCount,
          desc: menuItems[i].desc,
          reference: menuItems[i].reference,
          menuItemType: MenuItemHolderType.mainMenu,
          title: menuItems[i].name,
          isFav: menuItems[i].isFav,
          isFree: menuItems[i].isFree,
          id: menuItems[i].id,
          // color: menuItems[i].color, ALREADY HERE
          color: AppUtils.stringToColor(
              colorsStringList[i % colorsStringList.length]),
          // color: Colors.amber,
          onClick: () {
            setState(() {
              _screenId = i + 1;
              // _menuMainIndex = i;
              _selectedIndex = i;
              context
                  .read<MenuScreenBloc>()
                  .add(LoadMenuScreenEvent(id: "${menuItems[i].id}"));
            });
          },
          iconPath: menuItems[i].iconPath);

      if (i % 2 == 0) {
        leftMenuItems.add(menuItem);
      } else {
        rigthMenuItems.add(menuItem);
      }
    }
    for (int i = 0; i < max(leftMenuItems.length, rigthMenuItems.length); i++) {
      if (i < leftMenuItems.length) {
        menuCombined.add(leftMenuItems[i]);
      }
      if (i < rigthMenuItems.length) {
        menuCombined.add(rigthMenuItems[i]);
      }
    }
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        color: Colors.white,
        child: Row(
          children: List.generate(
            menuItems.length,
            (index) {
              return BaseContentItem(
                menuItem: menuCombined[index],
                isSelected: _selectedIndex == -1
                    ? false
                    : _selectedIndex == index
                        ? true
                        : false,
              );
            },
          ),
        ),
      ),
    );
  }
}

// import 'dart:math';

// import 'package:MIPS/common/constants/constant.dart';
// import 'package:MIPS/common/utils/app_utils.dart';
// import 'package:MIPS/common/utils/globals.dart';
// import 'package:MIPS/domain/entities/annonce.dart';
// import 'package:MIPS/domain/entities/menu.dart';
// import 'package:MIPS/presentation/bloc/app_bloc.dart';
// import 'package:MIPS/presentation/bloc/menu_screen_bloc.dart';
// import 'package:MIPS/presentation/configurations/colors_list.dart';
// import 'package:MIPS/presentation/presentation.dart';
// import 'package:MIPS/presentation/routes/route.dart';
// import 'package:MIPS/presentation/routes/router.dart';
// import 'package:MIPS/presentation/screens/base/base_content.dart';
// import 'package:MIPS/presentation/screens/base/base_content_item.dart';
// import 'package:MIPS/presentation/screens/base/base_screen.dart';
// import 'package:MIPS/presentation/screens/base/menu_item.dart';
// import 'package:MIPS/presentation/screens/list/list_global_content.dart';
// import 'package:MIPS/presentation/widgets/message_displayer_utils.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:get_it/get_it.dart';
// import 'package:go_router/go_router.dart';

// class MenuScreen extends StatefulWidget {
//   const MenuScreen({super.key});

//   @override
//   State<MenuScreen> createState() => _MenuScreenState();
// }

// class _MenuScreenState extends State<MenuScreen> {
//   List<MenuItem> _menuItems = [];
//   int _screenId = 0;
//   int _menuMainIndex = 0;
//   int _selectedIndex = -1;
//   String _langueDoesChange = "";
//   String _actualLangue = "";

//   @override
//   void initState() {
//     menuRefColor.clear();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => GetIt.instance<MenuScreenBloc>()
//         ..add(
//           LoadMenuScreenEvent(id: "0"),
//         ),
//       child: BlocConsumer<AppBloc, AppState>(
//         listener: (context, state) {
//           if (state.lang.toString() !=
//               context.read<MenuScreenBloc>().state.lang) {
//             context
//                 .read<MenuScreenBloc>()
//                 .add(MenuLangChangeEvent(lang: state.lang.toString()));
//           }
//         },
//         builder: (context, state) {
//           _actualLangue = state.lang.toString();
//           return BlocListener<MenuScreenBloc, MenuScreenState>(
//             listenWhen: (previous, current) {
//               return (previous.screenEntity != current.screenEntity &&
//                   _screenId == 0 &&
//                   current.screenEntity != null);
//             },
//             listener: (context, state) {
//               setState(() {
//                 _langueDoesChange = _actualLangue;
//                 _menuItems = state.screenEntity?.menusChildList ?? [];
//               });
//             },
//             child: BlocListener<MenuScreenBloc, MenuScreenState>(
//               listenWhen: (previous, current) =>
//                   previous.screenEntity != null &&
//                   current.screenEntity != null &&
//                   ((previous.screenEntity != current.screenEntity ||
//                       previous.screenEntity != current.screenEntity)),
//               listener: (context, state) {
//                 if (state.screenEntity != null) {
//                   if (_screenId == 0) {
//                     context.read<AppBloc>().add(SetSponsAndPartenerEvent(
//                         annonceSponsor: state.screenEntity?.annonceSponsor,
//                         annoncePartenaire: state.screenEntity?.annoncePartner));
//                   } else {
//                     context.read<AppBloc>().add(
//                         SetAnnonceSponsorPartenaireNavEvent(
//                             annoncesPartenaire:
//                                 state.screenEntity?.annoncePartner,
//                             annoncesSponsor:
//                                 state.screenEntity?.annonceSponsor));
//                   }
//                 }
//               },
//               child: BlocBuilder<MenuScreenBloc, MenuScreenState>(
//                 builder: (context, state) {
//                   List<MenuItem> subMenus = [];
//                   if (_screenId != 0) {
//                     subMenus = state.screenEntity?.menusChildList ?? [];
//                   }

//                   return BaseScreen(
//                     useDefaultAnnonceSponsPart: false,
//                     annoncePartner: state.screenEntity!.annoncePartner,
//                     annonceSponsor: state.screenEntity!.annonceSponsor,
//                     backgroundColor: Colors.grey.shade200,
//                     // backgroundColor: Colors.white,
//                     content: state.status == Status.loading && _screenId == 0
//                         ? AppLoadingWidget()
//                         : Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Padding(
//                                 padding:
//                                     const EdgeInsets.symmetric(horizontal: 3),
//                                 child: _buildMenuMain(context, _menuItems),
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.only(
//                                     top: 8, left: 8, right: 8),
//                                 child: _screenId == 0
//                                     ? Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: [
//                                           Text(
//                                             "Annonces récentes",
//                                             style: TextStyle(
//                                                 fontWeight: FontWeight.bold),
//                                           ),
//                                           Divider(
//                                             color: Colors.grey.shade300,
//                                             height: 4.0,
//                                           ),
//                                         ],
//                                       )
//                                     : const SizedBox(),
//                                 // : Column(
//                                 //     crossAxisAlignment:
//                                 //         CrossAxisAlignment.start,
//                                 //     children: [
//                                 //       Text(
//                                 //         _menuItems[_menuMainIndex].name,
//                                 //         style: TextStyle(
//                                 //             fontWeight: FontWeight.bold),
//                                 //       ),
//                                 //       Divider(
//                                 //         color: Colors.grey.shade300,
//                                 //         height: 4.0,
//                                 //       ),
//                                 //     ],
//                                 //   ),
//                               ),
//                               _screenId == 0
//                                   ? Expanded(
//                                       child: Padding(
//                                         padding: const EdgeInsets.symmetric(
//                                             horizontal: 8),
//                                         child: ListGlobalContent(
//                                           onSearch: false,
//                                           initialMenuInfoScreen:
//                                               state.screenEntity!,
//                                         ),
//                                       ),
//                                     )
//                                   : Expanded(
//                                       child: SingleChildScrollView(
//                                         padding: const EdgeInsets.symmetric(
//                                             horizontal: 3),
//                                         child: Column(
//                                             crossAxisAlignment:
//                                                 CrossAxisAlignment.start,
//                                             children:
//                                                 state.status == Status.loading
//                                                     ? [AppLoadingWidget()]
//                                                     : [
//                                                         _buildMenuGroup(
//                                                             context, subMenus)
//                                                       ]
//                                             // : [
//                                             //     _menuItems.isEmpty
//                                             //         ? const SizedBox()
//                                             //         : Text(
//                                             //             _menuItems[_menuMainIndex]
//                                             //                 .name),
//                                             //     ...List.generate(subMenus.length,
//                                             //         (index) {
//                                             //       return Text(
//                                             //           "${subMenus[index].subMenu.length}");
//                                             //     }),
//                                             //     // ...List.generate(menuCombined.length, (index) {
//                                             //     //   return BaseContentItem(
//                                             //     //     menuItem: menuCombined[index],
//                                             //     //   );
//                                             //     // }),
//                                             //   ],
//                                             ),
//                                       ),
//                                     ),
//                             ],
//                           ),
//                     leading: GestureDetector(
//                       onTap: () {
//                         AppRouter.go(context, RoutesNames.appAbout);
//                       },
//                       child: Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Badge(
//                           backgroundColor: tertiaryColor,
//                           isLabelVisible:
//                               context.read<AppBloc>().state.updateStatus ==
//                                   UpdateStatus.updateVersionAvailable,
//                           label: const Icon(
//                             Icons.arrow_upward,
//                             color: Colors.white,
//                             size: 10,
//                           ),
//                           child: ClipRRect(
//                               borderRadius:
//                                   BorderRadius.circular(mediumPadding),
//                               child:
//                                   Image.asset("assets/imgs/ic_mahafaka.png")),
//                         ),
//                       ),
//                     ),
//                     appBarAction: [
//                       // Utilisateur n'est pas connectée.
//                       // if (!context.read<AppBloc>().state.isLogged)
//                       //   OutlinedButton(
//                       //     onPressed: () {
//                       //       AppRouter.go(context, RoutesNames.login);
//                       //     },
//                       //     child: Text(context.appLoc.connexion),
//                       //   ),
//                       IconButton(
//                         onPressed: () {
//                           AppRouter.go(
//                             context,
//                             RoutesNames.globalSearch,
//                             extra: Menu(
//                               annoncePartner: null,
//                               annonceSponsor: null,
//                               id: 9,
//                               title: "Maha Nouvelles",
//                               reference: "AA",
//                               isFree: true,
//                               menusChildList: [],
//                               isFavs: false,
//                             ),
//                             queryParameters: {"onSearch": "true"},
//                           );
//                         },
//                         icon: const Icon(
//                           Icons.search,
//                           color: Theme.of(context).colorScheme.primary,
//                         ),
//                       ),
//                       // if (!context.read<AppBloc>().state.isLogged)
//                       //   IconButton(
//                       //       onPressed: () {
//                       //         // AppRouter.go(context, RoutesNames.login);
//                       //         MessageDisplayerUtils.showAuthRequiredDialog(
//                       //             context,
//                       //             GoRouterState.of(context)
//                       //                 .uri
//                       //                 .toString()
//                       //                 .startsWith(RoutesNames.login));
//                       //       },
//                       //       icon: Badge(
//                       //           backgroundColor:
//                       //               Theme.of(context).colorScheme.primary,
//                       //           isLabelVisible: false,
//                       //           child: const Icon(Icons.notifications_outlined))),
//                       if (context.read<AppBloc>().state.isLogged)
//                         IconButton(
//                             onPressed: () {
//                               AppRouter.go(context, RoutesNames.message);
//                             },
//                             icon: Badge(
//                                 isLabelVisible: context
//                                         .read<AppBloc>()
//                                         .state
//                                         .unreadMessageCount >
//                                     0,
//                                 label: Text((context
//                                             .read<AppBloc>()
//                                             .state
//                                             .unreadMessageCount >
//                                         99)
//                                     ? "+99"
//                                     : context
//                                         .read<AppBloc>()
//                                         .state
//                                         .unreadMessageCount
//                                         .toString()),
//                                 backgroundColor:
//                                     Theme.of(context).colorScheme.primary,
//                                 child:
//                                     const Icon(Icons.notifications_outlined))),
//                       // Paramètres pour modifier les langues, tailles de polices, ...
//                       IconButton(
//                           onPressed: () {
//                             AppRouter.go(context, RoutesNames.appSettings);
//                           },
//                           icon: const Icon(Icons.settings_outlined)),
//                     ],
//                     title: Row(
//                       children: [
//                         // Text("Mahafaka"),
//                         Text("MIPS"),
//                       ],
//                     ),
//                   );
//                 },
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }

//   void _navigateScreenRoute(
//       BuildContext context, MenuItem menuItem, Menu? screenMenuInfo) {
//     String routeNames;
//     switch (menuItem.screenTypeRoute) {
//       case MenuTypeRoute.list:
//       case MenuTypeRoute.listBasic:
//         routeNames = RoutesNames.list;
//         break;
//       case MenuTypeRoute.menuScroll:
//       case MenuTypeRoute.menuNotScroll:
//         routeNames = RoutesNames.menu;
//         break;
//       case MenuTypeRoute.MAHA_SONDAGE:
//         routeNames = RoutesNames.sondageList;
//         break;
//       case MenuTypeRoute.MAHA_PARTENAIRE:
//         routeNames = RoutesNames.mahaPartenaireList;
//         break;
//       case MenuTypeRoute.MAHA_PLAINTE_SUGGESTION:
//         routeNames = RoutesNames.demandePlainte;
//         break;
//       case MenuTypeRoute.MAHA_AVIS:
//         routeNames = RoutesNames.avis;
//         break;
//       default:
//         routeNames = RoutesNames.empty;
//     }
//     if (menuItem.reference == "8200") {
//       AppRouter.go(context, RoutesNames.demandePub,
//           queryParameters: {"idMenu": "0", "title": "Empty", "idAnnonce": "0"});
//     } else {
//       Object? extra;
//       if ((menuItem.screenTypeRoute == MenuTypeRoute.list ||
//               menuItem.screenTypeRoute == MenuTypeRoute.listBasic) &&
//           screenMenuInfo != null) {
//         extra = screenMenuInfo.copyWith(
//             isBasicScreenWithoutPremium:
//                 menuItem.screenTypeRoute == MenuTypeRoute.listBasic);
//         AppRouter.go(context, routeNames, extra: extra);
//       } else if ((menuItem.screenTypeRoute == MenuTypeRoute.menuScroll ||
//           menuItem.screenTypeRoute == MenuTypeRoute.menuNotScroll)) {
//         AppRouter.go(context, routeNames, queryParameters: {
//           "id": menuItem.id.toString(),
//           "name": menuItem.name
//         });
//       } else if (routeNames == RoutesNames.sondageList) {
//         AppRouter.go(context, routeNames,
//             queryParameters: {"title": screenMenuInfo?.title ?? ""});
//       } else if (routeNames == RoutesNames.demandePlainte) {
//         AppRouter.go(context, routeNames, queryParameters: {
//           "id": menuItem.id.toString(),
//           "title": screenMenuInfo?.title ?? ""
//         });
//       } else if (routeNames == RoutesNames.avis) {
//         AppRouter.go(context, routeNames,
//             queryParameters: {"title": screenMenuInfo?.title ?? ""});
//       } else {
//         AppRouter.go(context, routeNames);
//       }
//     }
//   }

//   Widget _buildMenuGroup(BuildContext context, List<MenuItem> menuItems) {
//     List<MenuItemHolder> leftMenuItems = [];
//     List<MenuItemHolder> rigthMenuItems = [];
//     List<MenuItemHolder> allItems = [];

//     for (int i = 0; i < menuItems.length; i++) {
//       MenuItemHolder menuItem;

//       switch (menuItems[i].screenMenuItemType) {
//         case MenuItemType.menuGroup:
//           List<MenuItemHolder> subMenu = [];
//           List<MenuItem>? subElement = menuItems[i].subMenu;
//           if (subElement.isNotEmpty) {
//             for (int j = 0; j < subElement.length; j++) {
//               subMenu.add(MenuItemHolder(
//                   reference: menuItems[i].reference,
//                   isFav: menuItems[i].isFav,
//                   isFree: menuItems[i].isFree,
//                   menuItemType: MenuItemHolderType.normal,
//                   title: subElement[j].name,
//                   id: subElement[j].id,
//                   annoncesTodayCount: subElement[j].annoncesTodayCount,
//                   color: AppUtils.stringToColor(
//                       colorsStringList[j % colorsStringList.length]),
//                   onClick: () {
//                     _navigateScreenRoute(
//                         context,
//                         subElement[j],
//                         Menu(
//                             annonceSponsor: null,
//                             annoncePartner: null,
//                             id: subElement[j].id,
//                             title: subElement[j].name,
//                             menusChildList: [],
//                             isFavs: subElement[j].isFav,
//                             isFree: subElement[j].isFree,
//                             reference: subElement[j].reference));
//                   },
//                   iconPath: subElement[j].iconPath));
//             }
//           }
//           menuItem = MenuItemHolder(
//               annoncesTodayCount: menuItems[i].annoncesTodayCount,
//               reference: menuItems[i].reference,
//               menuItemType: MenuItemHolderType.group,
//               title: menuItems[i].name,
//               isFav: menuItems[i].isFav,
//               isFree: menuItems[i].isFree,
//               id: menuItems[i].id,
//               color: AppUtils.stringToColor(
//                   colorsStringList[i % colorsStringList.length]),
//               onClick: () {},
//               subMenu: subMenu);
//           break;
//         case MenuItemType.menu:
//         default:
//           menuItem = MenuItemHolder(
//               annoncesTodayCount: menuItems[i].annoncesTodayCount,
//               reference: menuItems[i].reference,
//               menuItemType: MenuItemHolderType.normal,
//               title: menuItems[i].name,
//               id: menuItems[i].id,
//               isFav: menuItems[i].isFav,
//               isFree: menuItems[i].isFree,
//               color: AppUtils.stringToColor(
//                   colorsStringList[i % colorsStringList.length]),
//               onClick: () {
//                 _navigateScreenRoute(
//                     context,
//                     menuItems[i],
//                     Menu(
//                         annonceSponsor: null,
//                         annoncePartner: null,
//                         id: menuItems[i].id,
//                         title: menuItems[i].name,
//                         menusChildList: [],
//                         isFavs: menuItems[i].isFav,
//                         isFree: menuItems[i].isFree,
//                         reference: menuItems[i].reference));
//               },
//               iconPath: menuItems[i].iconPath);
//       }
//       if (i % 2 == 0) {
//         leftMenuItems.add(menuItem);
//       } else {
//         rigthMenuItems.add(menuItem);
//       }
//     }

//     for (int i = 0; i < max(leftMenuItems.length, rigthMenuItems.length); i++) {
//       if (i < leftMenuItems.length) {
//         allItems.add(leftMenuItems[i]);
//       }
//       if (i < rigthMenuItems.length) {
//         allItems.add(rigthMenuItems[i]);
//       }
//     }

//     double minItemHeight = 60;
//     return Container(
//       color: Colors.grey.shade200,
//       child: Padding(
//         // padding: const EdgeInsets.all(smallPadding),
//         padding: const EdgeInsets.all(0),
//         child: Row(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Expanded(
//               child: Column(
//                 children: leftMenuItems
//                     .map((e) => Container(
//                         constraints: BoxConstraints(minHeight: minItemHeight),
//                         child: BaseContentItem(menuItem: e)))
//                     .toList(),
//               ),
//             ),
//             Expanded(
//               child: Column(
//                 children: rigthMenuItems
//                     .map((e) => Container(
//                         constraints: BoxConstraints(minHeight: minItemHeight),
//                         child: BaseContentItem(menuItem: e)))
//                     .toList(),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildMenuMain(BuildContext context, List<MenuItem> menuItems) {
//     List<MenuItemHolder> leftMenuItems = [];
//     List<MenuItemHolder> rigthMenuItems = [];
//     List<MenuItemHolder> menuCombined = [];

//     for (int i = 0; i < menuItems.length; i++) {
//       MenuItemHolder menuItem;

//       menuRefColor.add(
//         MenuRefColor(
//           reference: menuItems[i].reference,
//           color: AppUtils.stringToColor(
//               colorsStringList[i % colorsStringList.length]),
//         ),
//       );

//       menuItem = MenuItemHolder(
//           annoncesTodayCount: menuItems[i].annoncesTodayCount,
//           desc: menuItems[i].desc,
//           reference: menuItems[i].reference,
//           menuItemType: MenuItemHolderType.mainMenu,
//           title: menuItems[i].name,
//           isFav: menuItems[i].isFav,
//           isFree: menuItems[i].isFree,
//           id: menuItems[i].id,
//           // color: menuItems[i].color, ALREADY HERE
//           color: AppUtils.stringToColor(
//               colorsStringList[i % colorsStringList.length]),
//           // color: Colors.amber,
//           onClick: () {
//             setState(() {
//               _screenId = i + 1;
//               _menuMainIndex = i;
//               _selectedIndex = i;
//               context
//                   .read<MenuScreenBloc>()
//                   .add(LoadMenuScreenEvent(id: "$_screenId"));
//             });
//           },
//           iconPath: menuItems[i].iconPath);

//       if (i % 2 == 0) {
//         leftMenuItems.add(menuItem);
//       } else {
//         rigthMenuItems.add(menuItem);
//       }
//     }
//     for (int i = 0; i < max(leftMenuItems.length, rigthMenuItems.length); i++) {
//       if (i < leftMenuItems.length) {
//         menuCombined.add(leftMenuItems[i]);
//       }
//       if (i < rigthMenuItems.length) {
//         menuCombined.add(rigthMenuItems[i]);
//       }
//     }
//     return SingleChildScrollView(
//       scrollDirection: Axis.horizontal,
//       child: Container(
//         color: Colors.white,
//         child: Row(
//           children: List.generate(
//             menuItems.length,
//             (index) {
//               return BaseContentItem(
//                 menuItem: menuCombined[index],
//                 isSelected: _selectedIndex == -1
//                     ? false
//                     : _selectedIndex == index
//                         ? true
//                         : false,
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }
