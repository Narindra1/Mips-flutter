import 'package:MIPS/domain/domain.dart';
import 'package:MIPS/presentation/configurations/colors_list.dart';
import 'package:MIPS/presentation/configurations/extension_for_localization.dart';
import 'package:MIPS/presentation/screens/maha_partenaire/bloc/maha_partenaire_bloc.dart';
import 'package:MIPS/presentation/screens/base/base_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:ionicons/ionicons.dart';

import '../../../common/constants/constant.dart';
import '../../../common/utils/app_utils.dart';
import '../../bloc/annonce_bloc.dart';
import '../../routes/route.dart';
import '../../routes/router.dart';
import '../../widgets/error_page_widget.dart';
import '../../widgets/loading_widget.dart';
import '../../widgets/message_displayer_utils.dart';

class MahaPartenaireScreen extends StatelessWidget {
  const MahaPartenaireScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      content: _buildContentList(context),
      title: Text(
        context.appLoc.maha_partenaire_title,
        style: Theme.of(context).textTheme.titleLarge,
      ),
      leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: Icon(
            Ionicons.chevron_back,
            color: Colors.black,
          )),
      backgroundColor: Colors.white,
    );
  }

  Widget _buildContentList(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.instance<MahaPartenaireBloc>()
        ..add(LoadMahaPartenaireListEvent()),
      child: BlocBuilder<MahaPartenaireBloc, MahaPartenaireState>(
        builder: (context, state) {
          Widget content = const SizedBox();
          if (state.status == Status.loading) {
            content = const Center(
              child: AppLoadingWidget(),
            );
          } else if (state.status == Status.loaded) {
            content = SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: state.mahaPartenaireElts.length,
                itemBuilder: (context, index) {
                  return MahaPartenaireEltWidget(
                    idMenu: state.mahaPartenaireElts[index].idMenu,
                    colorTitle: AppUtils.stringToColor(
                        colorsStringList[index % colorsStringList.length]),
                    title: state.mahaPartenaireElts[index].titleMenu,
                    annonceTarifOptionPartenaire: state
                        .mahaPartenaireElts[index].annoncePartenaireTarifOption,
                    annonceTarifOptionSponsor: state
                        .mahaPartenaireElts[index].annonceSponsorTarifOption,
                  );
                },
              ),
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
                  .read<MahaPartenaireBloc>()
                  .add(LoadMahaPartenaireListEvent());
            },
          );
        },
      ),
    );
  }
}

class MahaPartenaireEltWidget extends StatelessWidget {
  final String title;
  final int idMenu;
  final Color colorTitle;
  final AnnonceTarifOption annonceTarifOptionPartenaire;
  final AnnonceTarifOption annonceTarifOptionSponsor;

  const MahaPartenaireEltWidget(
      {super.key,
      required this.title,
      required this.colorTitle,
      required this.annonceTarifOptionPartenaire,
      required this.annonceTarifOptionSponsor,
      required this.idMenu});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: mediumPadding),
      padding: const EdgeInsets.all(largePadding),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(largePadding),
          color: Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(mediumPadding),
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    colorTitle,
                    colorTitle.withOpacity(.88),
                    colorTitle.withOpacity(1),
                    colorTitle.withOpacity(.88),
                    colorTitle,
                    colorTitle.withOpacity(.7),
                  ],
                ),
                color: colorTitle,
                // color: Colors.white,
                borderRadius:
                    const BorderRadius.all(Radius.circular(mediumPadding))),
            child: Text(
              "[ $title ]",
              style: const TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),
          const SizedBox(
            height: smallPadding,
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  context.appLoc.ads_up,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                width: mediumPadding,
              ),
              _getInfoAdWidget(context, annonceTarifOptionPartenaire),
            ],
          ),
          const SizedBox(
            height: mediumPadding,
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  context.appLoc.ads_down,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                width: mediumPadding,
              ),
              _getInfoAdWidget(context, annonceTarifOptionSponsor),
            ],
          ),
        ],
      ),
    );
  }

  Widget _getInfoAdWidget(
      BuildContext context, AnnonceTarifOption annonceTarifOption) {
    return annonceTarifOption.isAvailable
        ? Expanded(
            flex: 2,
            child: Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 40,
                    child: FilledButton(
                      style: ButtonStyle(
                          shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(mediumPadding))),
                          backgroundColor:
                              WidgetStatePropertyAll(secondaryColor)),
                      onPressed: () {
                        MessageDisplayerUtils.showContactMips(context);
                      },
                      child: Text(
                        context.appLoc.reserver,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ),

                  // InkWell(
                  //   onTap: () {
                  //     if (context.read<AppBloc>().state.isLogged) {
                  //       AppRouter.go(context, RoutesNames.demandePubPartenaire,
                  //           queryParameters: {
                  //             "idMenu": idMenu.toString(),
                  //             "title": context.appLoc.maha_partenaire_title,
                  //             "type": annonceTarifOption.annonceType ==
                  //                     AnnonceType.partenaire
                  //                 ? "PARTENAIRE"
                  //                 : "SPONSOR"
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
                  //   child: Container(
                  //     height: 40,
                  //     alignment: Alignment.center,
                  //     padding: const EdgeInsets.all(smallPadding),
                  //     decoration: BoxDecoration(
                  //         border: Border.all(
                  //           color: Colors.grey,
                  //           width: 1,
                  //         ),
                  //         borderRadius: BorderRadius.circular(mediumPadding)),
                  //     child: Text(context.appLoc.reserver),
                  //   ),
                  // ),
                ),
                // const SizedBox(
                //   width: mediumPadding,
                // ),
                // Expanded(
                //   child: Text(
                //       ("(${annonceTarifOption.tarifs.first.getReadablePeriode()}: ${annonceTarifOption.tarifs.first.getPriceInFakaMin()} KARA)")),
                // ),
              ],
            ),
          )
        : Expanded(
            flex: 2,
            child: InkWell(
              onTap: () {
                AppRouter.go(context, RoutesNames.detail,
                    queryParameters: {
                      "id": annonceTarifOption.annonce?.id.toString() ?? "0",
                      "name": annonceTarifOption.annonce?.title ?? ""
                    },
                    extra: GetIt.instance<AnnonceBloc>()
                      ..add(LoadAnnonce(
                          id: annonceTarifOption.annonce?.id.toString() ??
                              "0")));
              },
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(mediumPadding)),
                padding: const EdgeInsets.all(mediumPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${annonceTarifOption.annonce?.title}",
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.start,
                    ),
                    Text("~${annonceTarifOption.getReadableAvailabilityMin()}")
                  ],
                ),
              ),
            ),
          );
  }
}
