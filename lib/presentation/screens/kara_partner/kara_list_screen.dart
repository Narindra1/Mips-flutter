import 'package:MIPS/common/common.dart';
import 'package:MIPS/domain/domain.dart';
import 'package:MIPS/presentation/presentation.dart';
import 'package:MIPS/presentation/screens/base/base_screen.dart';
import 'package:MIPS/presentation/screens/kara_partner/bloc/kara_partner_bloc.dart';
import 'package:MIPS/presentation/screens/kara_partner/widgets/kara_ads_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:ionicons/ionicons.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../../../domain/entities/categorie.dart';
import '../../bloc/menu_screen_bloc.dart';
import '../../widgets/empty_list_widget.dart';
import '../../widgets/error_page_widget.dart';
import '../../widgets/app_searchbar.dart';

class KaraListScreen extends StatelessWidget {
  final Menu initialMenuInfoScreen;
  final String province;

  const KaraListScreen({
    super.key,
    required this.initialMenuInfoScreen,
    required this.province,
  });

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print("KARA KARA KARA");
      print(initialMenuInfoScreen.id);
      print(initialMenuInfoScreen.title);
      print(initialMenuInfoScreen.reference);
      print(initialMenuInfoScreen.isFree);
    }

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: ((context) => GetIt.instance<MenuScreenBloc>()
            ..add(SetScreenInfoEvent(screenInfo: initialMenuInfoScreen))),
        ),
        BlocProvider(
          create: ((context) {
            AnnonceBloc annonceBloc = GetIt.instance<AnnonceBloc>();
            context.read<AppBloc>().add(SetMenuCatNavEvent(
                seletectMenuCat: Categorie(
                    id: initialMenuInfoScreen.id,
                    name: initialMenuInfoScreen.title,
                    reference: initialMenuInfoScreen.reference,
                    isFree: initialMenuInfoScreen.isFree),
                annonceBloc: annonceBloc));
            return annonceBloc
              ..add(
                  LoadAnnonceList(id: initialMenuInfoScreen.id, pageIndex: 1));
          }),
        ),
        BlocProvider(
          create: ((context) => GetIt.instance<KaraPartnerBloc>()
            ..add(KaraListLoaded(province: province, page: 0))),
        ),
      ],
      child: BlocBuilder<AnnonceBloc, AnnonceState>(
        builder: (context, state) {
          return BaseScreen(
            useDefaultAnnonceSponsPart: false,
            annoncePartner:
                (context.read<AppBloc>().state.annoncePartenaireMenu),
            annonceSponsor: (context.read<AppBloc>().state.annonceSponsorMenu),
            content: BlocBuilder<KaraPartnerBloc, KaraPartnerState>(
              builder: (context, state) {
                print("Annonces KARA : ${state.karaAnnonces.length}");
                return _builContentListNotScrollPremiumAds(context, state);
              },
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
            title: AppSearchBar(
              hintText:
                  context.read<MenuScreenBloc>().state.screenEntity?.title,
            ),
          );
        },
      ),
    );
  }

  Widget _builContentListNotScrollPremiumAds(
      BuildContext context, KaraPartnerState state) {
    Widget content = const SizedBox();
    if (state.karaListStatus == KaraListStatus.loaded) {
      content = SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            state.karaAnnonces.isNotEmpty
                ? ListView.builder(
                    padding: EdgeInsets.symmetric(
                      horizontal: mediumPadding,
                      vertical: smallPadding,
                    ),
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: state.karaAnnonces.length + 1,
                    itemBuilder: (context, index) {
                      if (index == state.karaAnnonces.length) {
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
                      return KaraAdsWidget(
                        isFree: state.karaAnnonces[index].isFree,
                        isMerci: initialMenuInfoScreen.reference ==
                            mahaNouvelleMenuRef,
                        reactionCount: state.karaAnnonces[index].reactionCount,
                        contact: state.karaAnnonces[index].contact,
                        menuRacineRef: state.karaAnnonces[index].menuRacineRef,
                        menuRacineName:
                            state.karaAnnonces[index].menuRacineName,
                        menuParentName:
                            state.karaAnnonces[index].menuParentName,
                        menuParentRef: state.karaAnnonces[index].menuParentRef,
                        isPremium: state.karaAnnonces[index].annonceType ==
                            AnnonceType.premium,
                        dateCreation: state.karaAnnonces[index].dateDeCreation,
                        id: state.karaAnnonces[index].id,
                        urlImage: (state.karaAnnonces[index].photos.isNotEmpty)
                            ? state
                                .karaAnnonces[index].photos.first.urlMiniature
                            : "",
                        title: state.karaAnnonces[index].title,
                        description:
                            state.karaAnnonces[index].descriptionCourte,
                        lieu: state.karaAnnonces[index].emplacement,
                        authorID: state.karaAnnonces[index].authorID,
                        authorName: (initialMenuInfoScreen.reference ==
                                blablaZoneMenuRef)
                            ? ""
                            : state.karaAnnonces[index].author,
                        onClick: () {
                          // AppRouter.go(context, RoutesNames.detailGlobal,
                          //     queryParameters: {
                          //       "id": state.karaAnnonces[index].id.toString(),
                          //       "name": state.karaAnnonces[index].title,
                          //     },
                          //     extra: context.read<AnnonceBloc>()
                          //       ..add(LoadAnnonceWithPartnerSponsor(
                          //           id: state.karaAnnonces[index].id
                          //               .toString())));
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
    } else if (state.karaListStatus == KaraListStatus.loading) {
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
        context
            .read<KaraPartnerBloc>()
            .add(KaraListLoaded(province: province, page: 0));
      },
    );
  }
}
