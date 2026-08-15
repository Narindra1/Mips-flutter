import 'package:mips/domain/domain.dart';
import 'package:mips/presentation/bloc/app_bloc.dart';
import 'package:mips/presentation/bloc/menu_screen_bloc.dart';
import 'package:mips/presentation/screens/base/base_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BaseMenuScreen extends StatelessWidget {
  final Widget content;
  final Widget? leading;
  final Widget title;
  final List<Widget>? menuAction;
  final Color? backgroundColor;

  const BaseMenuScreen({
    super.key,
    required this.content,
    this.leading,
    this.backgroundColor,
    required this.menuAction,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    Annonce? annoncePartner;
    Annonce? annonceSponsor;
    if (context.read<MenuScreenBloc?>() != null) {
      if (context.read<MenuScreenBloc>().state.status == Status.loaded) {
        annoncePartner = context
            .read<MenuScreenBloc>()
            .state
            .screenEntity
            ?.annoncePartner;
        annonceSponsor = context
            .read<MenuScreenBloc>()
            .state
            .screenEntity
            ?.annonceSponsor;
      } else {
        annoncePartner = context.read<AppBloc>().state.annoncePartenaire;
        annonceSponsor = context.read<AppBloc>().state.annonceSponsor;
      }
    }

    return BaseScreen(
      useDefaultAnnonceSponsPart: false,
      annoncePartner: annoncePartner,
      annonceSponsor: annonceSponsor,
      content: content,
      title: title,
      backgroundColor: backgroundColor,
      appBarAction: menuAction,
    );
  }
}
