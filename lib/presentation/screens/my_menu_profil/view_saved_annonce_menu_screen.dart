import 'package:MIPS/domain/domain.dart';
import 'package:MIPS/presentation/bloc/follow_bloc.dart';
import 'package:MIPS/presentation/configurations/extension_for_localization.dart';
import 'package:MIPS/presentation/widgets/error_page_widget.dart';
import 'package:MIPS/presentation/widgets/normal_ads_global_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:ionicons/ionicons.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../../common/constants/constant.dart';
import '../../../domain/entities/menu.dart';
import '../../bloc/annonce_bloc.dart';
import '../../configurations/colors_list.dart';
import '../../routes/route.dart';
import '../../routes/router.dart';
import '../../widgets/empty_list_widget.dart';
import '../../widgets/loading_widget.dart';
import '../../widgets/normal_ads_widget.dart';
import '../base/base_screen.dart';
import 'bloc/my_menu_profil_bloc.dart';

class ViewSavedAnnonceMenuScreen extends StatefulWidget {
  final bool isAnnonceFavsScreen;
  final String title;

  const ViewSavedAnnonceMenuScreen(
      {super.key, required this.isAnnonceFavsScreen, required this.title});

  @override
  State<ViewSavedAnnonceMenuScreen> createState() =>
      _ViewSavedAnnonceMenuScreenState();
}

class _ViewSavedAnnonceMenuScreenState extends State<ViewSavedAnnonceMenuScreen>
    with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return BlocBuilder<MyMenuProfilBloc, MyMenuProfilState>(
      builder: (context, state) {
        return BaseScreen(
          useDefaultAnnonceSponsPart: true,
          title: Text(
            "${widget.isAnnonceFavsScreen ? context.appLoc.announce_favs : context.appLoc.menu_favs} (${state.annoncesFavorisCount})",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          appBarAction: const [],
          // content: Column(
          //   children: [
          //     TabBar.secondary(
          //       controller: _tabController,
          //       labelStyle: textTheme.titleMedium,
          //       unselectedLabelStyle: textTheme.titleMedium,
          //       dividerColor: Colors.grey,
          //       indicatorColor: secondaryColor,
          //       labelPadding: EdgeInsets.all(0),
          //       tabs: [
          //         BlocBuilder<MyMenuProfilBloc, MyMenuProfilState>(
          //           builder: (context, state) {
          //             return Container(
          //               width: double.infinity,
          //               color: Colors.white,
          //               child: Tab(
          //                 text:
          //                     "${context.appLoc.favorite} (${state.annoncesFavorisCount})",
          //               ),
          //             );
          //           },
          //         ),
          //         Container(
          //           width: double.infinity,
          //           color: Colors.white,
          //           child: BlocProvider.value(
          //             value: context.read<FollowBloc>()
          //               ..add(LoadAnnonceListOfFollowedUsersCount()),
          //             child: BlocBuilder<FollowBloc, FollowState>(
          //               builder: (context, state) {
          //                 if (state.annoncesOfFollowedUsersCountStatus ==
          //                     AnnoncesOfFollowedUsersCountStatus.loaded) {
          //                   print("TOTAL : ${state.annoncesOfFollowedUsersCount}");
          //                 }
          //                 return Tab(
          //                   text:
          //                       "${context.appLoc.followed} (${state.annoncesOfFollowedUsersCount})",
          //                 );
          //               },
          //             ),
          //           ),
          //         ),
          //       ],
          //     ),
          //     Expanded(
          //       child: TabBarView(
          //         controller: _tabController,
          //         children: [
          //           BlocBuilder<MyMenuProfilBloc, MyMenuProfilState>(
          //             builder: (context, state) {
          //               return _buildFavoriteList(context, state);
          //             },
          //           ),
          //           BlocBuilder<FollowBloc, FollowState>(
          //             builder: (context, state) {
          //               return _buildFollowedList(context, state);
          //             },
          //           ),
          //         ],
          //       ),
          //     )
          //   ],
          // ),
          content: _buildFavoriteList(context, state),
          leading: IconButton(
              onPressed: () {
                context.pop();
              },
              icon: Icon(
                Ionicons.chevron_back,
                color: Colors.black,
              )),
          // backgroundColor: Colors.white,
        );
      },
    );
  }

  Widget _buildFavoriteList(BuildContext context, MyMenuProfilState state) {
    Widget content = const SizedBox();
    if (state.annoncesFavorisStatus == AnnoncesFavorisStatus.loading) {
      content = const Center(child: AppLoadingWidget());
    } else if (state.annoncesFavorisStatus == AnnoncesFavorisStatus.error) {
      content = const CustomScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          slivers: [
            SliverFillRemaining(
              child: Center(
                child: ErrorPageWidget(),
              ),
            ),
          ]);
    } else if (widget.isAnnonceFavsScreen) {
      print("HERERER");
      content = Container(
        // padding: const EdgeInsets.all(mediumPadding),
        child: state.annoncesFavoris.isEmpty
            ? const EmptyListWidget(listType: ListType.favoris)
            : ListView.builder(
                key: PageStorageKey('favorite_list'),
                padding: EdgeInsets.all(mediumPadding),
                itemCount: state.annoncesFavoris.length + 1,
                itemBuilder: (context, index) {
                  if (index == state.annoncesFavoris.length) {
                    return Padding(
                      padding: const EdgeInsets.all(largePadding),
                      child: state.isNextListAvailable
                          ? VisibilityDetector(
                              key: const Key('loadMoreKey'),
                              onVisibilityChanged: (info) {
                                var visiblePercentage =
                                    info.visibleFraction * 100;
                                if (visiblePercentage >= 80) {
                                  context
                                      .read<MyMenuProfilBloc>()
                                      .add(LoadMoreAnnoncesFavoris());
                                }
                              },
                              child: const AppLoadingWidget(),
                            )
                          : const SizedBox(),
                    );
                  }
                  return Stack(
                    alignment: Alignment.topRight,
                    children: [
                      NormalAdsGlobalWidget(
                        saved: true,
                        isFree: state.annoncesFavoris[index].isFree,
                        reactionCount:
                            state.annoncesFavoris[index].reactionCount,
                        menuRacineRef:
                            state.annoncesFavoris[index].menuRacineRef,
                        menuRacineName:
                            state.annoncesFavoris[index].menuRacineName,
                        menuParentName:
                            state.annoncesFavoris[index].menuParentName,
                        menuParentRef:
                            state.annoncesFavoris[index].menuParentRef,
                        isPremium: state.annoncesFavoris[index].annonceType ==
                            AnnonceType.premium,
                        dateCreation:
                            state.annoncesFavoris[index].dateDeCreation,
                        id: state.annoncesFavoris[index].id,
                        urlImage:
                            (state.annoncesFavoris[index].photos.isNotEmpty)
                                ? state.annoncesFavoris[index].photos.first
                                    .urlMiniature
                                : "",
                        title: state.annoncesFavoris[index].title,
                        description:
                            state.annoncesFavoris[index].descriptionCourte,
                        lieu: state.annoncesFavoris[index].emplacement,
                        authorID: state.annoncesFavoris[index].authorID,
                        authorName: state.annoncesFavoris[index].author,
                        onClick: () {
                          AppRouter.go(context, RoutesNames.detailGlobal,
                              queryParameters: {
                                "id":
                                    state.annoncesFavoris[index].id.toString(),
                                "name": state.annoncesFavoris[index].title,
                              },
                              extra: context.read<AnnonceBloc>()
                                ..add(LoadAnnonceWithPartnerSponsor(
                                    id: state.annoncesFavoris[index].id
                                        .toString())));
                          // AppRouter.go(context, RoutesNames.detail,
                          //         queryParameters: {
                          //           "id": state.userMenuProfil
                          //               .annonceFavoris[index].id
                          //               .toString(),
                          //           "name": state.userMenuProfil
                          //               .annonceFavoris[index].title
                          //         },
                          //         extra: GetIt.instance<AnnonceBloc>()
                          //           ..add(LoadAnnonce(
                          //               id: state.userMenuProfil
                          //                   .annonceFavoris[index].id
                          //                   .toString())))
                          //     .then((value) {
                          //   if (context.mounted) {
                          //     context
                          //         .read<MyMenuProfilBloc>()
                          //         .add(LoadUserMenuProfilEvent());
                          //   }
                          // });
                        },
                      ),
                      Positioned(
                        top: 4,
                        right: 4,
                        child: SizedBox(
                          height: 24,
                          width: 24,
                          child: IconButton.filled(
                            padding: EdgeInsets.zero,
                            onPressed: () {
                              context.read<MyMenuProfilBloc>().add(
                                  DeleteAnnonceFromFavsEvent(
                                      id: state.annoncesFavoris[index].id));
                            },
                            icon: const Icon(
                              Icons.close,
                              color: Colors.white,
                            ),
                            iconSize: 16.0,
                          ),
                        ),
                      ),
                    ],
                  );
                }),
      );
    } else {
      content = Container(
        padding: const EdgeInsets.all(largePadding),
        child: ListView.builder(
          key: PageStorageKey('favorite_list'),
          padding: const EdgeInsets.all(mediumPadding),
          itemCount: state.userMenuProfil.menuFavoris.length + 1,
          itemBuilder: (BuildContext context, int index) {
            if (index == state.annoncesFavoris.length) {
              return Padding(
                padding: const EdgeInsets.all(largePadding),
                child: state.isNextListAvailable
                    ? VisibilityDetector(
                        key: const Key('loadMoreKey'),
                        onVisibilityChanged: (info) {
                          var visiblePercentage = info.visibleFraction * 100;
                          if (visiblePercentage >= 80) {
                            context
                                .read<MyMenuProfilBloc>()
                                .add(LoadMoreAnnoncesFavoris());
                          }
                        },
                        child: const AppLoadingWidget(),
                      )
                    : const SizedBox(),
              );
            }
            return Padding(
              padding: const EdgeInsets.all(0),
              child: Stack(
                alignment: Alignment.topRight,
                children: [
                  InkWell(
                    onTap: () {
                      if (state.userMenuProfil.menuFavoris[index]
                              .screenTypeRoute ==
                          MenuTypeRoute.list) {
                        AppRouter.go(
                          context,
                          RoutesNames.list,
                          extra: Menu(
                              annonceSponsor: null,
                              annoncePartner: null,
                              id: state.userMenuProfil.menuFavoris[index].id,
                              title:
                                  state.userMenuProfil.menuFavoris[index].name,
                              menusChildList: [],
                              isFavs:
                                  state.userMenuProfil.menuFavoris[index].isFav,
                              isFree: state
                                  .userMenuProfil.menuFavoris[index].isFree,
                              reference: state
                                  .userMenuProfil.menuFavoris[index].reference),
                        ).then((value) {
                          if (context.mounted) {
                            context
                                .read<MyMenuProfilBloc>()
                                .add(LoadUserMenuProfilEvent());
                          }
                        });
                      } else {
                        AppRouter.go(
                          context,
                          RoutesNames.menu,
                          queryParameters: {
                            "id": state.userMenuProfil.menuFavoris[index].id
                                .toString(),
                            "name": state.userMenuProfil.menuFavoris[index].name
                          },
                        ).then((value) {
                          if (context.mounted) {
                            context
                                .read<MyMenuProfilBloc>()
                                .add(LoadUserMenuProfilEvent());
                          }
                        });
                      }
                    },
                    child: Card(
                      color: Colors.white,
                      surfaceTintColor: Colors.white,
                      child: Container(
                        padding: const EdgeInsets.all(largePadding),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(mediumPadding),
                            border: Border.all(color: tertiaryColor)),
                        child: Center(
                          child: Text(
                            state.userMenuProfil.menuFavoris[index].name,
                            textAlign: TextAlign.left,
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 24,
                    width: 24,
                    child: IconButton.filled(
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        context.read<MyMenuProfilBloc>().add(
                            DeleteMenuFromFavsEvent(
                                id: state
                                    .userMenuProfil.menuFavoris[index].id));
                      },
                      icon: const Icon(
                        Icons.close,
                        color: Colors.white,
                      ),
                      iconSize: 16.0,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      );
    }
    return RefreshIndicator(
      child: content,
      onRefresh: () async {
        context.read<MyMenuProfilBloc>().add(LoadAnnoncesFavoris(pageIndex: 1));
      },
    );
  }

  Widget _buildFollowedList(BuildContext context, FollowState state) {
    Widget content = const SizedBox();
    if (state.annoncesFollowedStatus == AnnoncesFollowedStatus.loaded) {
      content = Container(
        // padding: const EdgeInsets.all(mediumPadding),
        child: state.annoncesOfFollowedUsers.isNotEmpty
            ? ListView.builder(
                key: PageStorageKey('follow_list'),
                // physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.all(mediumPadding),
                shrinkWrap: true,
                itemCount: state.annoncesOfFollowedUsers.length + 1,
                itemBuilder: (context, index) {
                  if (index == state.annoncesOfFollowedUsers.length) {
                    return Padding(
                      padding: const EdgeInsets.all(largePadding),
                      child: state.isNextListAvailable
                          ? VisibilityDetector(
                              key: const Key('loadMoreKey'),
                              onVisibilityChanged: (info) {
                                var visiblePercentage =
                                    info.visibleFraction * 100;
                                if (visiblePercentage >= 80) {
                                  context
                                      .read<FollowBloc>()
                                      .add(LoadMoreListAnnonce());
                                }
                              },
                              child: const AppLoadingWidget(),
                            )
                          : const SizedBox(),
                    );
                  }
                  print(
                      "REF : ${state.annoncesOfFollowedUsers[index].reactionCount}");
                  return NormalAdsGlobalWidget(
                    isFree: state.annoncesOfFollowedUsers[index].isFree,
                    // isMerci: initialMenuInfoScreen.reference ==
                    //     mahaNouvelleMenuRef,
                    reactionCount:
                        state.annoncesOfFollowedUsers[index].reactionCount,
                    menuRacineRef:
                        state.annoncesOfFollowedUsers[index].menuRacineRef,
                    menuRacineName:
                        state.annoncesOfFollowedUsers[index].menuRacineName,
                    menuParentName:
                        state.annoncesOfFollowedUsers[index].menuParentName,
                    menuParentRef:
                        state.annoncesOfFollowedUsers[index].menuParentRef,
                    isPremium:
                        state.annoncesOfFollowedUsers[index].annonceType ==
                            AnnonceType.premium,
                    dateCreation:
                        state.annoncesOfFollowedUsers[index].dateDeCreation,
                    id: state.annoncesOfFollowedUsers[index].id,
                    urlImage:
                        (state.annoncesOfFollowedUsers[index].photos.isNotEmpty)
                            ? state.annoncesOfFollowedUsers[index].photos.first
                                .urlMiniature
                            : "",
                    title: state.annoncesOfFollowedUsers[index].title,
                    description:
                        state.annoncesOfFollowedUsers[index].descriptionCourte,
                    lieu: state.annoncesOfFollowedUsers[index].emplacement,
                    authorID: state.annoncesOfFollowedUsers[index].authorID,
                    authorName:
                        (state.annoncesOfFollowedUsers[index].menuParentRef ==
                                blablaZoneMenuRef)
                            ? ""
                            : state.annoncesOfFollowedUsers[index].author,
                    onClick: () {
                      // print(
                      //     "MENU MAIN ${state.annoncesOfFollowedUsers[index].menuParentRef}");
                      // print(
                      //     "INITIAL MENU INFO SCREEN REF ${initialMenuInfoScreen.reference}");
                      AppRouter.go(context, RoutesNames.detailGlobal,
                          queryParameters: {
                            "id": state.annoncesOfFollowedUsers[index].id
                                .toString(),
                            "name": state.annoncesOfFollowedUsers[index].title,
                          },
                          extra: context.read<AnnonceBloc>()
                            ..add(LoadAnnonceWithPartnerSponsor(
                                id: state.annoncesOfFollowedUsers[index].id
                                    .toString())));
                    },
                  );
                },
              )
            : EmptyListWidget(listType: ListType.annonce),
      );
    } else if (state.annoncesFollowedStatus == AnnoncesFollowedStatus.loading) {
      content = const Center(
        child: AppLoadingWidget(),
      );
    } else {
      content = const CustomScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          slivers: [
            SliverFillRemaining(
              child: Center(
                child: ErrorPageWidget(),
              ),
            ),
          ]);
    }
    return RefreshIndicator(
      child: content,
      onRefresh: () async {
        context.read<FollowBloc>().add(LoadAnnonceListFollow(pageIndex: 1));
      },
    );
  }
}
