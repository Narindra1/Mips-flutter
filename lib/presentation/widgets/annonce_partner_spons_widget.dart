import 'package:mips/presentation/configurations/extension_for_localization.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../common/constants/constant.dart';
import '../../domain/entities/annonce.dart';
import '../bloc/annonce_bloc.dart';
import '../configurations/colors_list.dart';
import '../routes/route.dart';
import '../routes/router.dart';
import 'loading_image_cache_widget.dart';
import 'message_displayer_utils.dart';

class AnnoncePartnerSponsWidget extends StatelessWidget {
  final Annonce? annonce;
  final BoxConstraints constraints;

  const AnnoncePartnerSponsWidget({
    super.key,
    this.annonce,
    required this.constraints,
  });

  @override
  Widget build(BuildContext context) {
    if (annonce == null) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: largePadding),
        height: 50,
        width: constraints.maxWidth,
        color: Colors.blue.shade700,
        // color: Color(0xFF160D9D),
        child: Center(
          child: Row(
            children: [
              InkWell(
                onTap: () {
                  AppRouter.go(context, RoutesNames.mahaPartenaireList);
                },
                child: Container(
                  padding: const EdgeInsets.all(mediumPadding),
                  decoration: BoxDecoration(
                    color: secondaryColor,
                    border: Border.all(color: secondaryColor),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Text(
                    context.appLoc.become_partner,
                    style: const TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: mediumPadding),
              Expanded(
                child: Text(
                  context.appLoc.announce_partner,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return InkWell(
        onTap: () {
          if (annonce!.isWebsitePub) {
            MessageDisplayerUtils.showCustomHTLMpage(
              context: context,
              urlHtml: annonce!.customHtmlUrl,
            );
          } else {
            AppRouter.go(
              context,
              RoutesNames.detail,
              queryParameters: {
                "id": annonce!.id.toString(),
                "name": annonce!.title,
              },
              extra: GetIt.instance<AnnonceBloc>()
                ..add(LoadAnnonce(id: annonce!.id.toString())),
            );
          }
        },
        child: Container(
          height: 50,
          width: constraints.maxWidth,
          // color: Color(0xFF160D9D),
          color: Colors.blue.shade700,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: mediumPadding,
                  right: mediumPadding,
                ),
                child: SizedBox(
                  width: 70,
                  height: 45,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(mediumPadding),
                    child: SizedBox.fromSize(
                      size: const Size(70, 45),
                      child: annonce!.photos.isEmpty
                          ? Image.asset(
                              "assets/imgs/ic_mahafaka.png",
                              fit: BoxFit.cover,
                            )
                          : CachedNetworkImage(
                              imageUrl: annonce!.photos.first.url,
                              fit: BoxFit.cover,
                              progressIndicatorBuilder:
                                  (context, url, progress) =>
                                      const LoadingImageCacheWidget(),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error, size: 42),
                            ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  annonce!.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
}
