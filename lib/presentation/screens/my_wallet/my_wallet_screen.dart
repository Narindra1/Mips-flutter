import 'dart:math';

import 'package:MIPS/common/constants/constant.dart';
import 'package:MIPS/common/utils/app_utils.dart';
import 'package:MIPS/presentation/bloc/app_bloc.dart';
import 'package:MIPS/presentation/configurations/colors_list.dart';
import 'package:MIPS/presentation/configurations/extension_for_localization.dart';
import 'package:MIPS/presentation/routes/route.dart';
import 'package:MIPS/presentation/routes/router.dart';
import 'package:MIPS/presentation/screens/base/base_screen.dart';
import 'package:MIPS/presentation/screens/my_menu_profil/widgets/history_mips.dart';
import 'package:MIPS/presentation/screens/my_menu_profil/widgets/text_operation.dart';
import 'package:MIPS/presentation/widgets/app_panel_widget.dart';
import 'package:MIPS/presentation/widgets/empty_list_widget.dart';
import 'package:MIPS/presentation/widgets/error_page_widget.dart';
import 'package:MIPS/presentation/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ionicons/ionicons.dart';

class MyWalletScreen extends StatefulWidget {
  const MyWalletScreen({super.key});

  @override
  State<MyWalletScreen> createState() => _MyWalletScreenState();
}

class _MyWalletScreenState extends State<MyWalletScreen> {
  // final List<bool> _selectedOperations = <bool>[true, false, false, false];
  bool vertical = false;
  int? _value = 0;
  // double _headerHeight = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> operations = <Widget>[
      TextOperation(title: context.appLoc.all),
      TextOperation(title: context.appLoc.earnings),
      TextOperation(title: context.appLoc.expenses),
      TextOperation(title: context.appLoc.transfers),
    ];

    return BaseScreen(
      useDefaultAnnonceSponsPart: true,
      content: CustomScrollView(
        shrinkWrap: true,
        slivers: <Widget>[
          SliverAppBar(
            automaticallyImplyLeading: false,
            pinned: true,
            expandedHeight: 150.0, // Increased height to accommodate content
            backgroundColor: Colors.white,
            stretch: false,
            flexibleSpace: LayoutBuilder(
              builder: (context, constraints) {
                final top = constraints.biggest.height;
                final isCollapsed =
                    top <= kToolbarHeight + MediaQuery.of(context).padding.top;

                return Stack(
                  children: [
                    // Your expanded background content - NOW CLICKABLE
                    if (!isCollapsed)
                      SingleChildScrollView(
                        // Add this to prevent overflow
                        physics:
                            const NeverScrollableScrollPhysics(), // Disable independent scrolling
                        child: SizedBox(
                          height: 160.0, // Match expandedHeight
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: mediumPadding,
                              vertical: largePadding,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.circular(largePadding),
                                    boxShadow: [
                                      BoxShadow(
                                        offset: Offset(0, 0),
                                        color: Colors.grey.shade400,
                                        blurRadius: 2,
                                        spreadRadius: 2,
                                      ),
                                    ],
                                  ),
                                  child: ClipRRect(
                                    borderRadius:
                                        BorderRadius.circular(largePadding),
                                    child: Stack(
                                      children: [
                                        AppPanelWidget(
                                          padding:
                                              EdgeInsets.all(mediumPadding),
                                          child: Align(
                                            alignment: Alignment.center,
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Wrap(
                                                  crossAxisAlignment:
                                                      WrapCrossAlignment.center,
                                                  alignment:
                                                      WrapAlignment.center,
                                                  // mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    Image.asset(
                                                      width: 32,
                                                      height: 32,
                                                      mipsCoin,
                                                      fit: BoxFit.cover,
                                                    ),
                                                    const SizedBox(
                                                        width: smallPadding),
                                                    Text(
                                                      AppUtils.formatNumberWithSpaces(
                                                          context
                                                                  .read<
                                                                      AppBloc>()
                                                                  .state
                                                                  .user
                                                                  ?.soldeFAKA ??
                                                              0),
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .titleLarge!
                                                          .copyWith(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(
                                                    height: smallPadding),
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
                                                const SizedBox(
                                                    height: mediumPadding),
                                                SizedBox(
                                                  height: 40,
                                                  child: FilledButton(
                                                    style: ButtonStyle(
                                                        shape: WidgetStatePropertyAll(
                                                            RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            16)))),
                                                    onPressed: () {
                                                      AppRouter.go(
                                                          context,
                                                          RoutesNames
                                                              .passwordGuard,
                                                          extra: RoutesNames
                                                              .transfertFaka);
                                                    },
                                                    child: Text(context.appLoc
                                                        .transferer_faka),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
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
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                    // Your collapsed title (unchanged)
                    if (isCollapsed)
                      Container(
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
                        child: Stack(
                          children: [
                            Positioned(
                              top: 0,
                              bottom: 0,
                              left: 50,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Wrap(
                                    crossAxisAlignment:
                                        WrapCrossAlignment.center,
                                    alignment: WrapAlignment.center,
                                    children: [
                                      Image.asset(
                                        width: 24,
                                        height: 24,
                                        mipsCoin,
                                        fit: BoxFit.cover,
                                      ),
                                      const SizedBox(width: smallPadding),
                                      Text(
                                        AppUtils.formatNumberWithSpaces(context
                                                .read<AppBloc>()
                                                .state
                                                .user
                                                ?.soldeFAKA ??
                                            0),
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium,
                                      ),
                                    ],
                                  ),
                                  Text(
                                    context.appLoc.menu_profil_solde_disponible,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall
                                        ?.copyWith(color: Colors.grey.shade700),
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              top: -20,
                              left: -60,
                              child: Container(
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                  color: tertiaryColor,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                            Positioned(
                              top: -40,
                              left: -30,
                              child: Container(
                                height: 80,
                                width: 80,
                                decoration: BoxDecoration(
                                  color: secondaryColor.withAlpha(200),
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                );
              },
            ),
          ),
          // SliverPersistentHeader(
          //   pinned: true,
          //   delegate: ResponsiveSliverHeaderDelegate(
          //     height: _headerHeight == 0 ? 125.0 : _headerHeight,
          //     child: MeasureSize(
          //       onChange: (size) {
          //         if (_headerHeight != size.height) {
          //           setState(() {
          //             _headerHeight = size.height;
          //           });
          //         }
          //       },
          //       child: Container(
          //         decoration: BoxDecoration(
          //           color: Colors.white,
          //           boxShadow: [
          //             BoxShadow(
          //               offset: Offset(0, 0),
          //               color: Colors.grey.shade200,
          //               blurRadius: 1,
          //               spreadRadius: 1,
          //             ),
          //           ],
          //         ),
          //         padding: const EdgeInsets.all(8),
          //         child: Column(
          //           crossAxisAlignment: CrossAxisAlignment.start,
          //           mainAxisSize: MainAxisSize.min, // 🔥 IMPORTANT
          //           children: [
          //             Text(
          //               context.appLoc.list_of_operations,
          //               style: Theme.of(context).textTheme.titleMedium,
          //             ),
          //             const SizedBox(height: mediumPadding),
          //             Wrap(
          //               spacing: 5,
          //               runSpacing: 5,
          //               children: List.generate(
          //                 operations.length,
          //                 (index) => ChoiceChip(
          //                   label: operations[index],
          //                   showCheckmark: false,
          //                   selected: _value == index,
          //                   onSelected: (selected) {
          //                     setState(() {
          //                       _value = selected ? index : _value;
          //                     });
          //                   },
          //                   color: WidgetStateProperty.resolveWith(
          //                     (states) => states.contains(WidgetState.selected)
          //                         ? secondaryColor
          //                         : Colors.white,
          //                   ),
          //                   labelPadding: EdgeInsets.zero,
          //                 ),
          //               ),
          //             ),
          //           ],
          //         ),
          //       ),
          //     ),
          //   ),
          // ),

          SliverPersistentHeader(
            floating: false,
            pinned: true,
            delegate: _SliverAppBarDelegate(
              minHeight: 125,
              maxHeight: 125,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 0),
                      color: Colors.grey.shade200,
                      blurRadius: 1,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        context.appLoc.list_of_operations,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: mediumPadding),
                      Wrap(
                        spacing: 5.0,
                        runSpacing: 5.0,
                        children: List<Widget>.generate(operations.length,
                            (int index) {
                          return ChoiceChip(
                            label: operations[index],
                            showCheckmark: false,
                            selected: _value == index,
                            onSelected: (bool selected) {
                              setState(() {
                                _value = selected ? index : _value;
                              });
                            },
                            color: WidgetStateProperty.resolveWith<Color>(
                              (states) {
                                if (states.contains(WidgetState.selected)) {
                                  return secondaryColor;
                                }
                                return Colors.white;
                              },
                            ),
                            labelPadding: EdgeInsets.all(0),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          BlocProvider.value(
            value: context.read<AppBloc>()
              ..add(LoadHistoryFakaChangeEvent(page: 1)),
            child: BlocBuilder<AppBloc, AppState>(
              builder: (context, state) {
                Widget content = const SizedBox();
                if (state.historyFakaListStatus ==
                    HistoryFakaListStatus.loading) {
                  content = SliverFillRemaining(
                      child: Center(child: AppLoadingWidget()));
                } else if (state.historyFakaListStatus ==
                    HistoryFakaListStatus.loaded) {
                  content = SliverToBoxAdapter(
                    child: SingleChildScrollView(
                      physics: const NeverScrollableScrollPhysics(),
                      child: Padding(
                        padding: const EdgeInsets.all(mediumPadding),
                        child: _buildListHistory(context, state, _value!),
                      ),
                    ),
                  );
                } else {
                  content = SliverFillRemaining(
                    child: Center(
                      child: ErrorPageWidget(),
                    ),
                  );
                }
                return content;
              },
            ),
          ),
        ],
      ),
      title: Text(
        context.appLoc.my_wallet,
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
            Ionicons.chevron_back,
            color: Colors.black,
          )),
      backgroundColor: Colors.white,
    );
  }
}

Widget _buildListHistory(BuildContext context, AppState state, int value) {
  final filteredTransactions = state.transactionHistory.where((tx) {
    if (value == 0) {
      return true;
    } else if (value == 1) {
      return [
        "CONNEXION_QUOTIDIENNE",
        "BONUS_ANNONCE",
        "CONSULTER_ANNONCE",
        "DONATION_GRANT",
        "PARTICIPER_SONDAGE",
        "ADMIN_GRANT",
      ].contains(tx.type);
    } else if (value == 2) {
      return ["PROLONGER_OFFRE", "ACHAT_OFFRE_KARA"].contains(tx.type);
    } else if (value == 3) {
      return ["USER_TRANSFER"].contains(tx.type);
    }
    return false;
  }).toList();

  if (filteredTransactions.isNotEmpty) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: filteredTransactions.length,
      itemBuilder: (context, index) {
        return HistoryMips(
          key: ValueKey("history_$index"),
          appState: state,
          index: state.transactionHistory.indexOf(filteredTransactions[index]),
        );
      },
    );
  }
  return EmptyListWidget(listType: ListType.message);
}

// class MeasureSize extends StatefulWidget {
//   final Widget child;
//   final ValueChanged<Size> onChange;

//   const MeasureSize({
//     super.key,
//     required this.child,
//     required this.onChange,
//   });

//   @override
//   State<MeasureSize> createState() => _MeasureSizeState();
// }

// class _MeasureSizeState extends State<MeasureSize> {
//   Size? oldSize;

//   @override
//   Widget build(BuildContext context) {
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       final size = context.size;
//       if (size != null && oldSize != size) {
//         oldSize = size;
//         widget.onChange(size);
//       }
//     });
//     return widget.child;
//   }
// }

// class ResponsiveSliverHeaderDelegate extends SliverPersistentHeaderDelegate {
//   final Widget child;
//   final double height;

//   ResponsiveSliverHeaderDelegate({
//     required this.child,
//     required this.height,
//   });

//   @override
//   double get minExtent => height;

//   @override
//   double get maxExtent => height;

//   @override
//   Widget build(
//     BuildContext context,
//     double shrinkOffset,
//     bool overlapsContent,
//   ) {
//     return child;
//   }

//   @override
//   bool shouldRebuild(covariant ResponsiveSliverHeaderDelegate oldDelegate) {
//     return height != oldDelegate.height || child != oldDelegate.child;
//   }
// }

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
