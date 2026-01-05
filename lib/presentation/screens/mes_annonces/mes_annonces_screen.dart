import 'package:MIPS/domain/domain.dart';
import 'package:MIPS/presentation/configurations/extension_for_localization.dart';
import 'package:MIPS/presentation/presentation.dart';
import 'package:MIPS/presentation/screens/base/base_screen.dart';
import 'package:MIPS/presentation/widgets/error_page_widget.dart';
import 'package:MIPS/presentation/widgets/normal_ads_global_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:ionicons/ionicons.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../../common/constants/constant.dart';
import '../../routes/route.dart';
import '../../routes/router.dart';
import '../../widgets/empty_list_widget.dart';
import '../../widgets/normal_ads_widget.dart';
import 'bloc/mes_annonces_screen_bloc.dart';

class MesAnnoncesScreen extends StatelessWidget {
  const MesAnnoncesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => GetIt.instance<MesAnnoncesScreenBloc>()
            ..add(LoadMesAnnonces(pageIndex: 1))
            ..add(LoadMesAnnoncesCount()),
        ),
        BlocProvider(
          create: (context) => GetIt.instance<AnnonceBloc>(),
        ),
      ],
      child: BlocBuilder<MesAnnoncesScreenBloc, MesAnnoncesScreenState>(
        builder: (context, state) {
          MesAnnoncesScreenState state =
              context.watch<MesAnnoncesScreenBloc>().state;
          Widget content = const SizedBox();
          if (state.mesAnnoncesStatus == MesAnnoncesStatus.loading) {
            content = const Center(child: AppLoadingWidget());
          } else if (state.mesAnnoncesStatus == MesAnnoncesStatus.error) {
            content = const CustomScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                slivers: [
                  SliverFillRemaining(
                    child: Center(
                      child: ErrorPageWidget(),
                    ),
                  ),
                ]);
          } else {
            content = state.mesAnnonces.isEmpty
                ? const EmptyListWidget(listType: ListType.mesAnnonces)
                : ListView.builder(
                    itemCount: state.mesAnnonces.length + 1,
                    padding: EdgeInsets.all(mediumPadding),
                    itemBuilder: (BuildContext context, int index) {
                      if (index == state.mesAnnonces.length) {
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
                                          .read<MesAnnoncesScreenBloc>()
                                          .add(LoadMoreMesAnnonces());
                                    }
                                  },
                                  child: const AppLoadingWidget(),
                                )
                              : const SizedBox(),
                        );
                      }
                      return NormalAdsGlobalWidget(
                        isFree: state.mesAnnonces[index].isWebsitePub,
                        dateLimit: state.mesAnnonces[index].dateLimit,
                        reactionCount: state.mesAnnonces[index].reactionCount,
                        menuRacineRef: state.mesAnnonces[index].menuRacineRef,
                        menuRacineName: state.mesAnnonces[index].menuRacineName,
                        menuParentName: state.mesAnnonces[index].menuParentName,
                        menuParentRef: state.mesAnnonces[index].menuParentRef,
                        isPremium: state.mesAnnonces[index].annonceType ==
                            AnnonceType.premium,
                        dateCreation: state.mesAnnonces[index].dateDeCreation,
                        id: state.mesAnnonces[index].id,
                        urlImage: (state.mesAnnonces[index].photos.isNotEmpty)
                            ? state.mesAnnonces[index].photos.first.urlMiniature
                            : "",
                        title: state.mesAnnonces[index].title,
                        description: state.mesAnnonces[index].descriptionCourte,
                        lieu: state.mesAnnonces[index].emplacement,
                        authorID: state.mesAnnonces[index].authorID,
                        authorName: state.mesAnnonces[index].author,
                        onClick: () {
                          AppRouter.go(context, RoutesNames.detailGlobal,
                              queryParameters: {
                                "id": state.mesAnnonces[index].id.toString(),
                                "name": state.mesAnnonces[index].title,
                              },
                              extra: context.read<AnnonceBloc>()
                                ..add(LoadAnnonceWithPartnerSponsor(
                                    id: state.mesAnnonces[index].id
                                        .toString())));
                          // AppRouter.go(context, RoutesNames.detail,
                          //         queryParameters: {
                          //           "id":
                          //               state.mesAnnonces[index].id.toString(),
                          //           "name": state.mesAnnonces[index].title
                          //         },
                          //         extra: GetIt.instance<AnnonceBloc>()
                          //           ..add(LoadAnnonce(
                          //               id: state.mesAnnonces[index].id
                          //                   .toString())))
                          //     .then((value) {
                          //   if (context.mounted) {
                          //     context
                          //         .read<MesAnnoncesScreenBloc>()
                          //         .add(LoadingAnnonceEvent());
                          //   }
                          // });
                        },
                      );
                    },
                  );
          }
          return BaseScreen(
            useDefaultAnnonceSponsPart: true,
            title: Text(
              '${context.appLoc.my_ads} (${state.mesAnnoncesCount})',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            appBarAction: const [],
            content: RefreshIndicator(
              child: content,
              onRefresh: () async {
                context
                    .read<MesAnnoncesScreenBloc>()
                    .add(LoadMesAnnonces(pageIndex: 1));
              },
            ),
            leading: IconButton(
                onPressed: () {
                  context.pop();
                },
                icon: Icon(
                  Ionicons.chevron_back,
                  color: Colors.black,
                )),
            backgroundColor: Colors.grey.shade200,
          );
        },
      ),
    );
  }
}
