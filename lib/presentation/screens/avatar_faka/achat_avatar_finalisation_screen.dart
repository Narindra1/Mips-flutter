import 'package:MIPS/common/common.dart';
import 'package:MIPS/presentation/configurations/colors_list.dart';
import 'package:MIPS/presentation/configurations/extension_for_localization.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ionicons/ionicons.dart';

import '../../widgets/app_panel_widget.dart';
import '../../widgets/error_page_widget.dart';
import '../../widgets/loading_image_cache_widget.dart';
import '../../widgets/loading_widget.dart';
import '../base/base_screen.dart';
import 'bloc/avatar_bloc.dart';

class AchatAvatarFinalisationScreen extends StatefulWidget {
  const AchatAvatarFinalisationScreen({super.key});

  @override
  State<AchatAvatarFinalisationScreen> createState() =>
      _AchatAvatarFinalisationScreenState();
}

class _AchatAvatarFinalisationScreenState
    extends State<AchatAvatarFinalisationScreen> {
  int quantity = 1; // Quantié initial
  int paymentIndex = 0;

  void _incrementQuantity() {
    if (quantity < 9) {
      setState(() {
        quantity++;
      });
    }
  }

  void _decrementQuantity() {
    if (quantity > 1) {
      setState(() {
        quantity--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      content: BlocBuilder<AvatarBloc, AvatarState>(
        builder: (context, state) {
          Widget content = const SizedBox();
          if (state.status == Status.loading) {
            content = const Center(
              child: AppLoadingWidget(),
            );
          } else if (state.status == Status.loaded) {
            content = SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(largePadding),
                child: Column(
                  children: [
                    AppPanelWidget(
                      child: Padding(
                        padding: const EdgeInsets.all(largePadding),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Avatar Image
                            state.selectedAvatar!.localImage == ""
                                ? CachedNetworkImage(
                                    imageUrl: state.selectedAvatar!.urlImage,
                                    fit: BoxFit.cover,
                                    height: 250,
                                    width: 250,
                                    progressIndicatorBuilder:
                                        (context, url, progress) =>
                                            const LoadingImageCacheWidget(),
                                    errorWidget: (context, url, error) =>
                                        const Icon(
                                      Icons.error,
                                      size: 42,
                                    ),
                                  )
                                : Image.asset(
                                    state.selectedAvatar!.localImage,
                                    fit: BoxFit.cover,
                                    height: 250,
                                    width: 250,
                                  ),

                            const SizedBox(height: smallPadding),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  AppUtils.formatNumberWithSpaces(
                                      state.selectedAvatar!.priceFakaAriary),
                                  style:
                                      Theme.of(context).textTheme.displaySmall,
                                ),
                                Text(context.appLoc.ariary_unit,
                                    style:
                                        Theme.of(context).textTheme.titleLarge)
                              ],
                            ),
                            const SizedBox(height: largePadding),
                            // Quantity Selector
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  onPressed:
                                      quantity > 1 ? _decrementQuantity : null,
                                  icon: const Icon(Icons.remove_circle_outline),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 8),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    '$quantity',
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                IconButton(
                                  onPressed:
                                      quantity < 9 ? _incrementQuantity : null,
                                  icon: const Icon(Icons.add_circle_outline),
                                ),
                              ],
                            ),
                            const SizedBox(height: largePadding * 2),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const Spacer(),
                                    Text("$quantity x ",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium
                                            ?.copyWith(
                                              fontWeight: FontWeight.bold,
                                            )),
                                    Text(
                                        AppUtils.formatNumberWithSpaces(state
                                            .selectedAvatar!.priceFakaAriary),
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium
                                            ?.copyWith(
                                              fontWeight: FontWeight.bold,
                                            )),
                                    const SizedBox(
                                      width: mediumPadding,
                                    ),
                                    Text(context.appLoc.ariary_unit,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium
                                            ?.copyWith(
                                              fontWeight: FontWeight.bold,
                                            )),
                                  ],
                                ),
                                const Divider(
                                  color: tertiaryColor,
                                ),
                                const SizedBox(height: 8),

                                // Total Price
                                Row(
                                  children: [
                                    Text(
                                      "${context.appLoc.total}:",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge
                                          ?.copyWith(
                                              color: tertiaryColor,
                                              fontWeight: FontWeight.bold),
                                    ),
                                    const Spacer(),
                                    Text(
                                      AppUtils.formatNumberWithSpaces(state
                                              .selectedAvatar!.priceFakaAriary *
                                          quantity),
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge
                                          ?.copyWith(
                                              fontWeight: FontWeight.bold,
                                              color: tertiaryColor),
                                    ),
                                    const SizedBox(
                                      width: mediumPadding,
                                    ),
                                    Text(context.appLoc.ariary_unit,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge
                                            ?.copyWith(
                                                fontWeight: FontWeight.bold,
                                                color: tertiaryColor))
                                  ],
                                ),
                                const SizedBox(
                                  height: mediumPadding,
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${context.appLoc.mips_unit}:",
                                      // context.appLoc.bonus,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium
                                          ?.copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                    const Spacer(),
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
                                        AppUtils.formatNumberWithSpaces(
                                            state.selectedAvatar!.priceEnFaka *
                                                quantity),
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium
                                            ?.copyWith(
                                              fontWeight: FontWeight.bold,
                                            )),
                                    // Text(context.appLoc.mips_unit,
                                    //     style: Theme.of(context)
                                    //         .textTheme
                                    //         .titleMedium
                                    //         ?.copyWith(
                                    //           fontWeight: FontWeight.bold,
                                    //         )),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: largePadding,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: mediumPadding,
                    ),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text(context.appLoc.option_paiement,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ))),
                    AppPanelWidget(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          RadioListTile(
                            value: 0,
                            groupValue: paymentIndex,
                            onChanged: (value) {
                              setState(() {
                                paymentIndex = value!;
                              });
                            },
                            title: Row(
                              children: [
                                const Text(
                                  "MVola",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                const Spacer(),
                                Image.asset(
                                  "assets/imgs/mvolalogo.png",
                                  width: 48,
                                  height: 48,
                                ),
                              ],
                            ),
                          ),
                          RadioListTile(
                            value: 1,
                            groupValue: paymentIndex,
                            onChanged: (value) {
                              setState(() {
                                paymentIndex = value!;
                              });
                            },
                            title: Row(
                              children: [
                                const Text(
                                  "Orange Money",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Spacer(),
                                Image.asset(
                                  "assets/imgs/orange_money.png",
                                  width: 48,
                                  height: 48,
                                ),
                              ],
                            ),
                          ),
                          RadioListTile(
                            value: 2,
                            groupValue: paymentIndex,
                            onChanged: (value) {
                              setState(() {
                                paymentIndex = value!;
                              });
                            },
                            title: Row(
                              children: [
                                const Text(
                                  "Airtel Money",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  width: mediumPadding,
                                ),
                                Spacer(),
                                Image.asset(
                                  "assets/imgs/airtel_money.png",
                                  width: 48,
                                  height: 48,
                                ),
                                //
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: largePadding,
                    ),
                    SizedBox(
                      height: 40,
                      width: MediaQuery.of(context).size.width,
                      child: FilledButton(
                        style: ButtonStyle(
                            shape: WidgetStatePropertyAll(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16)))),
                        onPressed: null,
                        child: Text(
                          context.appLoc.payer,
                          style: TextStyle(
                            fontFamily: "Pretendard",
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: mediumPadding,
                    ),
                  ],
                ),
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
              onRefresh: () async {
                context.read<AvatarBloc>().add(LoadAvatarListEvent());
              },
              child: content);
        },
      ),
      title: Text(
        "Achat d'un ${context.appLoc.avatar}",
        style: TextStyle(
          fontFamily: "Pretendard",
          color: Colors.black,
        ),
      ),
      leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: Icon(
            Ionicons.chevron_back,
            color: Colors.black,
          )),
    );
  }
}
