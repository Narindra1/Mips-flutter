import 'package:mips/common/common.dart';
import 'package:mips/domain/domain.dart';
import 'package:mips/presentation/presentation.dart';
import 'package:mips/presentation/screens/base/base_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../../../domain/entities/categorie.dart';
import '../../bloc/menu_screen_bloc.dart';
import '../../routes/route.dart';
import '../../routes/router.dart';
import '../../widgets/empty_list_widget.dart';
import '../../widgets/error_page_widget.dart';
import '../../widgets/app_searchbar.dart';
import '../../widgets/message_displayer_utils.dart';
import '../../widgets/normal_ads_widget.dart';
import '../../widgets/tips_conseil_widget.dart';
import '../../widgets/vip_ads_widgets.dart';
import '../../widgets/tips_mahaol_widget.dart';

class ListScreen extends StatelessWidget {
  final Menu initialMenuInfoScreen;

  const ListScreen({super.key, required this.initialMenuInfoScreen});

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print("ScreenInfo");
      print(initialMenuInfoScreen.id);
      print(initialMenuInfoScreen.title);
      print(initialMenuInfoScreen.reference);
      print(initialMenuInfoScreen.isFree);
    }

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: ((context) =>
              GetIt.instance<MenuScreenBloc>()
                ..add(SetScreenInfoEvent(screenInfo: initialMenuInfoScreen))),
        ),
        BlocProvider(
          create: ((context) {
            AnnonceBloc annonceBloc = GetIt.instance<AnnonceBloc>();
            context.read<AppBloc>().add(
              SetMenuCatNavEvent(
                seletectMenuCat: Categorie(
                  id: initialMenuInfoScreen.id,
                  name: initialMenuInfoScreen.title,
                  reference: initialMenuInfoScreen.reference,
                  isFree: initialMenuInfoScreen.isFree,
                ),
                annonceBloc: annonceBloc,
              ),
            );
            return annonceBloc..add(
              LoadAnnonceList(id: initialMenuInfoScreen.id, pageIndex: 1),
            );
          }),
        ),
      ],
      child: BlocBuilder<AnnonceBloc, AnnonceState>(
        builder: (context, state) {
          return BaseScreen(
            useDefaultAnnonceSponsPart: false,
            annoncePartner: (context
                .read<AppBloc>()
                .state
                .annoncePartenaireMenu),
            annonceSponsor: (context.read<AppBloc>().state.annonceSponsorMenu),
            content: (initialMenuInfoScreen.reference == mahaNouvelleMenuRef)
                ? _builContentListScrollAllList(context, state)
                : _builContentListNotScrollPremiumAds(context, state),
            leading: IconButton(
              onPressed: () {
                context.pop();
              },
              icon: const Icon(
                Icons.chevron_left_outlined,
                color: Colors.black,
              ),
            ),
            title: AppSearchBar(
              hintText: context
                  .read<MenuScreenBloc>()
                  .state
                  .screenEntity
                  ?.title,
            ),
          );
        },
      ),
    );
  }

  Widget _builContentListNotScrollPremiumAds(
    BuildContext context,
    AnnonceState state,
  ) {
    Widget content = const SizedBox();
    if (state.listStatus == ListStatus.loaded) {
      content = Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          if (initialMenuInfoScreen.reference == mahaNouvelleMenuRef)
            const Padding(
              padding: EdgeInsets.all(mediumPadding),
              child: TipsMahaolWidget(),
            ),
          if (initialMenuInfoScreen.reference == blablaZoneMenuRef)
            const Padding(
              padding: EdgeInsets.all(mediumPadding),
              child: TipsConseilWidget(),
            ),
          if (!initialMenuInfoScreen.isFree)
            Container(
              decoration: const BoxDecoration(color: Colors.white),
              padding: const EdgeInsets.all(smallPadding),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: List.generate(3, (index) {
                  if (index < state.annoncesVIP.length) {
                    return Expanded(
                      flex: 1,
                      child: VIPAdsWidgets(
                        onClick: () {
                          AppRouter.go(
                            context,
                            RoutesNames.detail,
                            queryParameters: {
                              "id": state.annoncesVIP[index].id.toString(),
                              "name": state.annoncesVIP[index].title,
                            },
                            extra: context.read<AnnonceBloc>()
                              ..add(
                                LoadAnnonce(
                                  id: state.annoncesVIP[index].id.toString(),
                                ),
                              ),
                          );
                        },
                        id: state.annoncesVIP[index].id,
                        title: state.annoncesVIP[index].title,
                        url: (state.annoncesVIP[index].photos.isNotEmpty)
                            ? state.annoncesVIP[index].photos.first.urlMiniature
                            : "",
                        description: state.annoncesVIP[index].descriptionCourte,
                      ),
                    );
                  } else {
                    return (index == state.annoncesVIP.length && index < 4)
                        ? Expanded(
                            flex: 1,
                            child: VIPAdsWidgets.empty(
                              onClick: () {
                                if (context.read<AppBloc>().state.isLogged) {
                                  AppRouter.go(
                                    context,
                                    RoutesNames.demandePub,
                                    queryParameters: {
                                      "menuParentRef": context
                                          .read<AppBloc>()
                                          .state
                                          .selectedMenuCategoriesNavigation
                                          .reference,
                                      "modeVIPOnly": "true",
                                      "idMenu": context
                                          .read<AppBloc>()
                                          .state
                                          .selectedMenuCategoriesNavigation
                                          .id
                                          .toString(),
                                      "title": context
                                          .read<AppBloc>()
                                          .state
                                          .selectedMenuCategoriesNavigation
                                          .name,
                                      "idAnnonce": "0",
                                      "isFreeMode":
                                          (context
                                                  .read<AppBloc>()
                                                  .state
                                                  .selectedMenuCategoriesNavigation
                                                  .isFree)
                                              .toString(),
                                    },
                                    extra: context.read<AppBloc>().annonceBloc,
                                  );
                                } else {
                                  MessageDisplayerUtils.showAuthRequiredDialog(
                                    context,
                                    GoRouterState.of(context).uri
                                        .toString()
                                        .startsWith(RoutesNames.login),
                                  );
                                }
                              },
                            ),
                          )
                        : const Expanded(flex: 1, child: SizedBox());
                  }
                }),
              ),
            ),
          if (!initialMenuInfoScreen.isFree)
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: mediumPadding),
              child: Divider(color: Colors.black12, height: 2),
            ),
          (state.annoncesNormal.isNotEmpty || state.annoncesPremium.isNotEmpty)
              ? Expanded(
                  child: ListView.builder(
                    itemCount:
                        state.annoncesPremium.length +
                        state.annoncesNormal.length +
                        1,
                    itemBuilder: (context, index) {
                      if (index < state.annoncesPremium.length) {
                        return NormalAdsWidget(
                          isFree: state.annoncesPremium[index].isFree,
                          isMerci:
                              initialMenuInfoScreen.reference ==
                              mahaNouvelleMenuRef,
                          reactionCount:
                              state.annoncesPremium[index].reactionCount,
                          isPremium: true,
                          dateCreation:
                              state.annoncesPremium[index].dateDeCreation,
                          id: state.annoncesPremium[index].id,
                          urlImage:
                              (state.annoncesPremium[index].photos.isNotEmpty)
                              ? state
                                    .annoncesPremium[index]
                                    .photos
                                    .first
                                    .urlMiniature
                              : "",
                          title: state.annoncesPremium[index].title,
                          description:
                              state.annoncesPremium[index].descriptionCourte,
                          lieu: state.annoncesPremium[index].emplacement,
                          authorID: state.annoncesPremium[index].authorID,
                          authorName:
                              (initialMenuInfoScreen.reference ==
                                  blablaZoneMenuRef)
                              ? ""
                              : state.annoncesPremium[index].author,
                          onClick: () {
                            // print(
                            //     "MENU MAIN ${state.annoncesNormal[index].menuParentRef}");
                            // print(
                            //     "INITIAL MENU INFO SCREEN REF ${initialMenuInfoScreen.reference}");
                            AppRouter.go(
                              context,
                              RoutesNames.detail,
                              queryParameters: {
                                "id": state.annoncesPremium[index].id
                                    .toString(),
                                "name": state.annoncesPremium[index].title,
                              },
                              extra: context.read<AnnonceBloc>()
                                ..add(
                                  LoadAnnonce(
                                    id: state.annoncesPremium[index].id
                                        .toString(),
                                  ),
                                ),
                            );
                          },
                        );
                      } else {
                        if (index ==
                            state.annoncesNormal.length +
                                state.annoncesPremium.length) {
                          return Padding(
                            padding: const EdgeInsets.all(largePadding),
                            child: state.isNextListAvailable
                                ? VisibilityDetector(
                                    key: const Key('loadMoreKey'),
                                    onVisibilityChanged: (info) {
                                      var visiblePercentage =
                                          info.visibleFraction * 100;
                                      if (visiblePercentage >= 80) {
                                        context.read<AnnonceBloc>().add(
                                          LoadMoreListItem(),
                                        );
                                      }
                                    },
                                    child: const AppLoadingWidget(),
                                  )
                                : const SizedBox(),
                          );
                        }
                        return NormalAdsWidget(
                          isFree: state
                              .annoncesNormal[index -
                                  state.annoncesPremium.length]
                              .isFree,
                          isMerci:
                              initialMenuInfoScreen.reference ==
                              mahaNouvelleMenuRef,
                          reactionCount: state
                              .annoncesNormal[index -
                                  state.annoncesPremium.length]
                              .reactionCount,
                          isPremium: false,
                          dateCreation: state
                              .annoncesNormal[index -
                                  state.annoncesPremium.length]
                              .dateDeCreation,
                          id: state
                              .annoncesNormal[index -
                                  state.annoncesPremium.length]
                              .id,
                          urlImage:
                              (state
                                  .annoncesNormal[index -
                                      state.annoncesPremium.length]
                                  .photos
                                  .isNotEmpty)
                              ? state
                                    .annoncesNormal[index -
                                        state.annoncesPremium.length]
                                    .photos
                                    .first
                                    .urlMiniature
                              : "",
                          title: state
                              .annoncesNormal[index -
                                  state.annoncesPremium.length]
                              .title,
                          description: state
                              .annoncesNormal[index -
                                  state.annoncesPremium.length]
                              .descriptionCourte,
                          lieu: state
                              .annoncesNormal[index -
                                  state.annoncesPremium.length]
                              .emplacement,
                          authorID: state
                              .annoncesNormal[index -
                                  state.annoncesPremium.length]
                              .authorID,
                          authorName:
                              (initialMenuInfoScreen.reference ==
                                  blablaZoneMenuRef)
                              ? ""
                              : state
                                    .annoncesNormal[index -
                                        state.annoncesPremium.length]
                                    .author,
                          onClick: () {
                            // print(
                            //     "MENU MAIN ${state.annoncesNormal[index].menuParentRef}");
                            // print(
                            //     "INITIAL MENU INFO SCREEN REF ${initialMenuInfoScreen.reference}");
                            AppRouter.go(
                              context,
                              RoutesNames.detail,
                              queryParameters: {
                                "id": state
                                    .annoncesNormal[index -
                                        state.annoncesPremium.length]
                                    .id
                                    .toString(),
                                "name": state
                                    .annoncesNormal[index -
                                        state.annoncesPremium.length]
                                    .title,
                              },
                              extra: context.read<AnnonceBloc>()
                                ..add(
                                  LoadAnnonce(
                                    id: state
                                        .annoncesNormal[index -
                                            state.annoncesPremium.length]
                                        .id
                                        .toString(),
                                  ),
                                ),
                            );
                          },
                        );
                      }
                    },
                  ),
                )
              : EmptyListWidget(
                  listType: state.query == ""
                      ? ListType.annonce
                      : ListType.annonceSearch,
                ),
        ],
      );
    } else if (state.listStatus == ListStatus.loading) {
      content = const Center(child: AppLoadingWidget());
    } else {
      content = const CustomScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        slivers: [SliverFillRemaining(child: Center(child: ErrorPageWidget()))],
      );
    }
    return RefreshIndicator(
      child: content,
      onRefresh: () async {
        context.read<AnnonceBloc>().add(
          LoadAnnonceList(
            id: context.read<MenuScreenBloc>().state.screenEntity!.id,
            pageIndex: 1,
          ),
        );
      },
    );
  }

  Widget _builContentListScrollAllList(
    BuildContext context,
    AnnonceState state,
  ) {
    Widget content = const SizedBox();
    if (state.listStatus == ListStatus.loaded) {
      content = SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (initialMenuInfoScreen.reference == mahaNouvelleMenuRef)
              const Padding(padding: EdgeInsets.only(top: mediumPadding)),
            //   const Padding(
            //     padding: EdgeInsets.all(mediumPadding),
            //     child: TipsMahaolWidget(),
            //   ),
            if (!initialMenuInfoScreen.isFree)
              Container(
                decoration: const BoxDecoration(color: Colors.white),
                padding: const EdgeInsets.all(smallPadding),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(3, (index) {
                    if (index < state.annoncesVIP.length) {
                      return Expanded(
                        flex: 1,
                        child: VIPAdsWidgets(
                          onClick: () {
                            AppRouter.go(
                              context,
                              RoutesNames.detail,
                              queryParameters: {
                                "id": state.annoncesVIP[index].id.toString(),
                                "name": state.annoncesVIP[index].title,
                              },
                              extra: context.read<AnnonceBloc>()
                                ..add(
                                  LoadAnnonce(
                                    id: state.annoncesVIP[index].id.toString(),
                                  ),
                                ),
                            );
                          },
                          id: state.annoncesVIP[index].id,
                          title: state.annoncesVIP[index].title,
                          url: (state.annoncesVIP[index].photos.isNotEmpty)
                              ? state
                                    .annoncesVIP[index]
                                    .photos
                                    .first
                                    .urlMiniature
                              : "",
                          description:
                              state.annoncesVIP[index].descriptionCourte,
                        ),
                      );
                    } else {
                      return (index == state.annoncesVIP.length && index < 4)
                          ? Expanded(
                              flex: 1,
                              child: VIPAdsWidgets.empty(
                                onClick: () {
                                  if (context.read<AppBloc>().state.isLogged) {
                                    AppRouter.go(
                                      context,
                                      RoutesNames.demandePub,
                                      queryParameters: {
                                        "menuParentRef": context
                                            .read<AppBloc>()
                                            .state
                                            .selectedMenuCategoriesNavigation
                                            .reference,
                                        "modeVIPOnly": "true",
                                        "idMenu": context
                                            .read<AppBloc>()
                                            .state
                                            .selectedMenuCategoriesNavigation
                                            .id
                                            .toString(),
                                        "title": context
                                            .read<AppBloc>()
                                            .state
                                            .selectedMenuCategoriesNavigation
                                            .name,
                                        "idAnnonce": "0",
                                        "isFreeMode":
                                            (context
                                                    .read<AppBloc>()
                                                    .state
                                                    .selectedMenuCategoriesNavigation
                                                    .isFree)
                                                .toString(),
                                      },
                                      extra: context
                                          .read<AppBloc>()
                                          .annonceBloc,
                                    );
                                  } else {
                                    MessageDisplayerUtils.showAuthRequiredDialog(
                                      context,
                                      GoRouterState.of(context).uri
                                          .toString()
                                          .startsWith(RoutesNames.login),
                                    );
                                  }
                                },
                              ),
                            )
                          : const Expanded(flex: 1, child: SizedBox());
                    }
                  }),
                ),
              ),
            if (!initialMenuInfoScreen.isFree)
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: mediumPadding),
                child: Divider(color: Colors.black12),
              ),
            state.annoncesNormal.isNotEmpty
                ? ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: state.annoncesNormal.length + 1,
                    itemBuilder: (context, index) {
                      if (index == state.annoncesNormal.length) {
                        return Padding(
                          padding: const EdgeInsets.all(largePadding),
                          child: state.isNextListAvailable
                              ? VisibilityDetector(
                                  key: const Key('loadMoreKey'),
                                  onVisibilityChanged: (info) {
                                    var visiblePercentage =
                                        info.visibleFraction * 100;
                                    if (visiblePercentage >= 80) {
                                      context.read<AnnonceBloc>().add(
                                        LoadMoreListItem(),
                                      );
                                    }
                                  },
                                  child: const AppLoadingWidget(),
                                )
                              : const SizedBox(),
                        );
                      }
                      return NormalAdsWidget(
                        isFree: state.annoncesNormal[index].isFree,
                        isMerci:
                            initialMenuInfoScreen.reference ==
                            mahaNouvelleMenuRef,
                        reactionCount:
                            state.annoncesNormal[index].reactionCount,
                        isPremium:
                            state.annoncesNormal[index].annonceType ==
                            AnnonceType.premium,
                        dateCreation:
                            state.annoncesNormal[index].dateDeCreation,
                        id: state.annoncesNormal[index].id,
                        urlImage:
                            (state.annoncesNormal[index].photos.isNotEmpty)
                            ? state
                                  .annoncesNormal[index]
                                  .photos
                                  .first
                                  .urlMiniature
                            : "",
                        title: state.annoncesNormal[index].title,
                        description:
                            state.annoncesNormal[index].descriptionCourte,
                        lieu: state.annoncesNormal[index].emplacement,
                        authorID: state.annoncesNormal[index].authorID,
                        authorName:
                            (initialMenuInfoScreen.reference ==
                                blablaZoneMenuRef)
                            ? ""
                            : state.annoncesNormal[index].author,
                        onClick: () {
                          // print(
                          //     "MENU MAIN ${state.annoncesNormal[index].menuParentRef}");
                          // print(
                          //     "INITIAL MENU INFO SCREEN REF ${initialMenuInfoScreen.reference}");
                          AppRouter.go(
                            context,
                            RoutesNames.detail,
                            queryParameters: {
                              "id": state.annoncesNormal[index].id.toString(),
                              "name": state.annoncesNormal[index].title,
                            },
                            extra: context.read<AnnonceBloc>()
                              ..add(
                                LoadAnnonce(
                                  id: state.annoncesNormal[index].id.toString(),
                                ),
                              ),
                          );
                        },
                      );
                    },
                  )
                : EmptyListWidget(
                    listType: state.query == ""
                        ? ListType.annonce
                        : ListType.annonceSearch,
                  ),
          ],
        ),
      );
    } else if (state.listStatus == ListStatus.loading) {
      content = const Center(child: AppLoadingWidget());
    } else {
      content = const CustomScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        slivers: [SliverFillRemaining(child: Center(child: ErrorPageWidget()))],
      );
    }
    return RefreshIndicator(
      child: content,
      onRefresh: () async {
        context.read<AnnonceBloc>().add(
          LoadAnnonceList(
            id: context.read<MenuScreenBloc>().state.screenEntity!.id,
            pageIndex: 1,
          ),
        );
      },
    );
  }
}
