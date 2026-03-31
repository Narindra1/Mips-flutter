import 'dart:math';

import 'package:MIPS/common/common.dart';
import 'package:MIPS/domain/entities/annonce.dart';
import 'package:MIPS/presentation/bloc/annonce_bloc.dart';
import 'package:MIPS/presentation/bloc/app_bloc.dart';
import 'package:MIPS/presentation/bloc/follow_bloc.dart';
import 'package:MIPS/presentation/bloc/menu_screen_bloc.dart';
import 'package:MIPS/presentation/configurations/extension_for_localization.dart';
import 'package:MIPS/presentation/routes/route.dart';
import 'package:MIPS/presentation/routes/router.dart';
import 'package:MIPS/presentation/screens/base/base_screen.dart';
import 'package:MIPS/presentation/screens/profil/bloc/profil_bloc.dart';
import 'package:MIPS/presentation/widgets/empty_list_widget.dart';
import 'package:MIPS/presentation/widgets/error_page_widget.dart';
import 'package:MIPS/presentation/widgets/loading_image_cache_widget.dart';
import 'package:MIPS/presentation/widgets/loading_widget.dart';
import 'package:MIPS/presentation/widgets/message_displayer_utils.dart';
import 'package:MIPS/presentation/widgets/normal_ads_global_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:ionicons/ionicons.dart';
import 'package:share_plus/share_plus.dart';
import 'package:visibility_detector/visibility_detector.dart';

class ProfilScreen extends StatelessWidget {
  const ProfilScreen({
    super.key,
    required this.authorID,
  });
  final int authorID;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.instance<AnnonceBloc>(),
      child: BlocProvider(
        create: (context) => GetIt.instance<ProfilBloc>()
          ..add(UserProfilLoaded(id: authorID))
          ..add(AnnonceListUserProfilLoaded(
            id: authorID,
            pageIndex: 1,
            query: "",
          ))
          ..add(AnnonceListUserProfilCountLoaded(id: authorID)),
        child: BlocBuilder<MenuScreenBloc, MenuScreenState>(
          builder: (context, state) {
            return BaseScreen(
              useDefaultAnnonceSponsPart: false,
              annoncePartner: state.screenEntity!.annoncePartner,
              annonceSponsor: state.screenEntity!.annonceSponsor,
              content: BlocBuilder<ProfilBloc, ProfilState>(
                builder: (context, state) {
                  List<Annonce> mesAnnonces = [];
                  Widget content = SizedBox();
                  if ((state.profilUserStatus == ProfilUserStatus.loading) ||
                      (state.profilUserAnnoncesCountStatus ==
                          ProfilUserAnnoncesCountStatus.loading) ||
                      (state.profilUserAnnoncesStatus ==
                          ProfilUserAnnoncesStatus.loading)) {
                    content = Center(child: AppLoadingWidget());
                  } else if ((state.profilUserStatus ==
                          ProfilUserStatus.error) ||
                      (state.profilUserAnnoncesCountStatus ==
                          ProfilUserAnnoncesCountStatus.error) ||
                      (state.profilUserAnnoncesStatus ==
                          ProfilUserAnnoncesStatus.error)) {
                    content = Center(child: ErrorPageWidget());
                  } else if (state.profilUserAnnoncesStatus ==
                      ProfilUserAnnoncesStatus.loaded) {
                    // print(
                    //     "USER CONNECTED : ${context.read<AppBloc>().state.user?.id == authorID}");
                    // print("ANNONCE REF : ${state.annonces[0].menuRacineRef}");
                    if (context.read<AppBloc>().state.user?.id == authorID) {
                      mesAnnonces = state.annonces;
                    } else {
                      mesAnnonces = state.annonces
                          .where((e) => e.menuParentRef != blablaZoneMenuRef)
                          .toList();
                    }
                    // print("MES ANNONCES : ${mesAnnonces.length}");
                    content = Container(
                      // color: Colors.purple,
                      width: MediaQuery.of(context).size.width,
                      child: CustomScrollView(shrinkWrap: true, slivers: [
                        SliverAppBar(
                          backgroundColor: Colors.white,
                          pinned: true,
                          expandedHeight: 220,
                          toolbarHeight: kToolbarHeight,
                          collapsedHeight: kToolbarHeight,
                          titleSpacing: 0.0,
                          actionsPadding: EdgeInsets.all(0),
                          flexibleSpace:
                              // FlexibleSpaceBar(
                              //   titlePadding: EdgeInsets.all(0),
                              //   title:
                              LayoutBuilder(
                            builder: (BuildContext context,
                                BoxConstraints constraints) {
                              final top = constraints.biggest.height;
                              final isCollapsed = top <=
                                  kToolbarHeight +
                                      MediaQuery.of(context).padding.top;
                              Widget layout = Container(color: Colors.red);
                              if (isCollapsed) {
                                layout = SingleChildScrollView(
                                  physics: const NeverScrollableScrollPhysics(),
                                  child: Container(
                                    height: kToolbarHeight,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: mediumPadding),
                                    color: Colors.white,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(32),
                                              child: SizedBox(
                                                width: 48,
                                                height: 48,
                                                child: CachedNetworkImage(
                                                  imageUrl:
                                                      state.user.avatarUrl,
                                                  fit: BoxFit.cover,
                                                  progressIndicatorBuilder:
                                                      (context, url,
                                                              progress) =>
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
                                                width: mediumPadding),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  state.user.pseudo,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleMedium!
                                                      .copyWith(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                ),
                                                BlocBuilder<FollowBloc,
                                                    FollowState>(
                                                  builder:
                                                      (context, followState) {
                                                    return BlocBuilder<AppBloc,
                                                        AppState>(
                                                      builder:
                                                          (context, appState) {
                                                        bool isAuthorID =
                                                            authorID ==
                                                                (appState.user
                                                                        ?.id ??
                                                                    -1);
                                                        // bool
                                                        //     followersMoreThan1 =
                                                        //     followState
                                                        //             .myFollowers
                                                        //             .length >
                                                        //         1;
                                                        // bool
                                                        //     followingsMoreThan1 =
                                                        //     followState
                                                        //             .myFollowings
                                                        //             .length >
                                                        //         1;
                                                        int followersCount =
                                                            followState
                                                                .myFollowers
                                                                .length;
                                                        int followingsCount =
                                                            followState
                                                                .myFollowings
                                                                .length;
                                                        // print("UP UP");
                                                        // print(
                                                        //     "AUTHOR ID : ${authorID}");
                                                        // print(
                                                        //     "FOLLOWINGS : ${followingsCount}");
                                                        // print(
                                                        //     "FOLLOWERS : ${followersCount}");

                                                        return appState
                                                                    .isLogged &&
                                                                isAuthorID
                                                            ? MaterialButton(
                                                                padding:
                                                                    EdgeInsets
                                                                        .zero,
                                                                onPressed: () {
                                                                  AppRouter.go(
                                                                      context,
                                                                      RoutesNames
                                                                          .followers);
                                                                },
                                                                child: Text(
                                                                  // appState.isLogged &&
                                                                  //         isAuthorID
                                                                  //     ? "Vous suivez ${followingsMoreThan1 ? "$followingsCount membres" : "${followingsCount == 0 ? "aucun" : followingsCount} membre"}"
                                                                  //     : "Suivi par ${followersMoreThan1 ? "$followersCount membres" : "${followersCount == 0 ? "aucun" : followersCount} membre"}",
                                                                  appState.isLogged &&
                                                                          isAuthorID
                                                                      ? context
                                                                          .appLoc
                                                                          .you_follow_count_member(followingsCount
                                                                              .toString())
                                                                      : context
                                                                          .appLoc
                                                                          .followed_by_count_member(
                                                                              followersCount.toString()),
                                                                  style: Theme.of(
                                                                          context)
                                                                      .textTheme
                                                                      .bodySmall!
                                                                      .copyWith(
                                                                        decoration:
                                                                            TextDecoration.underline,
                                                                        decorationColor: Colors
                                                                            .grey
                                                                            .shade600,
                                                                        decorationThickness:
                                                                            0.6,
                                                                        fontWeight:
                                                                            FontWeight.w600,
                                                                      ),
                                                                ),
                                                              )
                                                            : SizedBox();
                                                      },
                                                    );
                                                  },
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        BlocBuilder<AppBloc, AppState>(
                                          builder: (context, state) {
                                            if (state.userStatus ==
                                                UserStatus.userConnected) {
                                              if (authorID != state.user!.id) {
                                                return BlocBuilder<FollowBloc,
                                                    FollowState>(
                                                  builder: (context, state) {
                                                    bool isFollowing =
                                                        state.isFollowing;
                                                    return SizedBox(
                                                      height: 40,
                                                      child: ElevatedButton(
                                                        onPressed: () {
                                                          context
                                                              .read<
                                                                  FollowBloc>()
                                                              .add(isFollowing
                                                                  ? UnFollowUserEvent(
                                                                      id:
                                                                          authorID)
                                                                  : FollowUserEvent(
                                                                      id: authorID));
                                                        },
                                                        style: ButtonStyle(
                                                            backgroundColor:
                                                                isFollowing
                                                                    ? WidgetStatePropertyAll(
                                                                        Colors
                                                                            .grey)
                                                                    : null,
                                                            shape: WidgetStatePropertyAll(
                                                                RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            16.0)))),
                                                        child: Row(
                                                          spacing: 5.0,
                                                          children: [
                                                            state.isFollowingStatus ==
                                                                    IsFollowingStatus
                                                                        .loading
                                                                ? AppLoadingWidget(
                                                                    size: 16,
                                                                    color: Colors
                                                                        .white,
                                                                  )
                                                                : isFollowing
                                                                    ? const Icon(
                                                                        Ionicons
                                                                            .checkmark_outline)
                                                                    : SizedBox(),
                                                            Text(
                                                              isFollowing
                                                                  ? context
                                                                      .appLoc
                                                                      .followed
                                                                  : context
                                                                      .appLoc
                                                                      .follow,
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodyMedium!
                                                                  .copyWith(
                                                                      color: Colors
                                                                          .white,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                );
                                              } else {
                                                return SizedBox();
                                              }
                                            }
                                            return SizedBox();
                                          },
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              } else {
                                layout = SingleChildScrollView(
                                  padding: EdgeInsets.all(largePadding),
                                  physics: const NeverScrollableScrollPhysics(),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(32),
                                            child: SizedBox(
                                              width: 64,
                                              height: 64,
                                              child: CachedNetworkImage(
                                                imageUrl: state.user.avatarUrl,
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
                                          BlocBuilder<AppBloc, AppState>(
                                            builder: (context, state) {
                                              // if (state.userStatus ==
                                              //     UserStatus.userConnected) {
                                              if (state.isLogged) {
                                                if (authorID !=
                                                    state.user!.id) {
                                                  return BlocBuilder<FollowBloc,
                                                      FollowState>(
                                                    builder: (context, state) {
                                                      bool isFollowing =
                                                          state.isFollowing;
                                                      return SizedBox(
                                                        height: 40,
                                                        child: ElevatedButton(
                                                          onPressed: () {
                                                            context
                                                                .read<
                                                                    FollowBloc>()
                                                                .add(isFollowing
                                                                    ? UnFollowUserEvent(
                                                                        id:
                                                                            authorID)
                                                                    : FollowUserEvent(
                                                                        id: authorID));
                                                          },
                                                          style: ButtonStyle(
                                                              backgroundColor:
                                                                  isFollowing
                                                                      ? WidgetStatePropertyAll(
                                                                          Colors
                                                                              .grey)
                                                                      : null,
                                                              shape: WidgetStatePropertyAll(
                                                                  RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              16.0)))),
                                                          child: Row(
                                                            spacing: 5.0,
                                                            children: [
                                                              state.isFollowingStatus ==
                                                                      IsFollowingStatus
                                                                          .loading
                                                                  ? AppLoadingWidget(
                                                                      size: 16,
                                                                      color: Colors
                                                                          .white,
                                                                    )
                                                                  : isFollowing
                                                                      ? const Icon(
                                                                          Ionicons
                                                                              .checkmark_outline)
                                                                      : SizedBox(),
                                                              Text(
                                                                isFollowing
                                                                    ? context
                                                                        .appLoc
                                                                        .followed
                                                                    : context
                                                                        .appLoc
                                                                        .follow,
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .bodyMedium!
                                                                    .copyWith(
                                                                        color: Colors
                                                                            .white,
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  );
                                                } else {
                                                  return SizedBox();
                                                }
                                              }
                                              return SizedBox();
                                            },
                                          )
                                        ],
                                      ),
                                      const SizedBox(height: mediumPadding),
                                      Text(
                                        state.user.pseudo,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge!
                                            .copyWith(
                                              fontWeight: FontWeight.w600,
                                            ),
                                      ),
                                      const SizedBox(height: smallPadding),
                                      BlocBuilder<FollowBloc, FollowState>(
                                        builder: (context, followState) {
                                          return BlocBuilder<AppBloc, AppState>(
                                            builder: (context, appState) {
                                              bool isAuthorID = authorID ==
                                                  (appState.user?.id ?? -1);
                                              // bool followersMoreThan1 =
                                              //     followState
                                              //             .myFollowers.length >
                                              //         1;
                                              // bool followingsMoreThan1 =
                                              //     followState
                                              //             .myFollowings.length >
                                              //         1;
                                              int followersCount = followState
                                                  .myFollowers.length;
                                              int followingsCount = followState
                                                  .myFollowings.length;
                                              // print("DOWN DOWN");
                                              // print("AUTHOR ID : ${authorID}");
                                              // print(
                                              //     "FOLLOWINGS : ${followingsCount}");
                                              // print(
                                              //     "FOLLOWERS : ${followersCount}");

                                              return appState.isLogged &&
                                                      isAuthorID
                                                  ? MaterialButton(
                                                      padding: EdgeInsets.zero,
                                                      onPressed: () {
                                                        AppRouter.go(
                                                            context,
                                                            RoutesNames
                                                                .followers);
                                                      },
                                                      child: Text(
                                                        // isAuthorID && appState.isLogged
                                                        //     ? "Vous suivez ${followingsMoreThan1 ? "$followingsCount membres" : "${followingsCount == 0 ? "aucun" : followingsCount} membre"}"
                                                        //     : "Suivi par ${followersMoreThan1 ? "$followersCount membres" : "${followersCount == 0 ? "aucun" : followersCount} membre"}",
                                                        appState.isLogged &&
                                                                isAuthorID
                                                            ? context.appLoc
                                                                .you_follow_count_member(
                                                                    followingsCount
                                                                        .toString())
                                                            : context.appLoc
                                                                .followed_by_count_member(
                                                                    followersCount
                                                                        .toString()),
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodySmall!
                                                            .copyWith(
                                                              decoration:
                                                                  TextDecoration
                                                                      .underline,
                                                              decorationColor:
                                                                  Colors.grey
                                                                      .shade600,
                                                              decorationThickness:
                                                                  0.6,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                            ),
                                                      ),
                                                    )
                                                  : SizedBox();
                                            },
                                          );
                                        },
                                      ),
                                      SizedBox(height: largePadding),
                                      Row(
                                        spacing: 10.0,
                                        children: [
                                          Icon(
                                            Ionicons.phone_portrait,
                                            size: 16,
                                            color: Colors.grey.shade400,
                                          ),
                                          Text(
                                            context.appLoc.verified_phone,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium,
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: mediumPadding),
                                      Row(
                                        spacing: 10.0,
                                        children: [
                                          Icon(
                                            Ionicons.bookmark,
                                            size: 16,
                                            color: Colors.grey.shade400,
                                          ),
                                          Flexible(
                                            child: Text(
                                              // "Membre depuis ${}",
                                              context.appLoc.member_since(
                                                  AppUtils.formatDateDDMMYY(
                                                      context,
                                                      state.user
                                                          .dateDAdhesion!)),
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              }
                              return layout;
                            },
                          ),
                          //   expandedTitleScale: 1.0,
                          // ),
                          automaticallyImplyLeading: false,
                        ),
                        SliverPersistentHeader(
                          floating: false,
                          pinned: true,
                          delegate: _SliverAppBarDelegate(
                            minHeight: 40,
                            maxHeight: 40,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    offset: Offset(0, 0),
                                    color: Colors.black12,
                                    blurRadius: 2,
                                    spreadRadius: 2,
                                  ),
                                ],
                              ),
                              padding: EdgeInsets.symmetric(
                                  horizontal: largePadding),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "${state.annoncesCount} ${context.appLoc.announces.toLowerCase()}",
                                      // "${state.annoncesCount} ${state.annoncesCount > 1 ? "annonces" : "annonce"}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium,
                                    ),
                                    BlocBuilder<AppBloc, AppState>(
                                      builder: (context, state) {
                                        return state.isLogged &&
                                                (state.user!.id == authorID)
                                            ? SizedBox()
                                            : GestureDetector(
                                                onTap: () {
                                                  MessageDisplayerUtils
                                                      .showAlertOfHiddenAds(
                                                    context,
                                                    context.appLoc
                                                        .some_may_be_hidden,
                                                  );
                                                },
                                                child: const Icon(
                                                  Ionicons.help,
                                                  color: Colors.black,
                                                  size: 16,
                                                ),
                                              );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        SliverPadding(
                          padding: const EdgeInsets.symmetric(
                              vertical: smallPadding,
                              horizontal: mediumPadding),
                          sliver: mesAnnonces.isNotEmpty
                              ? SliverList.builder(
                                  itemCount: mesAnnonces.length + 1,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    if (index == mesAnnonces.length) {
                                      // print("INDEX $index");
                                      // print(
                                      //     "ANNONCES LIST COUNT : ${mesAnnonces.length}");
                                      // print(
                                      //     "NEXT AVALABLE: ${state.isNextListAvailable}");
                                      return Padding(
                                        padding:
                                            const EdgeInsets.all(largePadding),
                                        child: state.isNextListAvailable
                                            ? VisibilityDetector(
                                                key: const Key('loadMoreKey'),
                                                onVisibilityChanged: (info) {
                                                  var visiblePercentage =
                                                      info.visibleFraction *
                                                          100;
                                                  if (visiblePercentage >= 80) {
                                                    context.read<ProfilBloc>().add(
                                                        LoadMoreAnnonceUserProfil(
                                                            id: authorID));
                                                  }
                                                },
                                                child: const AppLoadingWidget(),
                                              )
                                            : const SizedBox(),
                                      );
                                    }
                                    return BlocBuilder<AppBloc, AppState>(
                                      builder: (context, appState) {
                                        return NormalAdsGlobalWidget(
                                          isFree:
                                              mesAnnonces[index].isWebsitePub,
                                          dateLimit: authorID ==
                                                  (appState.user?.id ?? -1)
                                              ? mesAnnonces[index].dateLimit
                                              : "",
                                          reactionCount:
                                              mesAnnonces[index].reactionCount,
                                          isPremium:
                                              mesAnnonces[index].annonceType ==
                                                  AnnonceType.premium,
                                          isVIP:
                                              mesAnnonces[index].annonceType ==
                                                  AnnonceType.vip,
                                          dateCreation:
                                              mesAnnonces[index].dateDeCreation,
                                          id: mesAnnonces[index].id,
                                          urlImage: (mesAnnonces[index]
                                                  .photos
                                                  .isNotEmpty)
                                              ? mesAnnonces[index]
                                                  .photos
                                                  .first
                                                  .urlMiniature
                                              : "",
                                          title: mesAnnonces[index].title,
                                          description: mesAnnonces[index]
                                              .descriptionCourte,
                                          lieu: mesAnnonces[index].emplacement,
                                          authorID: mesAnnonces[index].authorID,
                                          authorName: mesAnnonces[index].author,
                                          menuRacineRef:
                                              mesAnnonces[index].menuRacineRef,
                                          menuRacineName:
                                              mesAnnonces[index].menuRacineName,
                                          menuParentName:
                                              mesAnnonces[index].menuParentName,
                                          menuParentRef:
                                              mesAnnonces[index].menuParentRef,
                                          onClick: () {
                                            // print(
                                            //     "ANNONCE TITLE : ${mesAnnonces[index].title}");
                                            AppRouter.go(context,
                                                RoutesNames.detailGlobal,
                                                queryParameters: {
                                                  "id": mesAnnonces[index]
                                                      .id
                                                      .toString(),
                                                  "name":
                                                      mesAnnonces[index].title,
                                                },
                                                extra: context
                                                    .read<AnnonceBloc>()
                                                  ..add(
                                                      LoadAnnonceWithPartnerSponsor(
                                                          id: mesAnnonces[index]
                                                              .id
                                                              .toString())));
                                            // AppRouter.go(
                                            //         context, RoutesNames.detail,
                                            //         queryParameters: {
                                            //           "id": state
                                            //               .annonces[index].id
                                            //               .toString(),
                                            //           "name": state
                                            //               .annonces[index].title
                                            //         },
                                            //         extra: GetIt.instance<
                                            //             AnnonceBloc>()
                                            //           ..add(LoadAnnonce(
                                            //               id: state
                                            //                   .annonces[index].id
                                            //                   .toString())))
                                            //     .then((value) {
                                            //   GetIt.instance<AnnonceBloc>().add(
                                            //       LoadAnnonce(
                                            //           id: state.annonces[index].id
                                            //               .toString()));
                                            // });
                                          },
                                        );
                                      },
                                    );
                                  },
                                )
                              : SliverFillRemaining(
                                  child: SingleChildScrollView(
                                  physics: const NeverScrollableScrollPhysics(),
                                  child: EmptyListWidget(
                                      listType: ListType.annonce),
                                )),
                        )
                      ]),
                    );
                  }
                  return RefreshIndicator(
                    child: content,
                    onRefresh: () async {
                      context
                          .read<ProfilBloc>()
                          .add(UserProfilLoaded(id: authorID));
                      context.read<FollowBloc>()
                        ..add(FollowersLoadedEvent())
                        ..add(FollowingLoadedEvent());
                    },
                  );
                },
              ),
              title: const SizedBox(),
              leading: IconButton(
                onPressed: () {
                  context.pop();
                },
                icon: const Icon(
                  Ionicons.chevron_back,
                  color: Colors.black,
                ),
              ),
              appBarAction: [
                BlocBuilder<ProfilBloc, ProfilState>(
                  builder: (context, state) {
                    return IconButton(
                      onPressed: () {
                        SharePlus.instance.share(
                          ShareParams(
                              text:
                                  '${context.appLoc.online_ads_from(state.user.name)}\n\nhttps://mips.mg/profil/$authorID'),
                        );
                      },
                      icon: const Icon(
                        Ionicons.share_social_outline,
                        color: Colors.black,
                      ),
                    );
                  },
                ),
              ],
              // backgroundColor: Colors.white,
            );
          },
        ),
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });
  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => max(maxHeight, minHeight);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
