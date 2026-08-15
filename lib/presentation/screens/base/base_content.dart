import 'dart:math';

import 'package:mips/common/common.dart';
import 'package:mips/presentation/bloc/app_bloc.dart';
import 'package:mips/presentation/configurations/extension_for_localization.dart';
import 'package:mips/presentation/screens/base/base_content_item.dart';
import 'package:breakpoint/breakpoint.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/domain.dart';
import '../../configurations/colors_list.dart';
import '../../routes/route.dart';
import '../../routes/router.dart';

enum ListMode { mainMenu, fill, scroll }

class BaseContent extends StatefulWidget {
  final List<MenuItem> menuItems;
  final ListMode listMode;

  const BaseContent({
    super.key,
    required this.menuItems,
    this.listMode = ListMode.scroll,
  });

  @override
  State<BaseContent> createState() => _BaseContentState();
}

class _BaseContentState extends State<BaseContent> {
  String _menuMainName = "";
  int _menuMainIndex = -1;

  @override
  Widget build(BuildContext context) {
    Widget listItem = const SizedBox();
    List<MenuItemHolder> leftMenuItems = [];
    List<MenuItemHolder> rigthMenuItems = [];

    // Debug from here
    if (kDebugMode) {
      print("Menu counts : ${widget.menuItems.length}");
    }
    for (int i = 0; i < widget.menuItems.length; i++) {
      MenuItemHolder menuItem;

      switch (widget.menuItems[i].screenMenuItemType) {
        case MenuItemType.menuPopUp:
          print("Menu POPUP");
          List<MenuItem>? subElement = widget.menuItems[i].subMenu;

          menuItem = MenuItemHolder(
            annoncesTodayCount: widget.menuItems[i].annoncesTodayCount,
            reference: widget.menuItems[i].reference,
            menuItemType: MenuItemHolderType.normal,
            title: widget.menuItems[i].name,
            isFav: widget.menuItems[i].isFav,
            isFree: widget.menuItems[i].isFree,
            id: widget.menuItems[i].id,
            color: AppUtils.stringToColor(
              colorsStringList[i % colorsStringList.length],
            ),
            onClick: () {
              if (subElement.isNotEmpty) {
                showModalBottomSheet(
                  showDragHandle: true,
                  context: context,
                  builder: (context) {
                    return SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: List.generate(
                          subElement.length,
                          (index) => ListTile(
                            title: Text(subElement[index].name),
                            onTap: () {
                              context.pop();
                              _navigateScreenRoute(
                                context,
                                subElement[index],
                                Menu(
                                  annonceSponsor: null,
                                  annoncePartner: null,
                                  id: subElement[index].id,
                                  title: subElement[index].name,
                                  menusChildList: [],
                                  isFavs: subElement[index].isFav,
                                  isFree: subElement[index].isFree,
                                  reference: subElement[index].reference,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    );
                  },
                );
              }
            },
            iconPath: widget.menuItems[i].iconPath,
          );

          break;
        case MenuItemType.menuGroup:
          print("Menu GROUP");

          List<MenuItemHolder> subMenu = [];
          List<MenuItem>? subElement = widget.menuItems[i].subMenu;
          if (subElement.isNotEmpty) {
            for (int j = 0; j < subElement.length; j++) {
              subMenu.add(
                MenuItemHolder(
                  reference: widget.menuItems[i].reference,
                  isFav: widget.menuItems[i].isFav,
                  isFree: widget.menuItems[i].isFree,
                  menuItemType: MenuItemHolderType.normal,
                  title: subElement[j].name,
                  id: subElement[j].id,
                  annoncesTodayCount: subElement[j].annoncesTodayCount,
                  color: AppUtils.stringToColor(
                    colorsStringList[j % colorsStringList.length],
                  ),
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
                        reference: subElement[j].reference,
                      ),
                    );
                  },
                  iconPath: subElement[j].iconPath,
                ),
              );
            }
          }
          menuItem = MenuItemHolder(
            annoncesTodayCount: widget.menuItems[i].annoncesTodayCount,
            reference: widget.menuItems[i].reference,
            menuItemType: MenuItemHolderType.group,
            title: widget.menuItems[i].name,
            isFav: widget.menuItems[i].isFav,
            isFree: widget.menuItems[i].isFree,
            id: widget.menuItems[i].id,
            color: AppUtils.stringToColor(
              colorsStringList[i % colorsStringList.length],
            ),
            onClick: () {},
            subMenu: subMenu,
          );
          break;
        case MenuItemType.menuMain:
          print("Menu MAIN");

          menuItem = MenuItemHolder(
            annoncesTodayCount: widget.menuItems[i].annoncesTodayCount,
            desc: widget.menuItems[i].desc,
            reference: widget.menuItems[i].reference,
            menuItemType: MenuItemHolderType.mainMenu,
            title: widget.menuItems[i].name,
            isFav: widget.menuItems[i].isFav,
            isFree: widget.menuItems[i].isFree,
            id: widget.menuItems[i].id,
            // color: menuItems[i].color, ALREADY HERE
            color: AppUtils.stringToColor(
              colorsStringList[i % colorsStringList.length],
            ),
            // color: Colors.amber,
            onClick: () {
              setState(() {
                _menuMainName = widget.menuItems[i].name;
                _menuMainIndex = i;
                print(
                  "Click MenuMainName: $_menuMainName and MenuMainIndex: $_menuMainIndex",
                );
                print("Sous-menu : ${widget.menuItems[i].subMenu}");
              });

              // _navigateScreenRoute(
              //     context,
              //     widget.menuItems[i],
              //     Menu(
              //         annonceSponsor: null,
              //         annoncePartner: null,
              //         id: widget.menuItems[i].id,
              //         title: widget.menuItems[i].name,
              //         menusChildList: [],
              //         isFavs: widget.menuItems[i].isFav,
              //         isFree: widget.menuItems[i].isFree,
              //         reference: widget.menuItems[i].reference));
            },
            iconPath: widget.menuItems[i].iconPath,
          );
        case MenuItemType.menu:
        default:
          print("Menu MENU");

          menuItem = MenuItemHolder(
            annoncesTodayCount: widget.menuItems[i].annoncesTodayCount,
            reference: widget.menuItems[i].reference,
            menuItemType: MenuItemHolderType.normal,
            title: widget.menuItems[i].name,
            id: widget.menuItems[i].id,
            isFav: widget.menuItems[i].isFav,
            isFree: widget.menuItems[i].isFree,
            color: AppUtils.stringToColor(
              colorsStringList[i % colorsStringList.length],
            ),
            onClick: () {
              _navigateScreenRoute(
                context,
                widget.menuItems[i],
                Menu(
                  annonceSponsor: null,
                  annoncePartner: null,
                  id: widget.menuItems[i].id,
                  title: widget.menuItems[i].name,
                  menusChildList: [],
                  isFavs: widget.menuItems[i].isFav,
                  isFree: widget.menuItems[i].isFree,
                  reference: widget.menuItems[i].reference,
                ),
              );
            },
            iconPath: widget.menuItems[i].iconPath,
          );
      }
      if (i % 2 == 0) {
        leftMenuItems.add(menuItem);
      } else {
        rigthMenuItems.add(menuItem);
      }
    }
    switch (widget.listMode) {
      case ListMode.mainMenu:
        listItem = _mainViewScroll(leftMenuItems, rigthMenuItems);
        break;
      case ListMode.fill:
        listItem = _fillModeView(leftMenuItems, rigthMenuItems);
        break;
      case ListMode.scroll:
      default:
        listItem = _scrollModeView(leftMenuItems, rigthMenuItems);
    }
    return Padding(padding: const EdgeInsets.all(0), child: listItem);
  }

  Widget _fillModeView(
    List<MenuItemHolder> leftMenuItems,
    List<MenuItemHolder> rigthMenuItems,
  ) {
    return Padding(
      padding: const EdgeInsets.all(smallPadding),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              children: leftMenuItems.map((e) {
                int flexSize = 1;
                if (e.subMenu != null) {
                  flexSize = (e.subMenu!.length / 3).ceil();
                }
                return Expanded(
                  flex: flexSize,
                  child: BaseContentItem(menuItem: e),
                );
              }).toList(),
            ),
          ),
          Expanded(
            child: Column(
              children: rigthMenuItems.map((e) {
                int flexSize = 1;
                if (e.subMenu != null) {
                  flexSize = (e.subMenu!.length / 3).ceil();
                }
                return Expanded(
                  flex: flexSize,
                  child: BaseContentItem(menuItem: e),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _scrollModeView(
    List<MenuItemHolder> leftMenuItems,
    List<MenuItemHolder> rigthMenuItems,
  ) {
    List<MenuItemHolder> allItems = [];
    for (int i = 0; i < max(leftMenuItems.length, rigthMenuItems.length); i++) {
      if (i < leftMenuItems.length) {
        allItems.add(leftMenuItems[i]);
      }
      if (i < rigthMenuItems.length) {
        allItems.add(rigthMenuItems[i]);
      }
    }

    double minItemHeight = 100;
    return Padding(
      // padding: const EdgeInsets.all(smallPadding),
      padding: const EdgeInsets.all(0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              children: leftMenuItems
                  .map(
                    (e) => Container(
                      constraints: BoxConstraints(minHeight: minItemHeight),
                      child: BaseContentItem(menuItem: e),
                    ),
                  )
                  .toList(),
            ),
          ),
          Expanded(
            child: Column(
              children: rigthMenuItems
                  .map(
                    (e) => Container(
                      constraints: BoxConstraints(minHeight: minItemHeight),
                      child: BaseContentItem(menuItem: e),
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
    // return SingleChildScrollView(
    //   physics: const AlwaysScrollableScrollPhysics(),
    //   child: Padding(
    //     padding: const EdgeInsets.all(smallPadding),
    //     child: Row(
    //       mainAxisSize: MainAxisSize.min,
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       children: [
    //         Expanded(
    //           child: Column(
    //             children: leftMenuItems
    //                 .map((e) => Container(
    //                     constraints: BoxConstraints(minHeight: minItemHeight),
    //                     child: BaseContentItem(menuItem: e)))
    //                 .toList(),
    //           ),
    //         ),
    //         Expanded(
    //           child: Column(
    //             children: rigthMenuItems
    //                 .map((e) => Container(
    //                     constraints: BoxConstraints(minHeight: minItemHeight),
    //                     child: BaseContentItem(menuItem: e)))
    //                 .toList(),
    //           ),
    //         )
    //       ],
    //     ),
    //   ),
    // );
  }

  void _navigateScreenRoute(
    BuildContext context,
    MenuItem menuItem,
    Menu? screenMenuInfo,
  ) {
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
      case MenuTypeRoute.mahaSondage:
        routeNames = RoutesNames.sondageList;
        break;
      case MenuTypeRoute.mahaPartenaire:
        routeNames = RoutesNames.mahaPartenaireList;
        break;
      case MenuTypeRoute.mahaPlainteSuggestion:
        routeNames = RoutesNames.demandePlainte;
        break;
      case MenuTypeRoute.mahaAvis:
        routeNames = RoutesNames.avis;
        break;
      default:
        routeNames = RoutesNames.empty;
    }
    if (menuItem.reference == "8200") {
      AppRouter.go(
        context,
        RoutesNames.demandePub,
        queryParameters: {"idMenu": "0", "title": "Empty", "idAnnonce": "0"},
      );
    } else {
      Object? extra;
      if ((menuItem.screenTypeRoute == MenuTypeRoute.list ||
              menuItem.screenTypeRoute == MenuTypeRoute.listBasic) &&
          screenMenuInfo != null) {
        extra = screenMenuInfo.copyWith(
          isBasicScreenWithoutPremium:
              menuItem.screenTypeRoute == MenuTypeRoute.listBasic,
        );
        AppRouter.go(context, routeNames, extra: extra);
      } else if ((menuItem.screenTypeRoute == MenuTypeRoute.menuScroll ||
          menuItem.screenTypeRoute == MenuTypeRoute.menuNotScroll)) {
        AppRouter.go(
          context,
          routeNames,
          queryParameters: {
            "id": menuItem.id.toString(),
            "name": menuItem.name,
          },
        );
      } else if (routeNames == RoutesNames.sondageList) {
        AppRouter.go(
          context,
          routeNames,
          queryParameters: {"title": screenMenuInfo?.title ?? ""},
        );
      } else if (routeNames == RoutesNames.demandePlainte) {
        AppRouter.go(
          context,
          routeNames,
          queryParameters: {
            "id": menuItem.id.toString(),
            "title": screenMenuInfo?.title ?? "",
          },
        );
      } else if (routeNames == RoutesNames.avis) {
        AppRouter.go(
          context,
          routeNames,
          queryParameters: {"title": screenMenuInfo?.title ?? ""},
        );
      } else {
        AppRouter.go(context, routeNames);
      }
    }
  }

  Widget _buildMenuGroup(String menuMainName, int menuMainIndex) {
    List<MenuItemHolder> leftMenuItems = [];
    List<MenuItemHolder> rigthMenuItems = [];
    List<MenuItem> menuItems = widget.menuItems[menuMainIndex].subMenu;
    print("Menu LENGHT ${menuItems.length}");

    for (int i = 0; i < menuItems.length; i++) {
      MenuItemHolder menuItem;
      if (kDebugMode) {
        print("Menu : ${menuItems[i].name}");
        print("MenuItemType : ${menuItems[i].screenMenuItemType}");
      }

      switch (menuItems[i].screenMenuItemType) {
        case MenuItemType.menuGroup:
          print("Menu GROUP");
          List<MenuItemHolder> subMenu = [];
          List<MenuItem>? subElement = menuItems[i].subMenu;
          if (subElement.isNotEmpty) {
            for (int j = 0; j < subElement.length; j++) {
              subMenu.add(
                MenuItemHolder(
                  reference: menuItems[i].reference,
                  isFav: menuItems[i].isFav,
                  isFree: widget.menuItems[i].isFree,
                  menuItemType: MenuItemHolderType.normal,
                  title: subElement[j].name,
                  id: subElement[j].id,
                  annoncesTodayCount: subElement[j].annoncesTodayCount,
                  color: AppUtils.stringToColor(
                    colorsStringList[j % colorsStringList.length],
                  ),
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
                        reference: subElement[j].reference,
                      ),
                    );
                  },
                  iconPath: subElement[j].iconPath,
                ),
              );
            }
          }
          menuItem = MenuItemHolder(
            annoncesTodayCount: menuItems[i].annoncesTodayCount,
            reference: menuItems[i].reference,
            menuItemType: MenuItemHolderType.group,
            title: menuItems[i].name,
            isFav: menuItems[i].isFav,
            isFree: widget.menuItems[i].isFree,
            id: menuItems[i].id,
            color: AppUtils.stringToColor(
              colorsStringList[i % colorsStringList.length],
            ),
            onClick: () {},
            subMenu: subMenu,
          );
          break;
        // case MenuItemType.menu:
        default:
          print("Menu MENU");
          menuItem = MenuItemHolder(
            annoncesTodayCount: menuItems[i].annoncesTodayCount,
            reference: menuItems[i].reference,
            menuItemType: MenuItemHolderType.normal,
            title: menuItems[i].name,
            id: menuItems[i].id,
            isFav: menuItems[i].isFav,
            isFree: widget.menuItems[i].isFree,
            color: AppUtils.stringToColor(
              colorsStringList[i % colorsStringList.length],
            ),
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
                  reference: menuItems[i].reference,
                ),
              );
            },
            iconPath: menuItems[i].iconPath,
          );
      }
      if (i % 2 == 0) {
        leftMenuItems.add(menuItem);
      } else {
        rigthMenuItems.add(menuItem);
      }
    }

    return Expanded(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: _scrollModeView(leftMenuItems, rigthMenuItems),
      ),
    );
  }

  Widget _mainViewScroll(
    List<MenuItemHolder> leftMenuItems,
    List<MenuItemHolder> rigthMenuItems,
  ) {
    List<MenuItemHolder> menuCombined = [];
    for (int i = 0; i < max(leftMenuItems.length, rigthMenuItems.length); i++) {
      if (i < leftMenuItems.length) {
        menuCombined.add(leftMenuItems[i]);
      }
      if (i < rigthMenuItems.length) {
        menuCombined.add(rigthMenuItems[i]);
      }
    }

    return Builder(
      builder: (context) {
        Breakpoint breakpoint = Breakpoint.fromMediaQuery(context);
        double ratio = 0.85;
        switch (breakpoint.window) {
          case WindowSize.xsmall:
            ratio = 0.77;
          case WindowSize.small:
            ratio = 0.87;
            break;
          case WindowSize.medium:
          default:
            ratio = 0.85;
        }

        /// Handle mainmenu Expande status
        if (!context.read<AppBloc>().state.isMenuExpanded) {
          ratio = ratio * 1.23;
        }
        return Container(
          constraints: const BoxConstraints(maxWidth: 600),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0),
            // padding: const EdgeInsets.symmetric(horizontal: smallPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  color: Colors.white,
                  // height: 50,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(menuCombined.length, (index) {
                        return BaseContentItem(
                          menuItem: menuCombined[index],
                          // isModExpanded:
                          //     context.read<AppBloc>().state.isMenuExpanded,
                        );
                      }),
                    ),
                  ),
                ),
                Text(
                  _menuMainName == ""
                      ? context.appLoc.recents_announces
                      : _menuMainName,
                ),
                Container(
                  child: _menuMainName == ""
                      ? const SizedBox()
                      : _buildMenuGroup(_menuMainName, _menuMainIndex),
                ),
              ],
            ),
            // child: GridView.builder(
            //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            //     crossAxisCount: 2, // 2 elements per row
            //     childAspectRatio: ratio, // Aspect ratio for each item
            //   ),
            //   itemCount: menuCombined.length, // Number of items
            //   itemBuilder: (context, index) {
            //     return BaseContentItem(
            //         menuItem: menuCombined[index],
            //         isModExpanded: context.read<AppBloc>().state.isMenuExpanded);
            //   },
            // ),
          ),
        );
      },
    );
  }
}
