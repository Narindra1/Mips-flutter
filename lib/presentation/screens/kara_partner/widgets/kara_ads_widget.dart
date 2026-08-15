import 'package:mips/common/common.dart';
import 'package:mips/presentation/bloc/app_bloc.dart';
import 'package:mips/presentation/configurations/colors_list.dart';
import 'package:mips/presentation/configurations/extension_for_localization.dart';
import 'package:mips/presentation/widgets/message_displayer_utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mips/presentation/widgets/loading_image_cache_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class KaraAdsWidget extends StatelessWidget {
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
  final String contact;
  final bool isMerci;
  final bool isPremium;
  final bool isFree;
  final bool? saved;
  final String? menuRacineRef;
  final String? menuRacineName;
  final String? menuParentRef;
  final String? menuParentName;
  final Function() onClick;

  const KaraAdsWidget({
    super.key,
    required this.id,
    required this.title,
    required this.description,
    required this.contact,
    required this.lieu,
    required this.isFree,
    this.dateLimit = "",
    required this.authorID,
    required this.authorName,
    required this.dateCreation,
    required this.urlImage,
    required this.isPremium,
    required this.reactionCount,
    this.menuRacineRef,
    this.menuRacineName,
    this.menuParentRef,
    this.menuParentName,
    this.isMerci = false,
    this.saved = false,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    bool isUrlPhotoInvalid = urlImage == "";
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 2),
      // shape: RoundedRectangleBorder(
      //     side: BorderSide(color: Colors.grey.shade300)),
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
                            borderRadius: BorderRadius.circular(mediumPadding),
                            child: SizedBox.fromSize(
                              size: const Size(100, 65),
                              child: isUrlPhotoInvalid
                                  ? Image.asset(
                                      "assets/imgs/ic_mahafaka.png",
                                      fit: BoxFit.cover,
                                    )
                                  : CachedNetworkImage(
                                      imageUrl: urlImage,
                                      fit: BoxFit.cover,
                                      progressIndicatorBuilder:
                                          (context, url, progress) =>
                                              const LoadingImageCacheWidget(),
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.error, size: 42),
                                    ),
                            ),
                          ), // Display leading widget
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Text(
                                  title,
                                  style: Theme.of(context).textTheme.titleSmall,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: smallPadding),
                          RichText(
                            text: TextSpan(
                              text: "",
                              style: Theme.of(context).textTheme.titleSmall,
                              children: [
                                (menuParentRef != blablaZoneMenuRef)
                                    ? TextSpan(
                                        text: "N°$id",
                                        style: Theme.of(
                                          context,
                                        ).textTheme.bodySmall,
                                      )
                                    : (context.read<AppBloc>().state.isLogged &&
                                          (context
                                                  .read<AppBloc>()
                                                  .state
                                                  .user!
                                                  .id ==
                                              authorID))
                                    ? TextSpan(
                                        text: authorName,
                                        style: Theme.of(
                                          context,
                                        ).textTheme.bodySmall,
                                      )
                                    : TextSpan(),
                                TextSpan(
                                  text: " - $lieu",
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: smallPadding),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                AppUtils.formatNumber(contact),
                                style: Theme.of(context).textTheme.bodySmall
                                    ?.copyWith(overflow: TextOverflow.ellipsis),
                              ),
                              SizedBox(
                                height: 20,
                                child: OutlinedButton(
                                  style: ButtonStyle(
                                    shape: WidgetStatePropertyAll(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                          mediumPadding,
                                        ),
                                      ),
                                    ),
                                    backgroundColor: WidgetStatePropertyAll(
                                      tertiaryColor,
                                    ),
                                  ),
                                  onPressed: () async {
                                    try {
                                      final Uri url = Uri(
                                        scheme: 'tel',
                                        path: contact,
                                      );

                                      if (await canLaunchUrl(url)) {
                                        await launchUrl(
                                          url,
                                          mode: LaunchMode.externalApplication,
                                        );
                                      } else {
                                        throw 'Could not launch $url';
                                      }
                                    } catch (e) {
                                      if (context.mounted) {
                                        MessageDisplayerUtils.showToastMessage(
                                          context.appLoc.not_supported,
                                        );
                                      }
                                    }
                                  },
                                  child: Text(
                                    context.appLoc.call,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                        ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
