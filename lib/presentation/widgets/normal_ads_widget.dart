import 'package:MIPS/common/common.dart';
import 'package:MIPS/presentation/bloc/app_bloc.dart';
import 'package:MIPS/presentation/configurations/extension_for_localization.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:colorful_iconify_flutter/icons/noto.dart';
import 'package:super_banners/super_banners.dart';
import '../configurations/colors_list.dart';
import 'loading_image_cache_widget.dart';

class NormalAdsWidget extends StatelessWidget {
  final int id;
  final String dateCreation;
  final String title;
  final String description;
  final String lieu;
  final int authorID;
  final String authorName;
  final String urlImage;
  final String dateLimit;
  final int reactionCount;
  final bool isMerci;
  final bool isPremium;
  final bool isFree;
  final Function() onClick;

  const NormalAdsWidget(
      {super.key,
      required this.id,
      required this.title,
      required this.description,
      required this.lieu,
      required this.isFree,
      this.dateLimit = "",
      required this.authorID,
      required this.authorName,
      required this.dateCreation,
      required this.urlImage,
      required this.isPremium,
      required this.reactionCount,
      this.isMerci = false,
      required this.onClick});

  @override
  Widget build(BuildContext context) {
    bool isUrlPhotoInvalid = urlImage == "";
    return Card(
        margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
        // margin: const EdgeInsets.all(1),
        // shape: RoundedRectangleBorder(
        //   borderRadius: BorderRadius.circular(largePadding),
        // ),
        shadowColor: Colors.black26,
        child: SizedBox(
          child: Stack(
            children: [
              InkWell(
                onTap: onClick,
                child: Padding(
                  padding: const EdgeInsets.all(0),
                  // padding: const EdgeInsets.all(smallPadding),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(0),
                        // padding: const EdgeInsets.only(
                        //     left: smallPadding, right: smallPadding),
                        child: SizedBox(
                          width: 100,
                          height: 65,
                          child: Padding(
                            padding: const EdgeInsets.all(0),
                            // padding:
                            //     const EdgeInsets.only(left: 12.0, right: 12.0),
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.circular(mediumPadding),
                              child: SizedBox.fromSize(
                                  // size: const Size(100, 65),
                                  child: isUrlPhotoInvalid
                                      ? Image.asset(
                                          "assets/imgs/ic_mahafaka.png",
                                          fit: BoxFit.cover,
                                        )
                                      : CachedNetworkImage(
                                          imageUrl: urlImage,
                                          fit: BoxFit.cover,
                                          progressIndicatorBuilder: (context,
                                                  url, progress) =>
                                              const LoadingImageCacheWidget(),
                                          errorWidget: (context, url, error) =>
                                              const Icon(
                                            Icons.error,
                                            size: 42,
                                          ),
                                        )),
                            ), // Display leading widget
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Text(
                            //   title,
                            //   style: Theme.of(context).textTheme.titleSmall,
                            //   maxLines: 1,
                            //   overflow: TextOverflow.ellipsis,
                            // ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: Text(
                                    title,
                                    style:
                                        Theme.of(context).textTheme.titleSmall,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                // if (isPremium)
                                //   Container(
                                //     margin: const EdgeInsets.symmetric(
                                //         horizontal: 4),
                                //     padding: const EdgeInsets.symmetric(
                                //         horizontal: 2),
                                //     decoration: BoxDecoration(
                                //       color: Colors.grey,
                                //       borderRadius: BorderRadius.circular(4),
                                //     ),
                                //     child: Text(
                                //       "Premium",
                                //       style: TextStyle(
                                //         fontSize: 10,
                                //         fontWeight: FontWeight.bold,
                                //         color: Colors.white,
                                //       ),
                                //     ),
                                //   ),
                              ],
                            ),
                            const SizedBox(height: smallPadding),
                            RichText(
                              text: TextSpan(
                                text: "",
                                style: Theme.of(context).textTheme.titleSmall,
                                children: [
                                  (context.read<AppBloc>().state.isLogged &&
                                          (context
                                                  .read<AppBloc>()
                                                  .state
                                                  .user!
                                                  .id ==
                                              authorID))
                                      ? TextSpan(
                                          text: context
                                              .read<AppBloc>()
                                              .state
                                              .user!
                                              .pseudo,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall
                                              ?.copyWith(color: tertiaryColor))
                                      : TextSpan(
                                          text: authorName,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall
                                              ?.copyWith(color: tertiaryColor)),
                                  TextSpan(
                                      text:
                                          " • ${AppUtils.getDate(dateCreation)}  ",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(color: tertiaryColor)),
                                  if (!isFree && dateLimit != "")
                                    WidgetSpan(
                                        alignment:
                                            PlaceholderAlignment.baseline,
                                        baseline: TextBaseline.alphabetic,
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: smallPadding),
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  border: Border.all(
                                                      color:
                                                          Colors.grey.shade300),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          smallPadding)),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Container(
                                                    height: smallPadding,
                                                    width: smallPadding,
                                                    margin:
                                                        const EdgeInsets.only(
                                                            right:
                                                                smallPadding),
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                smallPadding),
                                                        color: Colors.red),
                                                  ),
                                                  Text(
                                                      context.appLoc
                                                          .sondage_fin(AppUtils
                                                              .formatDateWithHHMMMin(
                                                                  dateLimit)),
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodySmall
                                                          ?.copyWith(
                                                              color: Colors
                                                                  .black54,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                ],
                                              ),
                                            ),
                                          ],
                                        )),
                                ],
                              ),
                            ),
                            const SizedBox(height: smallPadding),
                            Row(
                              children: [
                                if (reactionCount >= 0)
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      isMerci
                                          ? const Iconify(Noto.folded_hands,
                                              size: 14)
                                          : const Icon(
                                              Icons.thumb_up_outlined,
                                              size: 14,
                                            ),
                                      const SizedBox(
                                        width: smallPadding,
                                      ),
                                      Text(
                                        "${reactionCount}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall
                                            ?.copyWith(
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                      ),
                                      const SizedBox(
                                        width: mediumPadding,
                                      ),
                                    ],
                                  ),
                                if (lieu != "")
                                  Expanded(
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        const Icon(
                                          Icons.place_outlined,
                                          size: 14,
                                        ),
                                        const SizedBox(
                                          width: smallPadding,
                                        ),
                                        Expanded(
                                            child: Text(
                                          lieu,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall
                                              ?.copyWith(
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                        )),
                                      ],
                                    ),
                                  )
                              ],
                            ),
                          ],
                        ),
                      ),
                      // const Padding(
                      //   // Padding for the trailing widget
                      //   padding: const EdgeInsets.all(smallPadding),
                      //   child: Icon(
                      //     Icons.keyboard_arrow_right,
                      //     color: tertiaryColor,
                      //   ), // Display trailing widget
                      // )
                    ],
                  ),
                ),
              ),
              if (isPremium)
                const Align(
                  alignment: Alignment.centerRight,
                  child: CornerBanner(
                    bannerPosition: CornerBannerPosition.topRight,
                    bannerColor: Colors.grey,
                    child: Text(
                      "Premium",
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                        fontSize: 11,
                      ),
                    ),
                  ),
                )
            ],
          ),
        ));
  }
}
