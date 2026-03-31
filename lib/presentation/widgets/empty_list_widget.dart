import 'package:MIPS/common/common.dart';
import 'package:MIPS/presentation/configurations/extension_for_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum ListType {
  news,
  annonce,
  mesAnnonces,
  favoris,
  annonceSearch,
  message,
  followers,
  followings,
  availableSoon
}

class EmptyListWidget extends StatelessWidget {
  final ListType listType;

  const EmptyListWidget({super.key, this.listType = ListType.annonce});

  @override
  Widget build(BuildContext context) {
    Widget illustrationWidget = SizedBox();
    String labelText = "";
    switch (listType) {
      case ListType.message:
        labelText = context.appLoc.empty_message_list;
        illustrationWidget = SizedBox(
            width: 250,
            height: 150,
            child: SvgPicture.asset("assets/imgs/illu_empty_message.svg"));
        break;
      case ListType.mesAnnonces:
        labelText = context.appLoc.empty_mes_annonces_list;
        illustrationWidget = SizedBox(
            width: 250,
            height: 250,
            child: SvgPicture.asset("assets/imgs/illu_ads.svg"));
        break;
      case ListType.favoris:
        labelText = context.appLoc.empty_mes_favoris_list;
        illustrationWidget = SizedBox(
            width: 250,
            height: 250,
            child: SvgPicture.asset("assets/imgs/illu_ads.svg"));
        break;
      case ListType.followers:
        labelText = context.appLoc.noone_follow_me_title;
        illustrationWidget = SizedBox(
            width: 250,
            height: 250,
            child: SvgPicture.asset("assets/imgs/illu_followers.svg"));
        break;
      case ListType.followings:
        labelText = context.appLoc.follow_anyone_title;
        illustrationWidget = SizedBox(
            width: 250,
            height: 250,
            child: SvgPicture.asset("assets/imgs/illu_followings.svg"));
        break;
      case ListType.availableSoon:
        labelText = context.appLoc.available_soon;
        illustrationWidget = SizedBox(
            width: 250,
            height: 250,
            child: SvgPicture.asset("assets/imgs/illu_soon.svg"));
        break;
      case ListType.annonceSearch:
        labelText = context.appLoc.empty_result;
        illustrationWidget = SizedBox(
            width: 250,
            height: 250,
            child: SvgPicture.asset("assets/imgs/illu_search.svg"));
        break;
      case ListType.news:
        labelText = "Pas de nouvelles";
        illustrationWidget = SizedBox(
            width: 250,
            height: 250,
            child: SvgPicture.asset("assets/imgs/illu_news.svg"));
        break;
      default:
        labelText = context.appLoc.empty_list_announce;
        illustrationWidget = SizedBox(
            width: 250,
            height: 250,
            child: SvgPicture.asset("assets/imgs/illu_ads.svg"));
    }
    return Container(
      // color: Colors.white,

      padding: const EdgeInsets.all(largePadding),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          illustrationWidget,
          Text(
            labelText,
            style: Theme.of(context).textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
