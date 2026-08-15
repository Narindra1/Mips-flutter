import 'package:mips/presentation/presentation.dart';
import 'package:mips/presentation/routes/route.dart';
import 'package:mips/presentation/routes/router.dart';
import 'package:mips/presentation/widgets/cgu_dialog.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:mips/presentation/configurations/extension_for_localization.dart';
import '../../common/common.dart';
import '../../domain/entities/annonce.dart';
import '../configurations/colors_list.dart';

import 'custom_html_dialog.dart';

enum MessageType {
  errorOperation,
  favsAdded,
  favsRemoved,
  connectionLost,
  connectionRestored,
  welcomeUser,
  beSponsorPartner,
}

class MessageDisplayerUtils {
  static void showConnectionChangeToast(ConnectionStatus connectionStatus) {
    try {
      BuildContext? context = GlobalContextService.snackbarKey.currentContext;
      if (context != null) {
        if (connectionStatus == ConnectionStatus.disconnected) {
          BotToast.showCustomText(
            onlyOne: true,
            ignoreContentClick: false,
            duration: const Duration(days: 1),
            animationDuration: const Duration(milliseconds: 100),
            animationReverseDuration: const Duration(milliseconds: 100),
            toastBuilder: (cancelFunc) => Card(
              surfaceTintColor: Colors.red,
              elevation: 4,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(mediumPadding),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.signal_wifi_connected_no_internet_4_outlined,
                    ),
                    const SizedBox(width: smallPadding),
                    Text(
                      context.appLoc.toast_disconnected,
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium!.copyWith(color: Colors.black87),
                    ),
                    const SizedBox(width: largePadding),
                    IconButton(
                      onPressed: () {
                        BotToast.cleanAll();
                      },
                      icon: const Icon(Icons.close),
                    ),
                  ],
                ),
              ),
            ),
          );
        } else if (connectionStatus == ConnectionStatus.connected) {
          BotToast.cleanAll();
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print("unable to show toast ${e.toString()}");
      }
    }
  }

  static void showContactMips(BuildContext context) {
    if (context.mounted) {
      showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(mediumPadding),
            ),
            child: Padding(
              padding: const EdgeInsets.all(largePadding),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    context.appLoc.reserver,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: largePadding),
                  const Icon(Icons.mail_outlined, size: 64, color: Colors.grey),
                  const SizedBox(height: largePadding),
                  RichText(
                    text: TextSpan(
                      text: "Veuillez nous contacter à l'adresse ",
                      children: [
                        TextSpan(
                          text: "contact@mips.mg",
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ],
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: largePadding),
                ],
              ),
            ),
          );
        },
      );
    }
  }

  static void showAlertDialogErrorComs(BuildContext context) {
    if (context.mounted) {
      showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(mediumPadding),
            ),
            child: Padding(
              padding: const EdgeInsets.all(largePadding),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    context.appLoc.alert_diag_title_error,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: largePadding),
                  const Icon(Icons.error, size: 32, color: tertiaryColor),
                  const SizedBox(height: mediumPadding),
                  Text(
                    context.appLoc.alert_diag_title_message,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        },
      );
    }
  }

  static Future<void> showPopupAnnonce(
    BuildContext context,
    Annonce annonce,
  ) async {
    if (context.mounted) {
      bool isImageLoaded = false;
      if (annonce.photos.isNotEmpty &&
          annonce.photos.first.urlMiniature != "") {
        try {
          await precacheImage(
            CachedNetworkImageProvider(annonce.photos.first.urlMiniature),
            context,
          );
          isImageLoaded = true;
        } on Exception catch (_) {}
      }

      if (context.mounted) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(mediumPadding),
              ),
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(largePadding),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: mediumPadding),
                          constraints: const BoxConstraints(
                            maxWidth: 200 * 1.25,
                            maxHeight: 100 * 1.25,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade400),
                            borderRadius: BorderRadius.circular(
                              mediumPadding + 1.5,
                            ),
                          ),
                          child: SizedBox.fromSize(
                            size: const Size(200 * 1.5, 100 * 1.5),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(
                                mediumPadding,
                              ),
                              child:
                                  (annonce.photos.isEmpty ||
                                      annonce.photos.first.urlMiniature == "")
                                  ? Image.asset(
                                      "assets/imgs/ic_mahafaka.png",
                                      fit: BoxFit.cover,
                                    )
                                  : (isImageLoaded
                                        ? Image(
                                            fit: BoxFit.cover,
                                            image: CachedNetworkImageProvider(
                                              annonce.photos.first.urlMiniature,
                                            ),
                                          )
                                        : const Icon(Icons.error, size: 42)),
                            ),
                          ),
                        ),
                        const SizedBox(height: smallPadding),
                        Text(
                          annonce.title,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: largePadding),
                        Padding(
                          // padding: const EdgeInsets.only(bottom: 8, top: 0),
                          padding: const EdgeInsets.all(0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              // Close button
                              // Flexible(
                              //   flex: 1,
                              //   child: OutlinedButton(
                              //     onPressed: () {
                              //       context.pop();
                              //     },
                              //     child: Text(context.appLoc.fermer),
                              //   ),
                              // ),
                              // const SizedBox(
                              //   width: largePadding,
                              // ),
                              // See more details button
                              Flexible(
                                flex: 1,
                                fit: FlexFit.tight,
                                child: SizedBox(
                                  height: 40,
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor: WidgetStatePropertyAll(
                                        tertiaryColor,
                                      ),
                                      shape: WidgetStatePropertyAll(
                                        RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            16,
                                          ),
                                        ),
                                      ),
                                    ),
                                    onPressed: () {
                                      context.pop();
                                      if (annonce.isWebsitePub) {
                                        MessageDisplayerUtils.showCustomHTLMpage(
                                          context: context,
                                          urlHtml: annonce.customHtmlUrl,
                                        );
                                      } else {
                                        AppRouter.go(
                                          context,
                                          RoutesNames.detail,
                                          queryParameters: {
                                            "id": annonce.id.toString(),
                                            "name": annonce.title,
                                          },
                                          extra: GetIt.instance<AnnonceBloc>()
                                            ..add(
                                              LoadAnnonce(
                                                id: annonce.id.toString(),
                                              ),
                                            ),
                                        );
                                      }
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Flexible(
                                          child: Text(
                                            context.appLoc.voirDetail,
                                            textAlign: TextAlign.center,
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleSmall
                                                ?.copyWith(color: Colors.white),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        const Icon(
                                          Icons.chevron_right_outlined,
                                          color: Colors.white,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    right: 0,
                    top: 0,
                    child: IconButton(
                      style: ButtonStyle(),
                      constraints: BoxConstraints(),
                      padding: EdgeInsets.zero,
                      visualDensity: VisualDensity.compact,
                      onPressed: () {
                        context.pop();
                      },
                      icon: const Icon(Icons.close, color: Colors.black),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      }
    }
  }

  static void showAuthRequiredDialog(
    BuildContext context,
    bool isLoginRoutePresent,
  ) {
    try {
      List<String> routesInStack = GoRouter.of(context)
          .routerDelegate
          .currentConfiguration
          .matches
          .map((e) => e.matchedLocation)
          .toList();
      if (routesInStack.isNotEmpty && routesInStack.last == RoutesNames.login) {
        /// Ne fait rien si la route actuelle est Login
      } else {
        if (context.mounted) {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(mediumPadding),
                ),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      context.appLoc.alert_dial_auth_requiered_title,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: largePadding),
                    Text(
                      context.appLoc.alert_dial_auth_requiered_text,
                      textAlign: TextAlign.center,
                    ),
                    if (!isLoginRoutePresent)
                      const SizedBox(
                        height: largePadding,
                        // height: largePadding * 2,
                      ),
                    if (!isLoginRoutePresent)
                      SizedBox(
                        height: 40,
                        child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: FilledButton.icon(
                            icon: const Icon(Icons.keyboard_arrow_right),
                            onPressed: () {
                              Navigator.pop(context);
                              AppRouter.go(context, RoutesNames.login);
                            },
                            label: Center(
                              child: Text(context.appLoc.continuer),
                            ),
                            style: ButtonStyle(
                              shape: WidgetStatePropertyAll(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    const SizedBox(
                      height: mediumPadding,
                      // height: largePadding,
                    ),
                    SizedBox(
                      height: 40,
                      child: OutlinedButton(
                        style: ButtonStyle(
                          shape: WidgetStatePropertyAll(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Center(child: Text(context.appLoc.fermer)),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        }
      }
    } catch (e) {
      AppUtils.showDebugLog(MessageDisplayerUtils, "Error:$e");
    }
  }

  static void showAuthLoadingDialog(BuildContext context) {
    if (context.mounted) {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(mediumPadding),
            ),
            content: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      context.appLoc.connexion,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: largePadding),
                    Text(
                      context.appLoc.please_wait,
                      textAlign: TextAlign.start,
                    ),
                    const SizedBox(height: largePadding),
                    const AppLoadingWidget(),
                    const SizedBox(height: largePadding * 2),
                  ],
                ),
              ),
            ),
          );
        },
      );
    }
  }

  static void showLoadingOverlay(BuildContext context) {
    if (context.mounted) {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return const Center(child: AppLoadingWidget());
        },
      );
    }
  }

  static void showConfirmSendAnnonceDialog(
    BuildContext context,
    String price,
    Function() onAccept,
  ) {
    if (context.mounted) {
      showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) {
          return AlertDialog(
            actionsAlignment: MainAxisAlignment.center,
            actionsOverflowAlignment: OverflowBarAlignment.center,
            actionsOverflowButtonSpacing: largePadding,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(mediumPadding),
            ),
            content: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      context.appLoc.confirmation,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: largePadding),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: price,
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text: context.appLoc.amount_deduct,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ],
                      ),
                      textAlign: TextAlign.start,
                    ),
                    const SizedBox(height: largePadding),
                    Text(
                      context.appLoc.wanna_continue,
                      style: Theme.of(context).textTheme.titleMedium,
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              SizedBox(
                height: 40,
                child: FilledButton(
                  onPressed: () {
                    onAccept();
                    context.pop();
                  },
                  child: Center(child: Text(context.appLoc.publish)),
                ),
              ),
              SizedBox(
                height: 40,
                child: OutlinedButton(
                  onPressed: () {
                    context.pop();
                  },
                  child: Center(child: Text(context.appLoc.cancel)),
                ),
              ),
            ],
          );
        },
      );
    }
  }

  static void showConfirmSendFakaDialog(
    BuildContext context,
    String price,
    String numeroDestinataire,
    Function() onAccept,
  ) {
    if (context.mounted) {
      showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) {
          return AlertDialog(
            actionsAlignment: MainAxisAlignment.center,
            actionsOverflowAlignment: OverflowBarAlignment.center,
            actionsOverflowButtonSpacing: largePadding,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(mediumPadding),
            ),
            content: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      context.appLoc.transfert_dialog_confirm_title,
                      style: Theme.of(context).textTheme.titleLarge,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: smallPadding),
                    Container(
                      width: double.maxFinite,
                      padding: const EdgeInsets.all(mediumPadding),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(mediumPadding),
                        border: Border.all(color: secondaryColor),
                      ),
                      child: Column(
                        children: [
                          Text(context.appLoc.transfert_dialog_number),
                          Text(
                            numeroDestinataire,
                            style: Theme.of(context).textTheme.titleLarge
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: smallPadding),
                          Text(context.appLoc.transfert_dialog_amount),
                          Text(
                            "$price KARA",
                            style: Theme.of(context).textTheme.titleLarge
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: smallPadding),
                  ],
                ),
              ),
            ),
            actions: [
              FilledButton(
                onPressed: () {
                  onAccept();
                  context.pop();
                },
                child: Center(child: Text(context.appLoc.transferer_faka)),
              ),
              OutlinedButton(
                onPressed: () {
                  context.pop();
                },
                child: Center(child: Text(context.appLoc.cancel)),
              ),
            ],
          );
        },
      );
    }
  }

  static void showConfirmDeleteUserAccountDialog(
    BuildContext context,
    Function() onAccept,
  ) {
    if (context.mounted) {
      showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) {
          return AlertDialog(
            actionsAlignment: MainAxisAlignment.center,
            actionsOverflowAlignment: OverflowBarAlignment.center,
            actionsOverflowButtonSpacing: largePadding,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(mediumPadding),
            ),
            content: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      // context.appLoc.delete_account_dialog_confirm_title,
                      "Nous sommes désolés de vous voir partir.",
                      style: Theme.of(context).textTheme.titleLarge,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: smallPadding),
                  ],
                ),
              ),
            ),
            actions: [
              SizedBox(
                height: 40,
                child: FilledButton(
                  style: FilledButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                  ),
                  onPressed: () {
                    onAccept();
                    context.pop();
                  },
                  child: Center(
                    child: Text(
                      "Continuer",
                      // context.appLoc.delete,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 40,
                child: OutlinedButton(
                  style: ButtonStyle(
                    shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                    ),
                  ),
                  onPressed: () {
                    context.pop();
                  },
                  child: Center(child: Text(context.appLoc.cancel)),
                ),
              ),
            ],
          );
        },
      );
    }
  }

  static void showInvalidInputSendAnnonceDialog(BuildContext context) {
    if (context.mounted) {
      showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) {
          return AlertDialog(
            actionsAlignment: MainAxisAlignment.center,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(mediumPadding),
            ),
            content: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      context.appLoc.incomplete_info,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: largePadding),
                    Text(
                      context.appLoc.incomplete_info_text,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              FilledButton(
                onPressed: () {
                  context.pop();
                },
                child: Text(context.appLoc.fermer),
              ),
            ],
          );
        },
      );
    }
  }

  static void showRegisterLoadingDialog(BuildContext context) {
    if (context.mounted) {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(mediumPadding),
            ),
            content: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(largePadding),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      context.appLoc.register_title,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: largePadding),
                    Text(
                      context.appLoc.please_wait,
                      textAlign: TextAlign.start,
                    ),
                    const SizedBox(height: largePadding),
                    const AppLoadingWidget(),
                    const SizedBox(height: largePadding * 2),
                  ],
                ),
              ),
            ),
          );
        },
      );
    }
  }

  static void showAlertOfHiddenAds(BuildContext context, String text) {
    if (context.mounted) {
      showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(mediumPadding),
            ),
            content: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Text(
                    text,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      fontFamily: "Prétendard",
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ),
              ],
            ),
          );
        },
      );
    }
  }

  static void showSlugInZoom(BuildContext context, String slug) {
    if (context.mounted) {
      showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(mediumPadding),
            ),
            // contentPadding: EdgeInsets.all(0),
            content: Stack(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Clipboard.setData(
                          ClipboardData(text: slug.substring(4)),
                        );
                        MessageDisplayerUtils.showToastMessage(
                          context.appLoc.welcome_user(
                            "Le Slug est bien copiée",
                          ),
                        );
                      },
                      child: Text(
                        slug.substring(4),
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontFamily: "Prétendard",
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                // Positioned(
                //   top: 0,
                //   right: 0,
                //   child: IconButton(
                //     onPressed: () {
                //       context.pop();
                //     },
                //     icon: const Icon(Ionicons.close),
                //   ),
                // ),
              ],
            ),
          );
        },
      );
    }
  }

  ///

  static void showCGUDialog(BuildContext context, Function? onAccept) {
    if (context.mounted) {
      showDialog(
        context: context,
        builder: (context) {
          return CguDialog(onAccept: onAccept);
        },
      );
    }
  }

  static void showCustomHTLMpage({
    required BuildContext context,
    Function? onClick,
    required String urlHtml,
  }) {
    if (context.mounted) {
      showGeneralDialog(
        context: context,
        barrierColor: Colors.black54,
        barrierDismissible: true,
        barrierLabel: MaterialLocalizations.of(
          context,
        ).modalBarrierDismissLabel,
        transitionDuration: const Duration(milliseconds: 300),
        pageBuilder:
            (
              BuildContext buildContext,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
            ) {
              return CustomHtmlDialog(onClick: onClick, urlHtml: urlHtml);
            },
        transitionBuilder:
            (
              BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child,
            ) {
              return SlideTransition(
                position: Tween(
                  begin: const Offset(0.0, 1.0), // Starts from bottom
                  end: Offset.zero, // Ends at its original position
                ).animate(animation),
                child: child,
              );
            },
      );
    }
  }

  /// Show message modulable by type

  static void showToastMessageV2(
    MessageType messageType, {
    BuildContext? dialogContext,
  }) {
    try {
      BuildContext? context = GlobalContextService.snackbarKey.currentContext;
      if (context != null) {
        switch (messageType) {
          case MessageType.favsAdded:
            showToastMessage(context.appLoc.item_favs_added);
            break;
          case MessageType.favsRemoved:
            showToastMessage(context.appLoc.item_favs_removed);
            break;
          case MessageType.errorOperation:
            showToastMessage(context.appLoc.error_operation);
            break;
          case MessageType.beSponsorPartner:
            if (dialogContext != null) {
              showBeSponsPartDialog(dialogContext);
            }
            break;
          default:
        }
      }
    } catch (e) {
      AppUtils.showDebugLog(
        MessageDisplayerUtils,
        "unable to show toast ${e.toString()}",
      );
    }
  }

  static void showToastMessage(String message) {
    try {
      BuildContext? context = GlobalContextService.snackbarKey.currentContext;
      if (context != null) {
        BotToast.showCustomText(
          onlyOne: true,
          ignoreContentClick: false,
          animationDuration: const Duration(milliseconds: 100),
          animationReverseDuration: const Duration(milliseconds: 100),
          toastBuilder: (cancelFunc) => Card(
            surfaceTintColor: Colors.white,
            elevation: 4,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(largePadding),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    child: Text(
                      message,
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium!.copyWith(color: Colors.black87),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }
    } catch (e) {
      if (kDebugMode) {
        print("unable to show toast ${e.toString()}");
      }
    }
  }

  static void showAuthCredentialErrorDialog(BuildContext context) {
    if (context.mounted) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(mediumPadding),
            ),
            content: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(largePadding),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      context.appLoc.diag_auth_error_title,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: largePadding),
                    Text(
                      maxLines: 5,
                      overflow: TextOverflow.ellipsis,
                      context.appLoc.diag_auth_error_text,
                      textAlign: TextAlign.start,
                    ),
                    const SizedBox(height: largePadding * 2),
                    OutlinedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(context.appLoc.fermer),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    }
  }

  static void showBeSponsPartDialog(BuildContext context) {
    if (context.mounted) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(mediumPadding),
            ),
            content: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(largePadding),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      context.appLoc.become_spons_title,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: largePadding),
                    Text(
                      context.appLoc.become_spons_text,
                      textAlign: TextAlign.start,
                    ),
                    const SizedBox(height: largePadding * 2),
                    OutlinedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(context.appLoc.fermer),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    }
  }

  static void showRegisterErrorDialog(
    BuildContext context,
    String errorMessage,
  ) {
    if (context.mounted) {
      String errorToShow = "";
      if (errorMessage.contains("[The phone has already been taken.]")) {
        errorToShow = context.appLoc.phone_duplicate_error;
      }
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(mediumPadding),
            ),
            content: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(largePadding),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      context.appLoc.diag_register_error_title,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: largePadding),
                    Text(
                      maxLines: 5,
                      overflow: TextOverflow.ellipsis,
                      context.appLoc.diag_register_error_text(errorToShow),
                      textAlign: TextAlign.start,
                    ),
                    const SizedBox(height: largePadding * 2),
                    OutlinedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(context.appLoc.fermer),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    }
  }

  static void showLoadingDialog(
    BuildContext context, [
    bool isDismissable = false,
  ]) {
    if (context.mounted) {
      showDialog(
        barrierDismissible: isDismissable,
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(mediumPadding),
            ),
            content: const SingleChildScrollView(
              child: SizedBox(
                height: 150,
                width: 150,
                child: AppLoadingWidget(),
              ),
            ),
          );
        },
      );
    }
  }

  static void showErrorDialog(BuildContext context, String errorMessage) {
    if (context.mounted) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(mediumPadding),
            ),
            content: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(largePadding),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      context.appLoc.diag_error_title,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: smallPadding),
                    const Icon(Icons.error, size: 64),
                    const SizedBox(height: smallPadding),
                    Text(
                      context.appLoc.diag_error_text(errorMessage),
                      textAlign: TextAlign.start,
                      maxLines: 5,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: largePadding),
                    OutlinedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(context.appLoc.fermer),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    }
  }
}
