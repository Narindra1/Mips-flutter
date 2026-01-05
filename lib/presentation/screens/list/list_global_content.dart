import 'package:MIPS/common/common.dart';
import 'package:MIPS/domain/domain.dart';
import 'package:MIPS/presentation/configurations/extension_for_localization.dart';
import 'package:MIPS/presentation/presentation.dart';
import 'package:MIPS/presentation/screens/base/base_screen.dart';
import 'package:MIPS/presentation/widgets/normal_ads_global_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:ionicons/ionicons.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../../routes/route.dart';
import '../../routes/router.dart';
import '../../widgets/empty_list_widget.dart';
import '../../widgets/error_page_widget.dart';
import '../../widgets/app_searchbar.dart';

class ListGlobalContent extends StatelessWidget {
  final Menu initialMenuInfoScreen;
  final bool onSearch;

  const ListGlobalContent({
    super.key,
    required this.initialMenuInfoScreen,
    required this.onSearch,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // BlocProvider(
        //   create: (context) => GetIt.instance<MenuScreenBloc>(),
        //   // create: ((context) => GetIt.instance<MenuScreenBloc>()
        //   //   ..add(SetScreenInfoEvent(
        //   //       screenInfo: initialMenuInfoScreen.copyWith(
        //   //     id: 9,
        //   //     title: "Maha Nouvelles",
        //   //     reference: "AA",
        //   //     isFree: true,
        //   //   )))),
        // ),
        BlocProvider(
          create: (context) => GetIt.instance<AnnonceBloc>()
            ..add(
              // LoadAnnonceList(id: 9, pageIndex: 1),
              LoadRecentAnnonceList(id: 0, pageIndex: 1),
            ),
          // create: ((context) {
          //   AnnonceBloc annonceBloc = GetIt.instance<AnnonceBloc>();
          //   context.read<AppBloc>().add(SetMenuCatNavEvent(
          //       seletectMenuCat: Categorie(
          //           id: 9,
          //           name: "Maha Nouvelles",
          //           reference: "AA",
          //           isFree: true),
          //       annonceBloc: annonceBloc));
          //   return annonceBloc..add(LoadRecentAnnonceList(id: 9, pageIndex: 1));
          // }),
        ),
      ],
      child: BlocBuilder<AnnonceBloc, AnnonceState>(
        builder: (context, state) {
          return onSearch
              ? PopScope(
                  canPop: false,
                  onPopInvokedWithResult: (didPop, result) {
                    AppRouter.goReplace(context, RoutesNames.home);
                  },
                  child: BaseScreen(
                    useDefaultAnnonceSponsPart: true,
                    content: _builContentListScrollAllList(context, state),
                    title: AppSearchBar(
                      hintText: context.appLoc.recents_announces,
                      onSearch: onSearch,
                    ),
                    leading: IconButton(
                      onPressed: () {
                        context.pop();
                      },
                      icon: Icon(
                        Ionicons.chevron_back,
                        color: Colors.black,
                      ),
                    ),
                  ),
                )
              : _builContentListScrollAllList(context, state);
        },
      ),
    );
  }

  Widget _builContentListScrollAllList(
      BuildContext context, AnnonceState state) {
    Widget content = const SizedBox();
    if (state.listStatus == ListStatus.loaded) {
      content = SingleChildScrollView(
        padding:
            onSearch ? EdgeInsets.symmetric(horizontal: 8) : EdgeInsets.zero,
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
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
                                      context
                                          .read<AnnonceBloc>()
                                          // .add(LoadMoreListItem());
                                          .add(LoadMoreListRecentItem());
                                    }
                                  },
                                  child: const AppLoadingWidget(),
                                )
                              : const SizedBox(),
                        );
                      }
                      print(
                          "MENU RACINE REF: ${state.annoncesNormal[index].menuRacineRef} | MENU RACINE NAME: ${state.annoncesNormal[index].menuRacineName} | MENU PARENT REF: ${state.annoncesNormal[index].menuParentRef} | MENU PARENT NAME: ${state.annoncesNormal[index].menuParentName}");
                      return NormalAdsGlobalWidget(
                        isFree: state.annoncesNormal[index].isFree,
                        isMerci: initialMenuInfoScreen.reference ==
                            mahaNouvelleMenuRef,
                        reactionCount:
                            state.annoncesNormal[index].reactionCount,
                        menuRacineRef:
                            state.annoncesNormal[index].menuRacineRef,
                        menuRacineName:
                            state.annoncesNormal[index].menuRacineName,
                        menuParentName:
                            state.annoncesNormal[index].menuParentName,
                        menuParentRef:
                            state.annoncesNormal[index].menuParentRef,
                        isPremium: state.annoncesNormal[index].annonceType ==
                            AnnonceType.premium,
                        dateCreation:
                            state.annoncesNormal[index].dateDeCreation,
                        id: state.annoncesNormal[index].id,
                        urlImage:
                            (state.annoncesNormal[index].photos.isNotEmpty)
                                ? state.annoncesNormal[index].photos.first
                                    .urlMiniature
                                : "",
                        title: state.annoncesNormal[index].title,
                        description:
                            state.annoncesNormal[index].descriptionCourte,
                        lieu: state.annoncesNormal[index].emplacement,
                        authorID: state.annoncesNormal[index].authorID,
                        authorName: (initialMenuInfoScreen.reference ==
                                blablaZoneMenuRef)
                            ? ""
                            : state.annoncesNormal[index].author,
                        onClick: () {
                          // print(
                          //     "MENU MAIN ${state.annoncesNormal[index].menuParentRef}");
                          // print(
                          //     "INITIAL MENU INFO SCREEN REF ${initialMenuInfoScreen.reference}");
                          AppRouter.go(context, RoutesNames.detailGlobal,
                              queryParameters: {
                                "id": state.annoncesNormal[index].id.toString(),
                                "name": state.annoncesNormal[index].title,
                              },
                              extra: context.read<AnnonceBloc>()
                                ..add(LoadAnnonceWithPartnerSponsor(
                                    id: state.annoncesNormal[index].id
                                        .toString())));
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
        // context.read<AnnonceBloc>().add(LoadAnnonceList(id: 9, pageIndex: 1));
        context
            .read<AnnonceBloc>()
            .add(LoadRecentAnnonceList(id: 0, pageIndex: 1));
      },
    );
  }
}
