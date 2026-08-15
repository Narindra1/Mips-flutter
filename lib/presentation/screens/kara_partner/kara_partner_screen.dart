import 'dart:math';

import 'package:mips/common/constants/constant.dart';
import 'package:mips/common/utils/app_utils.dart';
import 'package:mips/domain/entities/menu.dart';
import 'package:mips/presentation/bloc/app_bloc.dart';
import 'package:mips/presentation/configurations/colors_list.dart';
import 'package:mips/presentation/configurations/extension_for_localization.dart';
import 'package:mips/presentation/routes/route.dart';
import 'package:mips/presentation/routes/router.dart';
import 'package:mips/presentation/screens/base/base_content_item.dart';
import 'package:mips/presentation/screens/base/base_screen.dart';
import 'package:mips/presentation/screens/base/menu_item.dart';
import 'package:mips/presentation/screens/kara_partner/bloc/kara_partner_bloc.dart';
import 'package:mips/presentation/widgets/loading_widget.dart';
import 'package:mips/presentation/widgets/message_displayer_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

class KaraPartnerScreen extends StatelessWidget {
  const KaraPartnerScreen({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          GetIt.instance<KaraPartnerBloc>()..add(KaraProvinceLoaded()),
      child: BaseScreen(
        useDefaultAnnonceSponsPart: true,
        title: Text(title, style: Theme.of(context).textTheme.titleLarge),
        content: BlocBuilder<KaraPartnerBloc, KaraPartnerState>(
          builder: (context, state) {
            List<MenuItem> menuItems = [];
            // if (state.karaProvinceStatus == KaraProvinceStatus.loading) {
            //   return Center(child: AppLoadingWidget());
            // }
            if (state.karaProvinceStatus == KaraProvinceStatus.loaded) {
              for (int i = 0; i < state.provinces.length + 1; i++) {
                // print("PROVINCE : ${state.provinces[i].nom}");
                if (i < state.provinces.length) {
                  menuItems.add(
                    MenuItem(
                      name: state.provinces[i].nom,
                      screenTypeRoute: MenuTypeRoute.listKara,
                      id: state.provinces[i].id,
                      desc: state.provinces[i].description,
                      reference: state.provinces[i].reference,
                      isFav: false,
                      isFree: false,
                      annoncesTodayCount: 0,
                      nbrPartenaire: state.provinces[i].nbrPartenaire,
                      subMenu: [],
                    ),
                  );
                } else {
                  menuItems.add(
                    MenuItem(
                      name: context.appLoc.login_signup,
                      screenTypeRoute: MenuTypeRoute.listKara,
                      id: 0,
                      desc: "",
                      reference: "",
                      isFav: false,
                      isFree: false,
                      annoncesTodayCount: 0,
                      subMenu: [],
                    ),
                  );
                }
              }
              return SingleChildScrollView(
                child: _buildMenuGroup(context, menuItems),
              );
            }
            return Center(child: AppLoadingWidget());
          },
        ),
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: const Icon(Icons.chevron_left_outlined, color: Colors.black),
        ),
        backgroundColor: Colors.grey.shade200,
      ),
    );
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
              subMenu.add(
                MenuItemHolder(
                  reference: menuItems[i].reference,
                  isFav: menuItems[i].isFav,
                  isFree: menuItems[i].isFree,
                  menuItemType: MenuItemHolderType.normal,
                  title: subElement[j].name,
                  id: subElement[j].id,
                  annoncesTodayCount: subElement[j].annoncesTodayCount,
                  nbrPartenaire: menuItems[i].nbrPartenaire,
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
                      menuItems[i].name,
                    );
                  },
                  iconPath: subElement[j].iconPath,
                ),
              );
            }
          }
          menuItem = MenuItemHolder(
            annoncesTodayCount: menuItems[i].annoncesTodayCount,
            nbrPartenaire: menuItems[i].nbrPartenaire,
            reference: menuItems[i].reference,
            menuItemType: MenuItemHolderType.group,
            title: menuItems[i].name,
            isFav: menuItems[i].isFav,
            isFree: menuItems[i].isFree,
            id: menuItems[i].id,
            color: AppUtils.stringToColor(
              colorsStringList[i % colorsStringList.length],
            ),
            onClick: () {},
            subMenu: subMenu,
          );
          break;
        case MenuItemType.menu:
        default:
          print(
            "KARA PARTNER : ${menuItems[i].reference} & PARTNER : ${menuItems[i].subMenu.length}",
          );
          menuItem = MenuItemHolder(
            annoncesTodayCount: menuItems[i].annoncesTodayCount,
            nbrPartenaire: menuItems[i].nbrPartenaire,
            reference: menuItems[i].reference,
            menuItemType: MenuItemHolderType.normal,
            title: menuItems[i].name,
            id: menuItems[i].id,
            isFav: menuItems[i].isFav,
            isFree: menuItems[i].isFree,
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
                menuItems[i].name,
              );
            },
            iconPath: menuItems[i].iconPath,
          );
          if (i == menuItems.length - 1) {
            menuItem = MenuItemHolder(
              annoncesTodayCount: menuItems[i].annoncesTodayCount,
              nbrPartenaire: menuItems[i].nbrPartenaire,
              reference: menuItems[i].reference,
              menuItemType: MenuItemHolderType.normal,
              title: menuItems[i].name,
              id: menuItems[i].id,
              isFav: menuItems[i].isFav,
              isFree: menuItems[i].isFree,
              color: secondaryColor,
              // color: AppUtils.stringToColor(
              //     colorsStringList[i % colorsStringList.length]),
              onClick: () {
                if (context.read<AppBloc>().state.isLogged) {
                  print("S'INSCRIRE MAINTENANT");
                  // context.read<SondageBloc>().add(SubmitSondageEvent(
                  //       sondageId: widget.sondage.id,
                  //       optionSelected: selectedOption,
                  //     ));
                  AppRouter.go(context, RoutesNames.karaSubscription);
                } else {
                  MessageDisplayerUtils.showAuthRequiredDialog(
                    context,
                    GoRouterState.of(
                      context,
                    ).uri.toString().startsWith(RoutesNames.login),
                  );
                }
              },
              iconPath: menuItems[i].iconPath,
            );
          }
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
                    .map(
                      (e) => Container(
                        constraints: BoxConstraints(minHeight: minItemHeight),
                        child: Stack(
                          children: [
                            BaseContentItem(menuItem: e),
                            if (e.nbrPartenaire != null)
                              Positioned(
                                bottom: 10,
                                right: 15,
                                child: Text(
                                  e.nbrPartenaire.toString(),
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ),
                          ],
                        ),
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
                        child: Stack(
                          children: [
                            BaseContentItem(menuItem: e),
                            if (e.nbrPartenaire != null)
                              Positioned(
                                bottom: 10,
                                right: 15,
                                child: Text(
                                  e.nbrPartenaire.toString(),
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ),
                          ],
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateScreenRoute(
    BuildContext context,
    MenuItem menuItem,
    Menu? screenMenuInfo,
    String province,
  ) {
    String routeNames;
    switch (menuItem.screenTypeRoute) {
      case MenuTypeRoute.list:
      case MenuTypeRoute.listBasic:
        routeNames = RoutesNames.list;
        break;
      case MenuTypeRoute.listKara:
        routeNames = RoutesNames.karaList;
        break;
      case MenuTypeRoute.menuScroll:
      case MenuTypeRoute.menuNotScroll:
        routeNames = RoutesNames.menu;
        break;
      case MenuTypeRoute.mahaSondage:
        routeNames = RoutesNames.sondageList;
        break;
      case MenuTypeRoute.exchangeRate:
        routeNames = RoutesNames.exchangeRate;
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
      case MenuTypeRoute.karaPartner:
        routeNames = RoutesNames.karaPartner;
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
      }
      if ((menuItem.screenTypeRoute == MenuTypeRoute.listKara) &&
          screenMenuInfo != null) {
        extra = screenMenuInfo.copyWith(
          isBasicScreenWithoutPremium:
              menuItem.screenTypeRoute == MenuTypeRoute.listKara,
        );
        AppRouter.go(
          context,
          routeNames,
          extra: extra,
          queryParameters: {"province": province},
        );
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
      } else if (routeNames == RoutesNames.exchangeRate) {
        AppRouter.go(context, routeNames);
      } else if (routeNames == RoutesNames.karaPartner) {
        AppRouter.go(
          context,
          routeNames,
          queryParameters: {"title": menuItem.name},
        );
      } else {
        AppRouter.go(context, routeNames);
      }
    }
  }
}
