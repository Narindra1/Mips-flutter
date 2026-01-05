import 'package:MIPS/presentation/configurations/extension_for_localization.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../common/common.dart';
import 'loading_image_cache_widget.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/subway.dart';

class VIPAdsWidgets extends StatelessWidget {
  final int id;
  final String title;
  final String url;
  final String description;
  final Function() onClick;
  final bool emptyMode;

  const VIPAdsWidgets(
      {super.key,
      required this.id,
      required this.title,
      required this.url,
      required this.description,
      this.emptyMode = false,
      required this.onClick});

  factory VIPAdsWidgets.empty({required Function() onClick}) {
    return VIPAdsWidgets(
      id: 0,
      title: "",
      url: "",
      description: "",
      emptyMode: true,
      onClick: onClick,
    );
  }

  @override
  Widget build(BuildContext context) {
    return emptyMode
        ? Padding(
            padding: const EdgeInsets.all(smallPadding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: onClick,
                  child: Container(
                    constraints: const BoxConstraints(
                      maxWidth: 114,
                      maxHeight: 92,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey.shade400),
                      borderRadius: BorderRadius.circular(mediumPadding),
                    ),
                    child: Center(
                        child: Iconify(
                      Subway.add_1,
                      size: 58,
                      color: Colors.grey.shade400,
                    )),
                  ),
                ),
                const Center(),
              ],
            ),
          )
        : InkWell(
            onTap: () {
              if (id <= 0) {
                AppUtils.showDebugLog(
                    runtimeType, "Mahafaka default app clicked");
              } else {
                onClick();
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(smallPadding),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    constraints: const BoxConstraints(
                      maxWidth: 124,
                      maxHeight: 100,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade400),
                      borderRadius: BorderRadius.circular(mediumPadding),
                    ),
                    child: SizedBox.fromSize(
                      size: const Size(104, 90),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(mediumPadding),
                        child: url == ""
                            ? Image.asset(
                                "assets/imgs/ic_mahafaka.png",
                                fit: BoxFit.cover,
                              )
                            : CachedNetworkImage(
                                imageUrl: url,
                                fit: BoxFit.cover,
                                progressIndicatorBuilder:
                                    (context, url, progress) =>
                                        const LoadingImageCacheWidget(),
                                errorWidget: (context, url, error) =>
                                    const Icon(
                                  Icons.error,
                                  size: 42,
                                ),
                              ),
                      ),
                    ),
                  ),
                  Text(
                    title.isEmpty
                        ? context.appLoc.ads_default_title.split(" - ").first
                        : title,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          );
  }
}
