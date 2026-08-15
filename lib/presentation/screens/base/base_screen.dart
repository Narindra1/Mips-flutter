import 'package:mips/presentation/widgets/annonce_partner_spons_widget.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/entities/annonce.dart';
import '../../bloc/app_bloc.dart';
import '../../bloc/menu_screen_bloc.dart';

class BaseScreen extends StatelessWidget {
  final Widget content;
  final List<Widget>? appBarAction;
  final Widget? leading;
  final Widget? fab;
  final Widget title;
  final bool resizeToAvoidBottomInset;
  final Annonce? annoncePartner;
  final Annonce? annonceSponsor;
  final Color? backgroundColor;
  final bool useDefaultAnnonceSponsPart;

  const BaseScreen({
    super.key,
    required this.content,
    this.appBarAction,
    this.leading,
    this.backgroundColor,
    required this.title,
    this.annonceSponsor,
    this.annoncePartner,
    this.resizeToAvoidBottomInset = false,
    this.useDefaultAnnonceSponsPart = true,
    this.fab,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: fab,
      backgroundColor: backgroundColor,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        titleSpacing: 2,
        actions: appBarAction,
        title: title,
        leading: leading,
      ),
      body: Stack(
        children: [
          LayoutBuilder(
            builder: (_, constraints) {
              Annonce? annonceP = annoncePartner;
              Annonce? annonceS = annonceSponsor;
              if (annoncePartner == null || annonceSponsor == null) {
                if (context.read<MenuScreenBloc?>() != null &&
                    context
                            .read<MenuScreenBloc>()
                            .state
                            .screenEntity!
                            .reference !=
                        "0000") {
                  annonceP = context
                      .read<AppBloc>()
                      .state
                      .annoncePartenaireMenu;
                  annonceS = context.read<AppBloc>().state.annonceSponsorMenu;
                } else {
                  if (useDefaultAnnonceSponsPart) {
                    annonceP = context.read<AppBloc>().state.annoncePartenaire;
                    annonceS = context.read<AppBloc>().state.annonceSponsor;
                  }
                }
              }

              return Column(
                children: [
                  AnnoncePartnerSponsWidget(
                    annonce: annonceP,
                    constraints: constraints,
                  ),
                  Expanded(child: content),
                  AnnoncePartnerSponsWidget(
                    annonce: annonceS,
                    constraints: constraints,
                  ),
                ],
              );
            },
          ),
          if (MediaQuery.of(context).systemGestureInsets.left <= 0)
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onHorizontalDragUpdate: (details) {
                  if (details.primaryDelta != null &&
                      details.primaryDelta! < -7) {
                    if (context.canPop()) {
                      context.pop(context);
                    } // go_router back
                  }
                },
                child: Container(
                  color: Colors.transparent,
                  width: 10,
                  height: double.infinity,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
