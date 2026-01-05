// import 'package:MIPS/common/constants/constant.dart';
// import 'package:MIPS/common/common.dart';
// import 'package:MIPS/domain/entities/menu.dart';
// import 'package:MIPS/presentation/configurations/extension_for_localization.dart';
// import 'package:MIPS/presentation/routes/route.dart';
// import 'package:MIPS/presentation/routes/router.dart';
// import 'package:MIPS/presentation/screens/base/base_content.dart';
// import 'package:MIPS/presentation/screens/base/base_screen.dart';
// import 'package:MIPS/presentation/bloc/menu_screen_bloc.dart';
// import 'package:MIPS/presentation/screens/my_menu_profil/my_menu_profil_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:get_it/get_it.dart';
// import '../../../domain/usecases/screens/get_screen_by_idroute_usecase.dart';
// import '../../bloc/app_bloc.dart';
// import '../../configurations/colors_list.dart';
// import '../../widgets/error_page_widget.dart';
// import '../../widgets/loading_widget.dart';
// import '../base/base_menu_screen.dart';

// class MenuScreen extends StatelessWidget {
//   final String screenId;
//   final String pageName;
//   final GetScreenByIDRouteUseCase getScreenByIDRouteUseCase;

//   const MenuScreen({
//     super.key,
//     required this.pageName,
//     required this.screenId,
//     required this.getScreenByIDRouteUseCase,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => GetIt.instance<MenuScreenBloc>()
//         ..add(LoadMenuScreenEvent(id: screenId)),
//       child: BlocConsumer<AppBloc, AppState>(
//         listener: (context, state) {
//           if (state.lang.toString() !=
//               context.read<MenuScreenBloc>().state.lang) {
//             context
//                 .read<MenuScreenBloc>()
//                 .add(MenuLangChangeEvent(lang: state.lang.toString()));
//           }
//         },
//         builder: (context, state) {
//           return BlocListener<MenuScreenBloc, MenuScreenState>(
//             listener: (context, state) {
//               if (state.screenEntity != null) {
//                 if (screenId == "0000") {
//                   context.read<AppBloc>().add(SetSponsAndPartenerEvent(
//                       annonceSponsor: state.screenEntity?.annonceSponsor,
//                       annoncePartenaire: state.screenEntity?.annoncePartner));
//                 } else {
//                   context.read<AppBloc>().add(
//                       SetAnnonceSponsorPartenaireNavEvent(
//                           annoncesPartenaire:
//                               state.screenEntity?.annoncePartner,
//                           annoncesSponsor: state.screenEntity?.annonceSponsor));
//                 }
//               }
//             },
//             listenWhen: (previous, current) =>
//                 previous.screenEntity != null &&
//                 current.screenEntity != null &&
//                 ((previous.screenEntity != current.screenEntity ||
//                     previous.screenEntity != current.screenEntity)),
//             child: BlocBuilder<MenuScreenBloc, MenuScreenState>(
//               builder: (context, state) {
//                 Widget pageContent = const SizedBox();
//                 if (state.status == Status.loaded &&
//                     state.screenEntity != null) {
//                   /// Main home screen
//                   if (screenId == "0000") {
//                     pageContent = BaseContent(
//                       menuItems: state.screenEntity!.menusChildList,
//                       listMode: ListMode.mainMenu,
//                     );
//                   } else {
//                     pageContent = BaseContent(
//                       menuItems: state.screenEntity!.menusChildList,
//                       listMode: ListMode.scroll,
//                     );
//                   }
//                 } else if (state.status == Status.error) {
//                   pageContent = const CustomScrollView(
//                       physics: AlwaysScrollableScrollPhysics(),
//                       slivers: [
//                         SliverFillRemaining(
//                           child: Center(
//                             child: ErrorPageWidget(),
//                           ),
//                         ),
//                       ]);
//                 } else if (state.status == Status.loading) {
//                   pageContent = const Center(child: AppLoadingWidget());
//                 } else {
//                   pageContent = SingleChildScrollView(
//                     physics: const AlwaysScrollableScrollPhysics(),
//                     child: Center(
//                         child: Column(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         Image.asset(
//                           "assets/imgs/ic_not_found.png",
//                           height: 100,
//                           width: 100,
//                         ),
//                         Text(context.appLoc.page_not_found),
//                       ],
//                     )),
//                   );
//                 }

//                 /// Main menu screen
//                 if (screenId == "0000") {
//                   return BaseScreen(
//                       useDefaultAnnonceSponsPart: true,
//                       backgroundColor: Colors.grey.shade300,
//                       content: RefreshIndicator(
//                           onRefresh: () async {
//                             context
//                                 .read<MenuScreenBloc>()
//                                 .add(LoadMenuScreenEvent(id: screenId));
//                           },
//                           child: pageContent),
//                       leading: GestureDetector(
//                         onTap: () {
//                           AppRouter.go(context, RoutesNames.appAbout);
//                         },
//                         child: Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Badge(
//                             backgroundColor: tertiaryColor,
//                             isLabelVisible:
//                                 context.read<AppBloc>().state.updateStatus ==
//                                     UpdateStatus.updateVersionAvailable,
//                             label: const Icon(
//                               Icons.arrow_upward,
//                               color: Colors.white,
//                               size: 10,
//                             ),
//                             child: ClipRRect(
//                                 borderRadius:
//                                     BorderRadius.circular(mediumPadding),
//                                 child:
//                                     Image.asset("assets/imgs/ic_mahafaka.png")),
//                           ),
//                         ),
//                       ),
//                       appBarAction: [
//                         // Utilisateur n'est pas connectée.
//                         // if (!context.read<AppBloc>().state.isLogged)
//                         //   OutlinedButton(
//                         //     onPressed: () {
//                         //       AppRouter.go(context, RoutesNames.login);
//                         //     },
//                         //     child: Text(context.appLoc.connexion),
//                         //   ),
//                         IconButton(
//                           onPressed: () {
//                             AppRouter.go(context, RoutesNames.globalSearch);
//                           },
//                           icon: Icon(
//                             Icons.search,
//                             color: Theme.of(context).colorScheme.primary,
//                           ),
//                         ),
//                         if (!context.read<AppBloc>().state.isLogged)
//                           IconButton(
//                               onPressed: () {
//                                 AppRouter.go(context, RoutesNames.login);
//                               },
//                               icon: Badge(
//                                   backgroundColor:
//                                       Theme.of(context).colorScheme.primary,
//                                   isLabelVisible: false,
//                                   child: const Icon(
//                                       Icons.notifications_outlined))),
//                         if (context.read<AppBloc>().state.isLogged)
//                           IconButton(
//                               onPressed: () {
//                                 AppRouter.go(context, RoutesNames.message);
//                               },
//                               icon: Badge(
//                                   isLabelVisible: context
//                                           .read<AppBloc>()
//                                           .state
//                                           .unreadMessageCount >
//                                       0,
//                                   label: Text((context
//                                               .read<AppBloc>()
//                                               .state
//                                               .unreadMessageCount >
//                                           99)
//                                       ? "+99"
//                                       : context
//                                           .read<AppBloc>()
//                                           .state
//                                           .unreadMessageCount
//                                           .toString()),
//                                   backgroundColor:
//                                       Theme.of(context).colorScheme.primary,
//                                   child: const Icon(
//                                       Icons.notifications_outlined))),
//                         // Paramètres pour modifier les langues, tailles de polices, ...
//                         // IconButton(
//                         //     onPressed: () {
//                         //       AppRouter.go(context, RoutesNames.appSettings);
//                         //     },
//                         //     icon: const Icon(Icons.settings_outlined)),
//                       ],
//                       title: Row(
//                         children: [
//                           Text(pageName),
//                         ],
//                       ));
//                 } else if (screenId == "7000" /* For my menu*/) {
//                   return const MyMenuProfilScreen();
//                 } else {
//                   return BaseMenuScreen(
//                       backgroundColor: Colors.grey.shade300,
//                       content: RefreshIndicator(
//                           onRefresh: () async {
//                             context
//                                 .read<MenuScreenBloc>()
//                                 .add(LoadMenuScreenEvent(id: screenId));
//                           },
//                           child: pageContent),
//                       menuAction: null,
//                       title: Text(
//                         pageName,
//                       ));
//                 }
//               },
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
