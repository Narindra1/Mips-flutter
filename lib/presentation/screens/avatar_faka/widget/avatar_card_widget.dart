import 'package:MIPS/common/common.dart';
import 'package:MIPS/domain/entities/avatar.dart';
import 'package:MIPS/presentation/configurations/colors_list.dart';
import 'package:MIPS/presentation/configurations/extension_for_localization.dart';
import 'package:MIPS/presentation/routes/route.dart';
import 'package:MIPS/presentation/routes/router.dart';
import 'package:MIPS/presentation/screens/avatar_faka/bloc/avatar_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../widgets/loading_image_cache_widget.dart';

class AvatarCardWidget extends StatelessWidget {
  final Avatar avatar;

  const AvatarCardWidget({super.key, required this.avatar});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(mediumPadding),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(largePadding),
          color: Colors.white,
        ),
        padding: const EdgeInsets.all(largePadding),
        child: Column(
          children: [
            avatar.localImage == ""
                ? CachedNetworkImage(
                    imageUrl: avatar.urlImage,
                    fit: BoxFit.cover,
                    progressIndicatorBuilder: (context, url, progress) =>
                        const AspectRatio(
                            aspectRatio: 1, child: LoadingImageCacheWidget()),
                    errorWidget: (context, url, error) => const Icon(
                      Icons.error,
                      size: 42,
                    ),
                  )
                : Image.asset(avatar.localImage, fit: BoxFit.cover),
            const SizedBox(height: mediumPadding),
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  AppUtils.formatNumberWithSpaces(avatar.priceFakaAriary),
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(
                  width: smallPadding,
                ),
                Text(context.appLoc.ariary_unit,
                    style: Theme.of(context).textTheme.bodyMedium)
              ],
            ),
            const SizedBox(
              height: mediumPadding,
            ),
            Text(
              "${context.appLoc.mips_unit}:",
              // context.appLoc.bonus,
              style: Theme.of(context)
                  .textTheme
                  .titleSmall
                  ?.copyWith(color: tertiaryColor),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  width: 24,
                  height: 24,
                  mipsCoin,
                  fit: BoxFit.cover,
                ),
                const SizedBox(
                  width: smallPadding,
                ),
                Text(
                  AppUtils.formatNumberWithSpaces(avatar.priceEnFaka),
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall
                      ?.copyWith(color: tertiaryColor),
                ),
                // const SizedBox(
                //   width: smallPadding,
                // ),
                // Text(context.appLoc.mips_unit,
                //     style: Theme.of(context)
                //         .textTheme
                //         .bodySmall
                //         ?.copyWith(color: tertiaryColor)),
              ],
            ),
            const SizedBox(height: largePadding),
            SizedBox(
              height: 40,
              child: ElevatedButton(
                style: ButtonStyle(
                    shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)))),
                onPressed: () {
                  context
                      .read<AvatarBloc>()
                      .add(SelectedAvatarEvent(id: avatar.id));
                  AppRouter.go(context, RoutesNames.achatAvatarFinalisation,
                      extra: context.read<AvatarBloc>());
                },
                child: Text(context.appLoc.acheter_faka),
              ),
            )
          ],
        ),
      ),
    );
  }
}
