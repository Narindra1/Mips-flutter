import 'package:MIPS/common/common.dart';
import 'package:MIPS/presentation/configurations/extension_for_localization.dart';
import 'package:MIPS/presentation/screens/profil/bloc/profil_bloc.dart';
import 'package:MIPS/presentation/widgets/page_count_icon_indicator.dart';
import 'package:animations/animations.dart';
import 'package:MIPS/presentation/configurations/colors_list.dart';
import 'package:MIPS/presentation/presentation.dart';
import 'package:MIPS/presentation/routes/route.dart';
import 'package:MIPS/presentation/routes/router.dart';
import 'package:MIPS/presentation/screens/base/base_screen.dart';
import 'package:MIPS/presentation/widgets/message_displayer_utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:colorful_iconify_flutter/icons/noto.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:ionicons/ionicons.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import '../../../domain/entities/commentaire.dart';
import '../../widgets/error_page_widget.dart';
import '../../widgets/hero_photoview_route_wrapper.dart';

class DetailScreen extends StatelessWidget {
  final String idRoute;
  final String title;
  final PageController pageController = PageController();
  final GlobalKey<FormState> _formCommentaireKey = GlobalKey<FormState>();
  final TextEditingController commentaireAnnonceController =
      TextEditingController();

  DetailScreen({super.key, required this.idRoute, required this.title});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AnnonceBloc, AnnonceState>(
      listener: (context, state) {
        if (state.selectedStatus == SelectedStatus.deleted) {
          Navigator.pop(context);
          MessageDisplayerUtils.showToastMessage(
              context.appLoc.annonce_deleted_succesfully);
        }
      },
      listenWhen: (previous, current) {
        // éviter double appel
        if (current.selectedStatus == SelectedStatus.deleted &&
            previous.selectedStatus == SelectedStatus.deleted) {
          return false;
        }
        return true;
      },
      buildWhen: (previous, current) {
        if (current.commentaireStatus == CommentaireStatus.loaded) {
          FocusManager.instance.primaryFocus?.unfocus();
          commentaireAnnonceController.text = "";
        } else if (current.commentaireStatus == CommentaireStatus.error &&
            previous.commentaireStatus != CommentaireStatus.error) {
          MessageDisplayerUtils.showAlertDialogErrorComs(context);
        }
        return true;
      },
      builder: (context, state) {
        if (kDebugMode) {
          print("ANNONCE TITLE : ${state.selectedAnnonce?.title}");
          print(
              "PARTENAIRE : ${context.read<AppBloc>().state.annoncePartenaireMenu}");
          print(
              "SPONSORS : ${context.read<AppBloc>().state.annonceSponsorMenu}");
        }

        return BaseScreen(
          useDefaultAnnonceSponsPart:
              context.read<AnnonceBloc>().annonceListID < 1,
          annoncePartner: context.read<AppBloc>().state.annoncePartenaireMenu,
          annonceSponsor: context.read<AppBloc>().state.annonceSponsorMenu,
          content: _builContentList(context, state),
          title: Text(
            state.selectedAnnonce != null
                ? state.selectedAnnonce!.title
                : title,
            style: TextStyle(
              fontFamily: "Pretendard",
              color: Colors.black,
            ),
          ),
          leading: IconButton(
            onPressed: () {
              context.pop();
            },
            icon: const Icon(
              Ionicons.chevron_back_outline,
              color: Colors.black,
            ),
          ),
          appBarAction: [
            if (context.read<AppBloc>().state.isLogged &&
                state.selectedStatus == SelectedStatus.loaded)
              Container(
                margin: EdgeInsets.symmetric(horizontal: 12),
                child: IconButton(
                    onPressed: () {
                      context.read<AnnonceBloc>().add(MakeFavAnnonceEvent(
                          id: state.selectedAnnonce!.id,
                          isLiked: !(state.selectedAnnonce!.isFavs)));
                    },
                    icon: (state.selectedAnnonce != null
                            ? state.selectedAnnonce!.isFavs
                            : false)
                        ? const Icon(
                            Ionicons.heart,
                            fill: 1,
                            // Icons.favorite,
                            color: Colors.red,
                          )
                        : const Icon(
                            // Icons.favorite_border,
                            Ionicons.heart_outline,
                            // color: tertiaryColor,
                            color: Colors.black,
                          )),
              ),
            IconButton(
              onPressed: () {
                SharePlus.instance.share(
                  ShareParams(
                      text:
                          '${context.appLoc.found_ad_that_might_interest_you}\n\nhttps://mips.mg/annonces/$idRoute'),
                );
              },
              icon: const Icon(
                Ionicons.share_social_outline,
                color: Colors.black,
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _builContentList(BuildContext context, AnnonceState state) {
    Widget content = const SizedBox();
    if (state.selectedStatus == SelectedStatus.loading ||
        state.selectedStatus == SelectedStatus.deleted) {
      content = const AppLoadingWidget();
    } else if (state.selectedStatus == SelectedStatus.loaded) {
      content = SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Container(
          color: Colors.white,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Column(
                children: [
                  Stack(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 250,
                        child: PageView(
                          controller: pageController,
                          children: state.selectedAnnonce!.photos.isEmpty
                              ? [
                                  Container(
                                    color: secondaryColor,
                                    child: Image.asset(
                                      "assets/imgs/ic_mahafaka.png",
                                      fit: BoxFit.fitHeight,
                                    ),
                                  ),
                                ]
                              : List.generate(
                                  state.selectedAnnonce!.photos.length,
                                  (index) => Builder(
                                    builder: (BuildContext context) {
                                      return OpenContainer(
                                        closedShape: RoundedRectangleBorder(),
                                        openBuilder: (_, closeContainer) =>
                                            HeroPhotoViewRouteWrapper(
                                                title: Text(
                                                  state.selectedAnnonce!.title,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleLarge,
                                                  textAlign: TextAlign.left,
                                                ),
                                                urls: state
                                                    .selectedAnnonce!.photos
                                                    .map(
                                                      (e) => e.url,
                                                    )
                                                    .toList(),
                                                selectedImgIndex: index),
                                        closedBuilder: (_, closeContainer) =>
                                            CachedNetworkImage(
                                          imageUrl: state.selectedAnnonce!
                                              .photos[index].url,
                                          fit: BoxFit.fitHeight,
                                          progressIndicatorBuilder: (context,
                                                  url, progress) =>
                                              const LoadingImageCacheWidget(),
                                          errorWidget: (context, url, error) =>
                                              Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              const Icon(Icons.error_outline),
                                              Text(context
                                                  .appLoc.error_loading_image)
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                        ),
                      ),
                      if (state.selectedAnnonce!.photos.length > 1)
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Padding(
                            padding: const EdgeInsets.all(smallPadding),
                            child: PageCountIconIndicator(
                              pageController: pageController,
                              count: state.selectedAnnonce!.photos.length,
                            ),
                            // SmoothPageIndicator(
                            //   controller: pageController,
                            //   count: state.selectedAnnonce!.photos.length,
                            //   onDotClicked: (index) {
                            //     pageController.animateToPage(index,
                            //         duration: const Duration(milliseconds: 250),
                            //         curve: Curves.bounceIn);
                            //   },
                            //   axisDirection: Axis.horizontal,
                            //   effect: const ScrollingDotsEffect(
                            //     spacing: 5.0,
                            //     activeDotColor: tertiaryColor,
                            //     dotWidth: 8,
                            //     strokeWidth: 4,
                            //     dotHeight: 8,
                            //     paintStyle: PaintingStyle.fill,
                            //   ),
                            // ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
              MaterialButton(
                onPressed: () {
                  MessageDisplayerUtils.showSlugInZoom(
                    context,
                    "ID: ${state.selectedAnnonce!.slug}",
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(smallPadding),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      padding:
                          const EdgeInsets.symmetric(horizontal: smallPadding),
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(
                              Radius.circular(mediumPadding)),
                          color: Colors.grey.shade300),
                      child: Text(
                        "ID: ${state.selectedAnnonce!.slug}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: "Raleway",
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: smallPadding, horizontal: largePadding),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Expanded(
                                    child: Text(
                                      state.selectedAnnonce!.title,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: mediumPadding,
                              ),
                              // if (state.selectedAnnonce!.descriptionCourte
                              //         .isEmpty ||
                              //     state.selectedAnnonce!.descriptionCourte !=
                              //         ".")
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  (state.selectedAnnonce!.descriptionCourte
                                              .isEmpty ||
                                          state.selectedAnnonce!
                                                  .descriptionCourte !=
                                              '.')
                                      ? Expanded(
                                          child: Text(
                                            state.selectedAnnonce!
                                                .descriptionCourte,
                                            style: const TextStyle(
                                                color: Colors.grey),
                                          ),
                                        )
                                      : SizedBox(),
                                  if (context.read<AppBloc>().state.isLogged &&
                                      state.selectedAnnonce?.authorID ==
                                          context
                                              .read<AppBloc>()
                                              .state
                                              .user
                                              ?.id)
                                    IconButton(
                                      onPressed: () {
                                        showModalBottomSheet(
                                          context: context,
                                          constraints: BoxConstraints(
                                            minWidth: MediaQuery.of(context)
                                                .size
                                                .width,
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(16),
                                              topRight: Radius.circular(16),
                                            ),
                                            side: BorderSide(
                                              color: Colors.grey.shade100,
                                            ),
                                          ),
                                          builder: (_) => ListView.builder(
                                              shrinkWrap: true,
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              itemCount: 3,
                                              itemBuilder: (_, index) {
                                                return TextButton(
                                                  style: ButtonStyle(
                                                    overlayColor:
                                                        WidgetStatePropertyAll(
                                                            Colors.grey),
                                                    shape:
                                                        WidgetStatePropertyAll(
                                                      RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(16),
                                                        // side: BorderSide(color: Colors.grey),
                                                      ),
                                                    ),
                                                    fixedSize:
                                                        WidgetStatePropertyAll(
                                                            Size(
                                                                MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,
                                                                40)),
                                                  ),
                                                  onPressed: () {
                                                    if (index == 0) {
                                                      AppRouter.go(
                                                        context,
                                                        RoutesNames.demandePub,
                                                        queryParameters: {
                                                          "menuParentRef": state
                                                              .selectedAnnonce!
                                                              .menuParentRef,
                                                          "idMenu": state
                                                              .selectedAnnonce!
                                                              .menuParentID
                                                              .toString(),
                                                          "title": state
                                                              .selectedAnnonce!
                                                              .title,
                                                          "idAnnonce": state
                                                              .selectedAnnonce!
                                                              .id
                                                              .toString(),
                                                          "isExtendValidityMode":
                                                              "true",
                                                        },
                                                        extra: context.read<
                                                            AnnonceBloc>(),
                                                      );
                                                    } else if (index == 1) {
                                                      AppRouter.go(
                                                        context,
                                                        RoutesNames.demandePub,
                                                        queryParameters: {
                                                          "menuParentRef": state
                                                              .selectedAnnonce!
                                                              .menuParentRef,
                                                          "idMenu": state
                                                              .selectedAnnonce!
                                                              .menuParentID
                                                              .toString(),
                                                          "title": state
                                                              .selectedAnnonce!
                                                              .title,
                                                          "idAnnonce": state
                                                              .selectedAnnonce!
                                                              .id
                                                              .toString(),
                                                          "isFreeMode": "false",
                                                        },
                                                        extra: context.read<
                                                            AnnonceBloc>(),
                                                      );
                                                    } else if (index == 2) {
                                                      context
                                                          .read<AnnonceBloc>()
                                                          .add(
                                                              DeleteRecentAnnonceEvent(
                                                            annonceType: state
                                                                .selectedAnnonce!
                                                                .annonceType,
                                                            annonceID: state
                                                                .selectedAnnonce!
                                                                .id
                                                                .toString(),
                                                          ));
                                                    }
                                                    context.pop();
                                                  },
                                                  child: _buildOptionSettings(
                                                      context, index),
                                                );
                                              }),
                                        );
                                      },
                                      style: ButtonStyle(
                                          shape: WidgetStatePropertyAll(
                                              RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        side: BorderSide(color: tertiaryColor),
                                      ))),
                                      visualDensity: VisualDensity.compact,
                                      icon: const Icon(
                                        Ionicons.menu,
                                        color: tertiaryColor,
                                        size: 24,
                                      ),
                                    ),
                                ],
                              ),
                              if (state.selectedAnnonce!.emplacement != "")
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: mediumPadding),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        size: 16,
                                        Ionicons.location,
                                        color: Colors.grey,
                                      ),
                                      const SizedBox(
                                        width: mediumPadding,
                                      ),
                                      Expanded(
                                        child: Text(
                                          state.selectedAnnonce!.emplacement,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              if (state.selectedAnnonce!.dateDeCreation != "")
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: mediumPadding),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        size: 16,
                                        Ionicons.calendar,
                                        color: Colors.grey,
                                      ),
                                      const SizedBox(
                                        width: mediumPadding,
                                      ),
                                      Text(
                                          AppUtils.getDate(state
                                              .selectedAnnonce!.dateDeCreation),
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall)
                                    ],
                                  ),
                                ),
                              // if (state.selectedAnnonce!.contact != "")
                              (state.selectedAnnonce!.menuParentRef !=
                                      blablaZoneMenuRef)
                                  ? _buildPhoneNumber(context, state,
                                      state.selectedAnnonce!.contactFormatted)
                                  : (context.read<AppBloc>().state.isLogged &&
                                          (context
                                                  .read<AppBloc>()
                                                  .state
                                                  .user!
                                                  .id ==
                                              state.selectedAnnonce!.authorID))
                                      ? _buildPhoneNumber(
                                          context,
                                          state,
                                          context
                                              .read<AppBloc>()
                                              .state
                                              .user!
                                              .contactFormatted)
                                      : SizedBox(),
                              // Text("${state.selectedAnnonce!.authorID}"),
                              const SizedBox(height: smallPadding),
                              (state.selectedAnnonce!.menuParentRef !=
                                      blablaZoneMenuRef)
                                  ? Divider(color: Colors.grey.shade300)
                                  : (context.read<AppBloc>().state.isLogged &&
                                          (context
                                                  .read<AppBloc>()
                                                  .state
                                                  .user!
                                                  .id ==
                                              state.selectedAnnonce!.authorID))
                                      ? Divider(color: Colors.grey.shade300)
                                      : SizedBox(),
                              (state.selectedAnnonce!.menuParentRef !=
                                      blablaZoneMenuRef)
                                  ? _buildProfil(context, state)
                                  : (context.read<AppBloc>().state.isLogged &&
                                          (context
                                                  .read<AppBloc>()
                                                  .state
                                                  .user!
                                                  .id ==
                                              state.selectedAnnonce!.authorID))
                                      ? _buildProfil(context, state)
                                      : SizedBox(),
                              Divider(color: Colors.grey.shade300),
                              // const SizedBox(height: mediumPadding),
                              // Divider(color: Colors.grey.shade300),
                              const SizedBox(height: mediumPadding),
                              Text(
                                "Description",
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    // const SizedBox(height: largePadding),
                    // AppPanelWidget(
                    //   child: Text(state.selectedAnnonce!.descriptionDetaille),
                    // ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: EdgeInsets.all(largePadding),
                        child: Text(
                          state.selectedAnnonce!.descriptionDetaille,
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ),
                    // const SizedBox(height: mediumPadding),
                    Row(
                      children: [
                        InkWell(
                          borderRadius: BorderRadius.circular(22),
                          onTap: (!context.read<AppBloc>().state.isLogged)
                              ? null
                              : () {
                                  context.read<AnnonceBloc>().add(
                                      ReactAnnonceEvent(
                                          id: state.selectedAnnonce!.id,
                                          isLiked:
                                              !state.selectedAnnonce!.isLiked));
                                },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: smallPadding),
                            decoration: BoxDecoration(
                                color: state.selectedAnnonce!.isLiked
                                    ? tertiaryColor.withAlpha(25)
                                    : null,
                                borderRadius: BorderRadius.circular(22)),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child:
                                      (state.selectedAnnonce!.menuParentRef ==
                                              mahaNouvelleMenuRef)
                                          ? const Iconify(Noto.folded_hands,
                                              size: 24)
                                          : const Icon(Icons.thumb_up_outlined),
                                ),
                                Text(
                                  state.selectedAnnonce!.reactionCount
                                      .toString(),
                                  style: const TextStyle(
                                      color: tertiaryColor,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  width: largePadding,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: mediumPadding,
                    ),
                    Divider(
                      color: Colors.grey.shade300,
                      // color: tertiaryColor,
                      // thickness: 2,
                    ),
                    const SizedBox(
                      height: largePadding,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        context.appLoc.comments,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(color: Colors.grey.shade600),
                      ),
                    ),
                    if (context.read<AppBloc>().state.isLogged)
                      const SizedBox(
                        height: mediumPadding,
                      ),
                    if (!context.read<AppBloc>().state.isLogged)
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(context.appLoc.login_required_to_comment),
                      ),
                    if (context.read<AppBloc>().state.isLogged)
                      Form(
                        key: _formCommentaireKey,
                        child: TextFormField(
                          controller: commentaireAnnonceController,
                          onTapOutside: (event) {
                            FocusManager.instance.primaryFocus?.unfocus();
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return context.appLoc.comment_validation_error;
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            errorStyle:
                                const TextStyle(fontWeight: FontWeight.bold),
                            errorMaxLines: 3,
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            labelText: context.appLoc.comment_hint,
                            labelStyle: const TextStyle(color: Colors.grey),
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.grey),
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: tertiaryColor),
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.grey),
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                /// TO DO send data
                                if (_formCommentaireKey.currentState != null &&
                                    _formCommentaireKey.currentState!
                                        .validate()) {
                                  context.read<AnnonceBloc>().add(
                                      NewCommentaireAnnonceEvent(
                                          annonceID: state.selectedAnnonce!.id,
                                          content: commentaireAnnonceController
                                              .text));
                                }
                              },
                              icon: state.commentaireStatus ==
                                      CommentaireStatus.posting
                                  ? const SizedBox(
                                      height: 24,
                                      width: 24,
                                      child: CircularProgressIndicator(),
                                    )
                                  : const Icon(
                                      Ionicons.paper_plane_outline,
                                      color: tertiaryColor,
                                    ),
                            ),
                          ),
                          maxLines: null,
                          keyboardType: TextInputType.multiline,
                        ),
                      ),
                    const SizedBox(
                      height: mediumPadding,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(smallPadding),
                      child: ListView.separated(
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: largePadding),
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: state.selectedAnnonce!.commentaires.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return _buildCommentaire(
                              context,
                              state.selectedAnnonce!.commentaires[index],
                              index);
                        },
                      ),
                    ),
                    if (state.commentaireListStatus ==
                        CommentaireListStatus.loading)
                      const AppLoadingWidget(),
                    if (state.isNextCommentaireListAvailable &&
                        state.commentaireListStatus ==
                            CommentaireListStatus.loaded)
                      Padding(
                          padding: const EdgeInsets.all(smallPadding),
                          child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: TextButton.icon(
                              onPressed: () {
                                context
                                    .read<AnnonceBloc>()
                                    .add(const LoadMoreCommentaireListItem());
                              },
                              icon: const Icon(Icons.keyboard_arrow_down),
                              label: Text(context.appLoc.load_more_coms),
                            ),
                          ))
                  ],
                ),
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
    return Scaffold(
      body: RefreshIndicator(
          onRefresh: () async {
            context.read<AnnonceBloc>().add(LoadAnnonce(id: idRoute));
          },
          child: content),
    );
  }

  Widget _buildOptionSettings(BuildContext context, int index) {
    List<IoniconsData> icons = [Ionicons.time, Ionicons.pencil, Ionicons.trash];
    List<String> options = [
      context.appLoc.extend_validity,
      context.appLoc.modify,
      context.appLoc.delete,
    ];
    return Row(
      children: [
        Icon(icons[index], color: tertiaryColor, size: 24),
        SizedBox(width: mediumPadding),
        Text(options[index], style: Theme.of(context).textTheme.titleSmall),
      ],
    );
    // Container(
    //   decoration: BoxDecoration(
    //     shape: BoxShape.rectangle,
    //     border:
    //         Border.all(color: Colors.grey),
    //   ),
    //   child: PopupMenuButton<int>(
    //     padding: EdgeInsets.all(0),
    //     menuPadding: EdgeInsets.all(0),
    //     icon: const Icon(Ionicons.menu),
    //     tooltip: 'Options',
    //     onSelected: (int value) {
    //       if (value == 1) {
    //         AppRouter.go(
    //           context,
    //           RoutesNames.demandePub,
    //           queryParameters: {
    //             "menuParentRef": state
    //                 .selectedAnnonce!
    //                 .menuParentRef,
    //             "idMenu": state
    //                 .selectedAnnonce!
    //                 .menuParentID
    //                 .toString(),
    //             "title": state
    //                 .selectedAnnonce!.title,
    //             "idAnnonce": state
    //                 .selectedAnnonce!.id
    //                 .toString(),
    //             "isFreeMode": "false",
    //           },
    //           extra:
    //               context.read<AnnonceBloc>(),
    //         );
    //       } else if (value == 2) {
    //         AppRouter.go(
    //           context,
    //           RoutesNames.demandePub,
    //           queryParameters: {
    //             "menuParentRef": state
    //                 .selectedAnnonce!
    //                 .menuParentRef,
    //             "idMenu": state
    //                 .selectedAnnonce!
    //                 .menuParentID
    //                 .toString(),
    //             "title": state
    //                 .selectedAnnonce!.title,
    //             "idAnnonce": state
    //                 .selectedAnnonce!.id
    //                 .toString(),
    //             "isExtendValidityMode":
    //                 "true",
    //           },
    //           extra:
    //               context.read<AnnonceBloc>(),
    //         );
    //       } else if (value == 3) {
    //         context
    //             .read<AnnonceBloc>()
    //             .add(DeleteRecentAnnonceEvent(
    //               annonceType: state
    //                   .selectedAnnonce!
    //                   .annonceType,
    //               annonceID: state
    //                   .selectedAnnonce!.id
    //                   .toString(),
    //             ));
    //       }
    //     },
    //     itemBuilder: (BuildContext context) =>
    //         [
    //       PopupMenuItem<int>(
    //         value: 1,
    //         child: ListTile(
    //           leading: const Icon(
    //               Icons.edit_outlined,
    //               color: tertiaryColor),
    //           title:
    //               Text(context.appLoc.modify),
    //         ),
    //       ),
    //       if (!refFreeAnnonce.contains(state
    //           .selectedAnnonce!
    //           .menuParentRef))
    //         PopupMenuItem<int>(
    //           value: 2,
    //           child: ListTile(
    //             leading: const Icon(
    //                 Icons.timelapse,
    //                 color: tertiaryColor),
    //             title: Text(context
    //                 .appLoc.extend_validity),
    //           ),
    //         ),
    //       PopupMenuItem<int>(
    //         value: 3,
    //         child: ListTile(
    //           leading: const Icon(
    //               Icons.delete,
    //               color: tertiaryColor),
    //           title:
    //               Text(context.appLoc.delete),
    //         ),
    //       ),
    //     ],
    //   ),
    // )
  }

  // Widget _builContentList(BuildContext context, AnnonceState state) {
  //   Widget content = const SizedBox();
  //   if (state.selectedStatus == SelectedStatus.loading ||
  //       state.selectedStatus == SelectedStatus.deleted) {
  //     content = const AppLoadingWidget();
  //   } else if (state.selectedStatus == SelectedStatus.loaded) {
  //     content = SingleChildScrollView(
  //       physics: const AlwaysScrollableScrollPhysics(),
  //       child: Container(
  //         color: Colors.white,
  //         child: Padding(
  //           padding: const EdgeInsets.all(largePadding),
  //           child: Column(
  //             mainAxisSize: MainAxisSize.max,
  //             children: [
  //               Column(
  //                 children: [
  //                   Align(
  //                     alignment: Alignment.topRight,
  //                     child: Container(
  //                       margin: const EdgeInsets.only(bottom: mediumPadding),
  //                       padding: const EdgeInsets.all(mediumPadding),
  //                       decoration: BoxDecoration(
  //                           borderRadius: const BorderRadius.all(
  //                               Radius.circular(mediumPadding)),
  //                           color: Colors.grey.shade300),
  //                       child: Text(
  //                         "ID: ${state.selectedAnnonce!.slug}",
  //                         style: const TextStyle(
  //                           fontWeight: FontWeight.bold,
  //                           fontFamily: "Raleway",
  //                         ),
  //                       ),
  //                     ),
  //                   ),
  //                   AspectRatio(
  //                     aspectRatio: 16 / 9,
  //                     child: PageView(
  //                         controller: pageController,
  //                         children: state.selectedAnnonce!.photos.isEmpty
  //                             ? [
  //                                 Container(
  //                                   color: secondaryColor,
  //                                   child: Image.asset(
  //                                     "assets/imgs/ic_mahafaka.png",
  //                                     fit: BoxFit.fitHeight,
  //                                   ),
  //                                 ),
  //                               ]
  //                             : List.generate(
  //                                 state.selectedAnnonce!.photos.length,
  //                                 (index) => Builder(
  //                                   builder: (BuildContext context) {
  //                                     return OpenContainer(
  //                                       openBuilder: (_, closeContainer) =>
  //                                           HeroPhotoViewRouteWrapper(
  //                                               title: Text(
  //                                                 state.selectedAnnonce!.title,
  //                                                 style: Theme.of(context)
  //                                                     .textTheme
  //                                                     .titleLarge,
  //                                                 textAlign: TextAlign.left,
  //                                               ),
  //                                               urls: state
  //                                                   .selectedAnnonce!.photos
  //                                                   .map(
  //                                                     (e) => e.url,
  //                                                   )
  //                                                   .toList(),
  //                                               selectedImgIndex: index),
  //                                       closedBuilder: (_, closeContainer) =>
  //                                           CachedNetworkImage(
  //                                         imageUrl: state.selectedAnnonce!
  //                                             .photos[index].url,
  //                                         fit: BoxFit.fitHeight,
  //                                         progressIndicatorBuilder: (context,
  //                                                 url, progress) =>
  //                                             const LoadingImageCacheWidget(),
  //                                         errorWidget: (context, url, error) =>
  //                                             Column(
  //                                           mainAxisAlignment:
  //                                               MainAxisAlignment.center,
  //                                           children: [
  //                                             const Icon(Icons.error_outline),
  //                                             Text(context
  //                                                 .appLoc.error_loading_image)
  //                                           ],
  //                                         ),
  //                                       ),
  //                                     );
  //                                   },
  //                                 ),
  //                               )),
  //                   ),
  //                   if (state.selectedAnnonce!.photos.length > 1)
  //                     Padding(
  //                       padding: const EdgeInsets.all(smallPadding),
  //                       child: SmoothPageIndicator(
  //                         controller: pageController,
  //                         count: state.selectedAnnonce!.photos.length,
  //                         onDotClicked: (index) {
  //                           pageController.animateToPage(index,
  //                               duration: const Duration(milliseconds: 250),
  //                               curve: Curves.bounceIn);
  //                         },
  //                         axisDirection: Axis.horizontal,
  //                         effect: const ScrollingDotsEffect(
  //                             activeDotColor: tertiaryColor,
  //                             dotWidth: 12,
  //                             strokeWidth: 4,
  //                             dotHeight: 12,
  //                             paintStyle: PaintingStyle.fill),
  //                       ),
  //                     ),
  //                 ],
  //               ),
  //               const SizedBox(
  //                 height: largePadding,
  //               ),
  //               Row(
  //                 children: [
  //                   Expanded(
  //                     flex: 2,
  //                     child: Column(
  //                       mainAxisAlignment: MainAxisAlignment.start,
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       children: [
  //                         Row(
  //                           mainAxisSize: MainAxisSize.max,
  //                           children: [
  //                             Expanded(
  //                               child: Text(
  //                                 state.selectedAnnonce!.title,
  //                                 style: Theme.of(context).textTheme.titleLarge,
  //                               ),
  //                             ),
  //                             if (context.read<AppBloc>().state.isLogged &&
  //                                 state.selectedAnnonce?.authorID ==
  //                                     context.read<AppBloc>().state.user?.id)
  //                               PopupMenuButton<int>(
  //                                 icon: const Icon(Icons.more_vert),
  //                                 tooltip: 'Options',
  //                                 onSelected: (int value) {
  //                                   if (value == 1) {
  //                                     AppRouter.go(
  //                                       context,
  //                                       RoutesNames.demandePub,
  //                                       queryParameters: {
  //                                         "menuParentRef": state
  //                                             .selectedAnnonce!.menuParentRef,
  //                                         "idMenu": state
  //                                             .selectedAnnonce!.menuParentID
  //                                             .toString(),
  //                                         "title": state.selectedAnnonce!.title,
  //                                         "idAnnonce": state.selectedAnnonce!.id
  //                                             .toString(),
  //                                         "isFreeMode": "false",
  //                                       },
  //                                       extra: context.read<AnnonceBloc>(),
  //                                     );
  //                                   } else if (value == 2) {
  //                                     AppRouter.go(
  //                                       context,
  //                                       RoutesNames.demandePub,
  //                                       queryParameters: {
  //                                         "menuParentRef": state
  //                                             .selectedAnnonce!.menuParentRef,
  //                                         "idMenu": state
  //                                             .selectedAnnonce!.menuParentID
  //                                             .toString(),
  //                                         "title": state.selectedAnnonce!.title,
  //                                         "idAnnonce": state.selectedAnnonce!.id
  //                                             .toString(),
  //                                         "isExtendValidityMode": "true",
  //                                       },
  //                                       extra: context.read<AnnonceBloc>(),
  //                                     );
  //                                   } else if (value == 3) {
  //                                     context
  //                                         .read<AnnonceBloc>()
  //                                         .add(DeleteAnnonceEvent(
  //                                           annonceType: state
  //                                               .selectedAnnonce!.annonceType,
  //                                           annonceID: state.selectedAnnonce!.id
  //                                               .toString(),
  //                                         ));
  //                                   }
  //                                 },
  //                                 itemBuilder: (BuildContext context) => [
  //                                   PopupMenuItem<int>(
  //                                     value: 1,
  //                                     child: ListTile(
  //                                       leading: const Icon(Icons.edit_outlined,
  //                                           color: tertiaryColor),
  //                                       title: Text(context.appLoc.modify),
  //                                     ),
  //                                   ),
  //                                   if (!refFreeAnnonce.contains(
  //                                       state.selectedAnnonce!.menuParentRef))
  //                                     PopupMenuItem<int>(
  //                                       value: 2,
  //                                       child: ListTile(
  //                                         leading: const Icon(Icons.timelapse,
  //                                             color: tertiaryColor),
  //                                         title: Text(
  //                                             context.appLoc.extend_validity),
  //                                       ),
  //                                     ),
  //                                   PopupMenuItem<int>(
  //                                     value: 3,
  //                                     child: ListTile(
  //                                       leading: const Icon(Icons.delete,
  //                                           color: tertiaryColor),
  //                                       title: Text(context.appLoc.delete),
  //                                     ),
  //                                   ),
  //                                 ],
  //                               )
  //                           ],
  //                         ),
  //                         const SizedBox(
  //                           height: largePadding,
  //                         ),
  //                         if (state
  //                                 .selectedAnnonce!.descriptionCourte.isEmpty ||
  //                             state.selectedAnnonce!.descriptionCourte != ".")
  //                           Text(
  //                             state.selectedAnnonce!.descriptionCourte,
  //                             style: const TextStyle(color: Colors.grey),
  //                           ),
  //                         if (state.selectedAnnonce!.contact != "" &&
  //                             (state.selectedAnnonce!.menuParentRef !=
  //                                 blablaZoneMenuRef))
  //                           Padding(
  //                             padding:
  //                                 const EdgeInsets.only(top: mediumPadding),
  //                             child: Row(
  //                               children: [
  //                                 const CircleAvatar(
  //                                   maxRadius: 12,
  //                                   backgroundColor: tertiaryColor,
  //                                   child: const Icon(
  //                                     size: 16,
  //                                     Icons.phone_outlined,
  //                                     color: Colors.white,
  //                                   ),
  //                                 ),
  //                                 const SizedBox(
  //                                   width: mediumPadding,
  //                                 ),
  //                                 Text(
  //                                   state.selectedAnnonce!.contactFormatted,
  //                                   style: TextStyle(
  //                                     fontFamily: "Raleway",
  //                                     fontWeight: FontWeight.w500,
  //                                   ),
  //                                 ),
  //                                 const Spacer(),
  //                                 OutlinedButton(
  //                                   onPressed: () async {
  //                                     try {
  //                                       final Uri url = Uri(
  //                                           scheme: 'tel',
  //                                           path:
  //                                               state.selectedAnnonce!.contact);

  //                                       if (await canLaunchUrl(url)) {
  //                                         await launchUrl(url);
  //                                       } else {
  //                                         throw 'Could not launch $url';
  //                                       }
  //                                     } catch (e) {
  //                                       if (context.mounted) {
  //                                         MessageDisplayerUtils
  //                                             .showToastMessage(
  //                                                 context.appLoc.not_supported);
  //                                       }
  //                                     }
  //                                   },
  //                                   child: Text(context.appLoc.call),
  //                                 ),
  //                               ],
  //                             ),
  //                           ),
  //                         if (state.selectedAnnonce!.emplacement != "")
  //                           Padding(
  //                             padding:
  //                                 const EdgeInsets.only(top: mediumPadding),
  //                             child: Row(
  //                               children: [
  //                                 const CircleAvatar(
  //                                   maxRadius: 12,
  //                                   backgroundColor: tertiaryColor,
  //                                   child: const Icon(
  //                                     size: 16,
  //                                     Icons.place_outlined,
  //                                     color: Colors.white,
  //                                   ),
  //                                 ),
  //                                 const SizedBox(
  //                                   width: mediumPadding,
  //                                 ),
  //                                 Expanded(
  //                                   child: Text(
  //                                     state.selectedAnnonce!.emplacement,
  //                                   ),
  //                                 ),
  //                               ],
  //                             ),
  //                           ),
  //                         Padding(
  //                           padding: const EdgeInsets.symmetric(
  //                               vertical: mediumPadding),
  //                           child: Row(
  //                             mainAxisSize: MainAxisSize.min,
  //                             children: [
  //                               if (state.selectedAnnonce!.menuParentRef !=
  //                                   blablaZoneMenuRef)
  //                                 Text(
  //                                     context.appLoc.announce_by(
  //                                         state.selectedAnnonce!.author),
  //                                     style: Theme.of(context)
  //                                         .textTheme
  //                                         .titleSmall
  //                                         ?.copyWith(color: tertiaryColor)),
  //                               const SizedBox(
  //                                 width: mediumPadding,
  //                               ),
  //                               Text(
  //                                   "• ${AppUtils.getDate(state.selectedAnnonce!.dateDeCreation)}",
  //                                   style: Theme.of(context)
  //                                       .textTheme
  //                                       .titleSmall
  //                                       ?.copyWith(color: tertiaryColor))
  //                             ],
  //                           ),
  //                         )
  //                       ],
  //                     ),
  //                   )
  //                 ],
  //               ),
  //               const SizedBox(
  //                 height: mediumPadding,
  //               ),
  //               AppPanelWidget(
  //                 child: Text(state.selectedAnnonce!.descriptionDetaille),
  //               ),
  //               const SizedBox(
  //                 height: mediumPadding,
  //               ),
  //               Row(
  //                 children: [
  //                   InkWell(
  //                     borderRadius: BorderRadius.circular(22),
  //                     onTap: (!context.read<AppBloc>().state.isLogged)
  //                         ? null
  //                         : () {
  //                             context.read<AnnonceBloc>().add(ReactAnnonceEvent(
  //                                 id: state.selectedAnnonce!.id,
  //                                 isLiked: !state.selectedAnnonce!.isLiked));
  //                           },
  //                     child: Container(
  //                       padding: const EdgeInsets.symmetric(
  //                           horizontal: smallPadding),
  //                       decoration: BoxDecoration(
  //                           color: state.selectedAnnonce!.isLiked
  //                               ? tertiaryColor.withAlpha(25)
  //                               : null,
  //                           borderRadius: BorderRadius.circular(22)),
  //                       child: Row(
  //                         children: [
  //                           Padding(
  //                             padding: const EdgeInsets.all(8.0),
  //                             child: (state.selectedAnnonce!.menuParentRef ==
  //                                     mahaNouvelleMenuRef)
  //                                 ? const Iconify(Noto.folded_hands, size: 24)
  //                                 : const Icon(Icons.thumb_up_outlined),
  //                           ),
  //                           Text(
  //                             state.selectedAnnonce!.reactionCount.toString(),
  //                             style: const TextStyle(
  //                                 color: tertiaryColor,
  //                                 fontWeight: FontWeight.bold),
  //                           ),
  //                           const SizedBox(
  //                             width: largePadding,
  //                           ),
  //                         ],
  //                       ),
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //               const SizedBox(
  //                 height: mediumPadding,
  //               ),
  //               const Divider(
  //                 color: tertiaryColor,
  //                 thickness: 2,
  //               ),
  //               const SizedBox(
  //                 height: mediumPadding,
  //               ),
  //               Align(
  //                 alignment: Alignment.centerLeft,
  //                 child: Text(
  //                   context.appLoc.comments,
  //                   style: const TextStyle(color: Colors.grey),
  //                 ),
  //               ),
  //               if (context.read<AppBloc>().state.isLogged)
  //                 const SizedBox(
  //                   height: mediumPadding,
  //                 ),
  //               if (!context.read<AppBloc>().state.isLogged)
  //                 Container(
  //                   padding: const EdgeInsets.all(8.0),
  //                   child: Text(context.appLoc.login_required_to_comment),
  //                 ),
  //               if (context.read<AppBloc>().state.isLogged)
  //                 Form(
  //                   key: _formCommentaireKey,
  //                   child: TextFormField(
  //                     controller: commentaireAnnonceController,
  //                     onTapOutside: (event) {
  //                       FocusManager.instance.primaryFocus?.unfocus();
  //                     },
  //                     validator: (value) {
  //                       if (value == null || value.isEmpty) {
  //                         return context.appLoc.comment_validation_error;
  //                       }
  //                       return null;
  //                     },
  //                     decoration: InputDecoration(
  //                       errorStyle:
  //                           const TextStyle(fontWeight: FontWeight.bold),
  //                       errorMaxLines: 3,
  //                       floatingLabelBehavior: FloatingLabelBehavior.never,
  //                       labelText: context.appLoc.comment_hint,
  //                       labelStyle: const TextStyle(color: Colors.grey),
  //                       border: OutlineInputBorder(
  //                         borderSide: const BorderSide(color: Colors.grey),
  //                         borderRadius: BorderRadius.circular(8.0),
  //                       ),
  //                       focusedBorder: OutlineInputBorder(
  //                         borderSide: const BorderSide(color: tertiaryColor),
  //                         borderRadius: BorderRadius.circular(8.0),
  //                       ),
  //                       enabledBorder: OutlineInputBorder(
  //                         borderSide: const BorderSide(color: Colors.grey),
  //                         borderRadius: BorderRadius.circular(8.0),
  //                       ),
  //                       suffixIcon: IconButton(
  //                         onPressed: () {
  //                           /// TO DO send data
  //                           if (_formCommentaireKey.currentState != null &&
  //                               _formCommentaireKey.currentState!.validate()) {
  //                             context.read<AnnonceBloc>().add(
  //                                 NewCommentaireAnnonceEvent(
  //                                     annonceID: state.selectedAnnonce!.id,
  //                                     content:
  //                                         commentaireAnnonceController.text));
  //                           }
  //                         },
  //                         icon: state.commentaireStatus ==
  //                                 CommentaireStatus.posting
  //                             ? const SizedBox(
  //                                 height: 24,
  //                                 width: 24,
  //                                 child: CircularProgressIndicator(),
  //                               )
  //                             : const Icon(
  //                                 Icons.send,
  //                                 color: tertiaryColor,
  //                               ),
  //                       ),
  //                     ),
  //                     maxLines: null,
  //                     keyboardType: TextInputType.multiline,
  //                   ),
  //                 ),
  //               const SizedBox(
  //                 height: mediumPadding,
  //               ),
  //               Padding(
  //                 padding: const EdgeInsets.all(smallPadding),
  //                 child: ListView.builder(
  //                   physics: const NeverScrollableScrollPhysics(),
  //                   itemCount: state.selectedAnnonce!.commentaires.length,
  //                   shrinkWrap: true,
  //                   itemBuilder: (context, index) {
  //                     return _buildCommentaire(context,
  //                         state.selectedAnnonce!.commentaires[index], index);
  //                   },
  //                 ),
  //               ),
  //               if (state.commentaireListStatus ==
  //                   CommentaireListStatus.loading)
  //                 const AppLoadingWidget(),
  //               if (state.isNextCommentaireListAvailable &&
  //                   state.commentaireListStatus == CommentaireListStatus.loaded)
  //                 Padding(
  //                     padding: const EdgeInsets.all(smallPadding),
  //                     child: Directionality(
  //                       textDirection: TextDirection.rtl,
  //                       child: TextButton.const Icon(
  //                         onPressed: () {
  //                           context
  //                               .read<AnnonceBloc>()
  //                               .add(const LoadMoreCommentaireListItem());
  //                         },
  //                         icon: const Icon(Icons.keyboard_arrow_down),
  //                         label: Text(context.appLoc.load_more_coms),
  //                       ),
  //                     ))
  //             ],
  //           ),
  //         ),
  //       ),
  //     );
  //   } else {
  //     content = const CustomScrollView(
  //         physics: AlwaysScrollableScrollPhysics(),
  //         slivers: [
  //           SliverFillRemaining(
  //             child: Center(
  //               child: ErrorPageWidget(),
  //             ),
  //           ),
  //         ]);
  //   }
  //   return Scaffold(
  //     body: RefreshIndicator(
  //         onRefresh: () async {
  //           context.read<AnnonceBloc>().add(LoadAnnonce(id: idRoute));
  //         },
  //         child: content),
  //   );
  // }

  Widget _buildProfil(BuildContext context, AnnonceState state) {
    return BlocProvider(
      create: (context) => GetIt.instance<ProfilBloc>()
        ..add(UserProfilLoaded(id: state.selectedAnnonce!.authorID))
        ..add(AnnonceListUserProfilCountLoaded(
            id: state.selectedAnnonce!.authorID)),
      child: BlocBuilder<ProfilBloc, ProfilState>(
        builder: (context, profilState) {
          if (profilState.profilUserStatus == ProfilUserStatus.loading) {
            return Container(
              height: 30,
              width: MediaQuery.of(context).size.width,
              color: Colors.grey.shade300,
            );
          }
          return MaterialButton(
            padding: EdgeInsets.all(0),
            onPressed: () {
              AppRouter.go(
                context,
                RoutesNames.profilDetail,
                queryParameters: {
                  "authorID": "${state.selectedAnnonce!.authorID}"
                },
              );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(context.appLoc.announce_by(""),
                        style: Theme.of(context).textTheme.titleSmall),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // if (state.selectedAnnonce!
                        //         .menuParentRef !=
                        //     blablaZoneMenuRef)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              spacing: 10.0,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(24),
                                  child: SizedBox(
                                    width: 32,
                                    height: 32,
                                    child: CachedNetworkImage(
                                      imageUrl: profilState.user.avatarUrl,
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
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(state.selectedAnnonce!.author,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall
                                            ?.copyWith(fontSize: 12)),
                                    Text(
                                        "${profilState.annoncesCount} annonces",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall
                                            ?.copyWith(
                                                color: Colors.grey,
                                                fontSize: 12)),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                const Icon(
                  Ionicons.chevron_forward,
                  color: Colors.grey,
                  size: 16,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildPhoneNumber(
      BuildContext context, AnnonceState state, String contact) {
    return Padding(
      padding: const EdgeInsets.only(top: mediumPadding),
      child: Row(
        children: [
          const CircleAvatar(
            maxRadius: 16,
            backgroundColor: tertiaryColor,
            child: const Icon(
              size: 22,
              Ionicons.call,
              color: Colors.white,
            ),
          ),
          const SizedBox(
            width: mediumPadding,
          ),
          Text(
            contact,
            style: TextStyle(
              fontFamily: "Raleway",
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
          const Spacer(),
          SizedBox(
            height: 40,
            child: OutlinedButton(
              style: ButtonStyle(
                shape: WidgetStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                ),
                backgroundColor: WidgetStatePropertyAll(tertiaryColor),
              ),
              onPressed: () async {
                try {
                  final Uri url = Uri(
                    scheme: 'tel',
                    path: state.selectedAnnonce!.contact,
                  );

                  if (await canLaunchUrl(url)) {
                    await launchUrl(url, mode: LaunchMode.externalApplication);
                  } else {
                    throw 'Could not launch $url';
                  }
                } catch (e) {
                  if (context.mounted) {
                    MessageDisplayerUtils.showToastMessage(
                        context.appLoc.not_supported);
                  }
                }
              },
              child: Text(
                context.appLoc.call,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCommentaire(
      BuildContext context, Commentaire commentaire, int commentaireIndex) {
    Widget commentaireWidget = const SizedBox();
    bool isCommentaireInProccess =
        context.read<AnnonceBloc>().state.idCommentaireInProcess ==
            commentaire.id;
    commentaireWidget = Row(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      spacing: mediumPadding,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: SizedBox(
            width: 32,
            height: 32,
            child: CachedNetworkImage(
              imageUrl: commentaire.authorAvatarUrl,
              fit: BoxFit.cover,
              progressIndicatorBuilder: (context, url, progress) =>
                  const LoadingImageCacheWidget(),
              errorWidget: (context, url, error) => const Icon(
                Icons.error,
                size: 42,
              ),
            ),
          ),
        ),
        // const CircleAvatar(
        //   backgroundColor: Colors.transparent,
        //   maxRadius: 16,
        //   child: const Icon(
        //     Icons.account_circle,
        //     color: tertiaryColor,
        //     size: 32,
        //   ),
        // ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(mediumPadding),
                decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(16.0)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(commentaire.authorName,
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                )),
                        if (context.read<AppBloc>().state.user != null &&
                            commentaire.authorID ==
                                context
                                    .read<AppBloc>()
                                    .state
                                    .user!
                                    .id
                                    .toString() &&
                            context.read<AppBloc>().state.isLogged)
                          IconButton(
                            padding: EdgeInsets.zero,
                            constraints:
                                BoxConstraints(maxHeight: 24, maxWidth: 24),
                            onPressed: context
                                        .read<AnnonceBloc>()
                                        .state
                                        .idCommentaireInProcess >=
                                    0
                                ? null
                                : () {
                                    context.read<AnnonceBloc>().add(
                                        DeleteCommentaireAnnonceEvent(
                                            id: commentaire.id,
                                            annonceID: commentaire.annonceID));
                                  },
                            icon: isCommentaireInProccess
                                ? const AppLoadingWidget(
                                    size: 18,
                                  )
                                : const Icon(
                                    Icons.close,
                                    size: 24,
                                  ),
                            iconSize: 16,
                          )
                      ],
                    ),
                    const SizedBox(height: mediumPadding),
                    Text(commentaire.content),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(mediumPadding),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                        padding: EdgeInsets.zero,
                        constraints: BoxConstraints(),
                        onPressed: (!context.read<AppBloc>().state.isLogged)
                            ? null
                            : () {
                                context.read<AnnonceBloc>().add(
                                    UpdateCommentaireAnnonceEvent(
                                        commentaire: commentaire.copyWith(
                                            hasLike: !commentaire.hasLike),
                                        index: commentaireIndex));
                              },
                        icon: commentaire.hasLike
                            ? const Icon(
                                Icons.favorite,
                                color: tertiaryColor,
                                size: 16,
                              )
                            : const Icon(
                                Icons.favorite_border,
                                color: tertiaryColor,
                                size: 16,
                              )),
                    Text(
                      commentaire.likeCount.toString(),
                      style: const TextStyle(color: tertiaryColor),
                    ),
                    const SizedBox(
                      width: largePadding,
                    ),
                    Text(AppUtils.getDate(commentaire.dateDeCreation)),
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
    return commentaireWidget;
  }
}
