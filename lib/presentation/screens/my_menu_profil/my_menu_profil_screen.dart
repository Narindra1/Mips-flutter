import 'package:MIPS/common/common.dart';
import 'package:MIPS/presentation/configurations/colors_list.dart';
import 'package:MIPS/presentation/configurations/extension_for_localization.dart';
import 'package:MIPS/presentation/presentation.dart';
import 'package:MIPS/presentation/screens/avis/bloc/avis_bloc.dart';
import 'package:MIPS/presentation/screens/base/base_screen.dart';
import 'package:MIPS/presentation/screens/my_menu_profil/bloc/my_menu_profil_bloc.dart';
import 'package:MIPS/presentation/screens/my_menu_profil/widgets/menu_profil_button.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:MIPS/presentation/widgets/error_page_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:ionicons/ionicons.dart';

import '../../routes/route.dart';
import '../../routes/router.dart';
import '../../widgets/app_panel_widget.dart';

class MyMenuProfilScreen extends StatelessWidget {
  const MyMenuProfilScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AppBloc, AppState>(
      listener: (context, state) {
        if (state.userStatus == UserStatus.userNotConnected) {
          AppRouter.goPushNamedAndRemoveUntil(
            context,
            RoutesNames.home,
          );
        }
      },
      child: BlocProvider.value(
        value: context.read<AppBloc>()..add(GetUserInfoEvent()),
        child: BlocProvider(
          create: (context) => GetIt.instance<AvisBloc>()..add(LoadListEvent()),
          child: BlocBuilder<AppBloc, AppState>(
            builder: (context, state) {
              Widget content = const SizedBox();
              if (state.userStatus == UserStatus.loading) {
                content = const Center(child: AppLoadingWidget());
              } else if (UserStatus.loading == UserStatus.error) {
                content = const CustomScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    slivers: [
                      SliverFillRemaining(
                        child: Center(
                          child: ErrorPageWidget(),
                        ),
                      ),
                    ]);
              } else {
                content = SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 500),
                    padding:
                        const EdgeInsets.symmetric(horizontal: mediumPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: mediumPadding,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Text(
                            //   context.appLoc.menu_profil_account_info,
                            //   style: Theme.of(context).textTheme.titleMedium,
                            // ),
                            // const SizedBox(
                            //   height: smallPadding,
                            // ),
                            GestureDetector(
                              onTap: () {
                                AppRouter.go(
                                  context,
                                  RoutesNames.profilDetail,
                                  queryParameters: {
                                    "authorID": "${state.user!.id}"
                                  },
                                );
                              },
                              child: Material(
                                borderRadius: BorderRadius.circular(16),
                                elevation: 2,
                                child: AppPanelWidget(
                                  padding: const EdgeInsets.all(mediumPadding),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(32),
                                            child: SizedBox(
                                              width: 64,
                                              height: 64,
                                              child: CachedNetworkImage(
                                                imageUrl: context
                                                        .read<AppBloc>()
                                                        .state
                                                        .user
                                                        ?.avatarUrl ??
                                                    " ",
                                                fit: BoxFit.cover,
                                                progressIndicatorBuilder: (context,
                                                        url, progress) =>
                                                    const LoadingImageCacheWidget(),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        const Icon(
                                                  Icons.error,
                                                  size: 42,
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: largePadding,
                                          ),
                                          Text(
                                            "${context.read<AppBloc>().state.user?.pseudo}",
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleMedium,
                                          ),
                                          const Spacer(),
                                          const Icon(Ionicons.chevron_forward,
                                              color: Colors.grey),
                                        ],
                                      ),
                                      // Text(
                                      //   "${context.read<AppBloc>().state.user?.contactFormatted}",
                                      //   style: Theme.of(context).textTheme.titleSmall,
                                      // ),
                                      // Text(
                                      //   "${context.read<AppBloc>().state.user?.mail}",
                                      //   style: Theme.of(context).textTheme.titleSmall,
                                      // ),
                                      // Text(
                                      //   "${context.read<AppBloc>().state.user?.lieuResidence}",
                                      //   style: Theme.of(context).textTheme.titleSmall,
                                      // ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: largePadding,
                            ),
                            // Text(
                            //   context.appLoc.menu_profil_myavatar,
                            //   style: Theme.of(context).textTheme.titleMedium,
                            // ),
                            // const SizedBox(
                            //   height: smallPadding,
                            // ),
                            GestureDetector(
                              onTap: () {
                                AppRouter.go(context, RoutesNames.myWallet);
                              },
                              child: Material(
                                elevation: 2,
                                borderRadius: BorderRadius.circular(16),
                                child: ClipRRect(
                                  borderRadius:
                                      BorderRadius.circular(largePadding),
                                  child: Stack(
                                    children: [
                                      AppPanelWidget(
                                        padding:
                                            const EdgeInsets.all(mediumPadding),
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              // SizedBox(
                                              //   width: 96, // diameter = radius * 2
                                              //   height: 96,
                                              //   child: CachedNetworkImage(
                                              //     imageUrl: context
                                              //             .read<AppBloc>()
                                              //             .state
                                              //             .user
                                              //             ?.avatarUrl ??
                                              //         " ",
                                              //     fit: BoxFit.cover,
                                              //     progressIndicatorBuilder: (context,
                                              //             url, progress) =>
                                              //         const LoadingImageCacheWidget(),
                                              //     errorWidget: (context, url, error) =>
                                              //         const Icon(
                                              //       Icons.error,
                                              //       size: 42,
                                              //     ),
                                              //   ),
                                              // ),
                                              // Text(
                                              //   context.appLoc.menu_profil_avatar_desc,
                                              //   style: Theme.of(context)
                                              //       .textTheme
                                              //       .titleSmall
                                              //       ?.copyWith(color: Colors.grey),
                                              // ),
                                              // const SizedBox(
                                              //   height: smallPadding,
                                              // ),
                                              // FilledButton(
                                              //     onPressed: () {
                                              //       AppRouter.go(context,
                                              //           RoutesNames.achatAvatar);
                                              //     },
                                              //     child: Text(context.appLoc.avatar)),
                                              // const Padding(
                                              //   padding: EdgeInsets.only(
                                              //       top: largePadding,
                                              //       bottom: mediumPadding),
                                              //   child: Divider(
                                              //     color: Colors.black12,
                                              //   ),
                                              // ),
                                              Text(
                                                context.appLoc.wallet,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleLarge,
                                              ),
                                              const SizedBox(
                                                height: smallPadding,
                                              ),
                                              Wrap(
                                                crossAxisAlignment:
                                                    WrapCrossAlignment.center,
                                                alignment: WrapAlignment.center,
                                                // mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Image.asset(
                                                    width: 32,
                                                    height: 32,
                                                    mipsCoin,
                                                    fit: BoxFit.cover,
                                                  ),
                                                  const SizedBox(
                                                    width: smallPadding,
                                                  ),
                                                  Text(
                                                    AppUtils.formatNumberWithSpaces(
                                                        context
                                                                .read<AppBloc>()
                                                                .state
                                                                .user
                                                                ?.soldeFAKA ??
                                                            0),
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .displaySmall,
                                                  ),
                                                  // const SizedBox(
                                                  //   width: smallPadding,
                                                  // ),
                                                  // Text(context.appLoc.mips_unit,
                                                  //     style: Theme.of(context)
                                                  //         .textTheme
                                                  //         .bodyLarge)
                                                ],
                                              ),
                                              Text(
                                                context.appLoc
                                                    .menu_profil_solde_disponible,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleSmall
                                                    ?.copyWith(
                                                        color: Colors
                                                            .grey.shade700),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      // Positioned(
                                      //   top: 5,
                                      //   left: -60,
                                      //   child: Image.asset(
                                      //     width: 125,
                                      //     height: 125,
                                      //     mipsCoin,
                                      //     fit: BoxFit.cover,
                                      //   ),
                                      // ),
                                      Positioned(
                                        top: 5,
                                        left: -100,
                                        child: Container(
                                          height: 150,
                                          width: 150,
                                          decoration: BoxDecoration(
                                            color: tertiaryColor,
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        top: -60,
                                        left: -80,
                                        child: Container(
                                          height: 150,
                                          width: 150,
                                          decoration: BoxDecoration(
                                            color:
                                                secondaryColor.withAlpha(200),
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        top: 0,
                                        bottom: 0,
                                        right: 10,
                                        child: const Icon(
                                            Ionicons.chevron_forward,
                                            color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: largePadding * 2),
                        MenuProfilButton(
                          icon: Ionicons.gift,
                          title: context.appLoc.rewards,
                          onPressed: () {
                            AppRouter.go(
                              context,
                              RoutesNames.rewards,
                              queryParameters: {
                                "solde":
                                    "${context.read<AppBloc>().state.user?.soldeFAKA ?? 0}"
                              },
                            );
                          },
                          menuRewards: true,
                        ),
                        const SizedBox(height: smallPadding),
                        Divider(color: Colors.grey.shade200),
                        const SizedBox(height: smallPadding),
                        // MenuProfilButton(
                        //   icon: Ionicons.logo_euro,
                        //   title: context.appLoc.exchange_rate,
                        //   onPressed: () {
                        //     AppRouter.go(context, RoutesNames.exchangeRate);
                        //   },
                        // ),
                        // const SizedBox(height: smallPadding),
                        // Divider(color: Colors.grey.shade200),
                        // const SizedBox(height: smallPadding),
                        MenuProfilButton(
                          icon: Ionicons.heart,
                          title: context.appLoc.favorite,
                          onPressed: () {
                            AppRouter.go(context, RoutesNames.myMenuDetail,
                                queryParameters: {
                                  "isAnnonceMode": "true",
                                  "name": context.appLoc.announce_favs
                                },
                                extra: GetIt.instance<MyMenuProfilBloc>()
                                  ..add(LoadAnnoncesFavoris(pageIndex: 1)));
                          },
                        ),
                        const SizedBox(height: smallPadding),
                        Divider(color: Colors.grey.shade200),
                        const SizedBox(height: smallPadding),
                        MenuProfilButton(
                          icon: Ionicons.people,
                          title: context.appLoc.followers,
                          onPressed: () {
                            AppRouter.go(context, RoutesNames.followers);
                          },
                        ),
                        const SizedBox(height: smallPadding),
                        Divider(color: Colors.grey.shade200),
                        const SizedBox(height: smallPadding),
                        MenuProfilButton(
                          icon: Ionicons.newspaper,
                          title: context.appLoc.my_ads,
                          onPressed: () {
                            AppRouter.go(context, RoutesNames.mesAnnonces);
                          },
                        ),
                        const SizedBox(height: smallPadding),
                        Divider(color: Colors.grey.shade200),
                        const SizedBox(height: smallPadding),
                        MenuProfilButton(
                          icon: Ionicons.person,
                          title: context.appLoc.profil,
                          onPressed: () {
                            AppRouter.go(context, RoutesNames.changeUserInfo);
                          },
                        ),
                        const SizedBox(height: smallPadding),
                        Divider(color: Colors.grey.shade200),
                        const SizedBox(height: smallPadding),
                        MenuProfilButton(
                          icon: Ionicons.help_buoy,
                          title: context.appLoc.complaints_and_suggestions,
                          onPressed: () {
                            AppRouter.go(
                              context,
                              RoutesNames.demandePlainte,
                              queryParameters: {
                                "idMenu": "8",
                                "title":
                                    context.appLoc.complaints_and_suggestions,
                              },
                            );
                          },
                        ),
                        const SizedBox(height: smallPadding),
                        Divider(color: Colors.grey.shade200),
                        const SizedBox(height: smallPadding),
                        MenuProfilButton(
                          icon: Ionicons.shield_checkmark,
                          title: context.appLoc.connexion_security,
                          isButton: false,
                          onPressed: null,
                        ),
                        const SizedBox(height: mediumPadding),
                        MenuProfilButton(
                          title: context.appLoc.profil_change_pass_text,
                          style:
                              Theme.of(context).textTheme.titleMedium!.copyWith(
                                    fontWeight: FontWeight.w400,
                                  ),
                          onPressed: () {
                            AppRouter.go(context, RoutesNames.changePassword);
                          },
                        ),
                        Divider(
                          color: Colors.grey.shade400,
                          indent: 50,
                          endIndent: 15,
                        ),
                        const SizedBox(height: smallPadding),
                        MenuProfilButton(
                          title: context.appLoc.delete_account,
                          style:
                              Theme.of(context).textTheme.titleMedium!.copyWith(
                                    fontWeight: FontWeight.w400,
                                  ),
                          onPressed: () {
                            AppRouter.go(context, RoutesNames.deleteAccount);
                          },
                        ),
                        const SizedBox(height: smallPadding),
                        Divider(color: Colors.grey.shade200),
                        const SizedBox(height: smallPadding),
                        MenuProfilButton(
                          icon: Ionicons.help,
                          title: context.appLoc.notice,
                          isButton: false,
                          onPressed: null,
                        ),
                        const SizedBox(height: mediumPadding),
                        BlocBuilder<AvisBloc, AvisState>(
                          builder: (context, state) {
                            return ListView.separated(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: state.avisList.length,
                              itemBuilder: (context, index) {
                                return MenuProfilButton(
                                  title: state.avisList[index].title,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(
                                        fontWeight: FontWeight.w400,
                                      ),
                                  onPressed: () {
                                    AppRouter.go(
                                      context,
                                      RoutesNames.avisDetail,
                                      queryParameters: {
                                        "id":
                                            state.avisList[index].id.toString(),
                                        "title": state.avisList[index].title,
                                        "pageUrl": state.avisList[index].htmlURL
                                      },
                                    );
                                  },
                                );
                              },
                              separatorBuilder: (context, index) {
                                return Column(
                                  children: [
                                    Divider(
                                      color: Colors.grey.shade400,
                                      indent: 50,
                                      endIndent: 15,
                                    ),
                                    const SizedBox(height: smallPadding),
                                  ],
                                );
                              },
                            );
                          },
                        ),
                        const SizedBox(height: smallPadding),
                        Divider(color: Colors.grey.shade200),
                        const SizedBox(height: mediumPadding + smallPadding),
                        SizedBox(
                          height: 40,
                          child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: OutlinedButton(
                              style: ButtonStyle(
                                shape: WidgetStatePropertyAll(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                              ),
                              onPressed: () {
                                context.read<AppBloc>().add(LogoutUserEvent());
                              },
                              child: Text(context.appLoc.logout),
                            ),
                          ),
                        ),
                        const SizedBox(height: largePadding + smallPadding),
                      ],
                    ),
                  ),
                );
              }
              return BaseScreen(
                useDefaultAnnonceSponsPart: true,
                title: Text(
                  context.appLoc.my_account,
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
                content: content,
                // content: RefreshIndicator(
                //     onRefresh: () async {
                //       context.read<AppBloc>().add(GetUserInfoEvent());
                //     },
                //     child: content),
                backgroundColor: Colors.white,
              );
            },
          ),
        ),
      ),
    );
  }
}
