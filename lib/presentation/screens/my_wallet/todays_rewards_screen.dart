import 'dart:math';

import 'package:mips/common/common.dart';
import 'package:mips/presentation/configurations/extension_for_localization.dart';
import 'package:mips/presentation/screens/base/base_screen.dart';
import 'package:mips/presentation/screens/my_wallet/bloc/rewards_bloc.dart';
import 'package:mips/presentation/screens/my_wallet/widgets/reward_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

class TodaysRewardsScreen extends StatefulWidget {
  const TodaysRewardsScreen({super.key, required this.solde});
  final int solde;

  @override
  State<TodaysRewardsScreen> createState() => _TodaysRewardsScreenState();
}

class _TodaysRewardsScreenState extends State<TodaysRewardsScreen>
    with TickerProviderStateMixin {
  late AnimationController c1;
  late AnimationController c2;
  late AnimationController c3;
  late AnimationController c4;

  @override
  void initState() {
    super.initState();

    c1 = AnimationController(vsync: this, duration: Duration(seconds: 3))
      ..repeat(reverse: true);

    c2 = AnimationController(vsync: this, duration: Duration(seconds: 4))
      ..repeat(reverse: true);

    c3 = AnimationController(vsync: this, duration: Duration(seconds: 5))
      ..repeat(reverse: true);

    c4 = AnimationController(vsync: this, duration: Duration(seconds: 6))
      ..repeat(reverse: true);
  }

  @override
  void dispose() {
    c1.dispose(); // OBLIGATOIRE
    c2.dispose(); // OBLIGATOIRE
    c3.dispose(); // OBLIGATOIRE
    c4.dispose(); // OBLIGATOIRE
    super.dispose();
  }

  double sinus(AnimationController c, double amplitude) {
    return sin(c.value * 0.5 * pi) * amplitude;
  }

  double rotation(AnimationController c, double speed) {
    return c.value * 0.5 * pi * speed;
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      useDefaultAnnonceSponsPart: true,
      content: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.grey.shade100.withAlpha(200),
              Colors.grey.shade100.withAlpha(100),
              Colors.grey.shade100.withAlpha(88),
              Colors.grey.shade100.withAlpha(88),
              Colors.grey.shade100,
              Colors.grey.shade100.withAlpha(70),
            ],
          ),
        ),
        child: Stack(
          children: [
            /// BACKGROUND ANIMATED COINS
            Positioned.fill(
              child: Stack(
                children: [
                  AnimatedBuilder(
                    animation: c1,
                    builder: (_, __) {
                      return Positioned(
                        top: 0 + sinus(c1, 10),
                        right: 0 + sinus(c1, 5),
                        child: Transform.rotate(
                          angle: rotation(c1, 1.2),
                          child: Image.asset(
                            "assets/imgs/mips_coin.png",
                            height: 32,
                            width: 32,
                          ),
                        ),
                      );
                    },
                  ),
                  AnimatedBuilder(
                    animation: c2,
                    builder: (_, __) {
                      return Positioned(
                        top: 10 + sinus(c2, 20),
                        right: 20 + sinus(c2, 10),
                        child: Image.asset(
                          "assets/imgs/mips_coin.png",
                          height: 100,
                          width: 100,
                        ),
                      );
                    },
                  ),
                  AnimatedBuilder(
                    animation: c3,
                    builder: (_, __) {
                      return Positioned(
                        top: 20 + sinus(c3, 5),
                        right: 120 + sinus(c3, 8),
                        child: Transform.rotate(
                          angle: rotation(c3, 1.2),
                          child: Image.asset(
                            "assets/imgs/mips_coin.png",
                            height: 8,
                            width: 8,
                          ),
                        ),
                      );
                    },
                  ),
                  AnimatedBuilder(
                    animation: c4,
                    builder: (_, __) {
                      return Positioned(
                        top: 70 + sinus(c4, 15),
                        right: 120 + sinus(c4, 6),
                        child: Transform.rotate(
                          angle: rotation(c4, 1.2),
                          child: Image.asset(
                            "assets/imgs/mips_coin.png",
                            height: 16,
                            width: 16,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),

            /// FOREGROUND CONTENT (scrolls over)
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: largePadding * 2),
                        Row(
                          children: [
                            Image.asset(
                              "assets/imgs/mips_coin.png",
                              height: 32,
                              width: 32,
                            ),
                            SizedBox(width: 8),
                            Text(
                              AppUtils.formatNumberWithSpaces(widget.solde),
                              style: Theme.of(context).textTheme.titleLarge!
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Text(context.appLoc.menu_profil_solde_disponible),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.rectangle,
                      // border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                      ),
                    ),
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey.shade200.withAlpha(200),
                        ),
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Colors.grey.shade100.withAlpha(200),
                            Colors.grey.shade100.withAlpha(100),
                            Colors.grey.shade100.withAlpha(88),
                            Colors.grey.shade100.withAlpha(88),
                            Colors.grey.shade100,
                            Colors.grey.shade100.withAlpha(70),
                          ],
                        ),
                        // color: Colors.grey.shade100,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16),
                        ),
                      ),
                      child: BlocProvider(
                        create: (context) =>
                            GetIt.instance<RewardsBloc>()
                              ..add(LoadRewardListEvent()),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              context.appLoc.rewards_title,
                              style: Theme.of(context).textTheme.titleLarge!
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                            // const SizedBox(height: smallPadding),
                            // RichText(
                            //   text: TextSpan(
                            //     text: context.appLoc.rewards_subtitle1,
                            //     children: [
                            //       TextSpan(
                            //           text:
                            //               " ${context.appLoc.rewards_subtitle2} ",
                            //           style: Theme.of(context)
                            //               .textTheme
                            //               .bodySmall!
                            //               .copyWith(
                            //                 fontWeight: FontWeight.w800,
                            //                 color: tertiaryColor,
                            //               )),
                            //       TextSpan(
                            //           text: context.appLoc.rewards_subtitle3),
                            //     ],
                            //     style: Theme.of(context).textTheme.bodySmall,
                            //   ),
                            // ),
                            const SizedBox(height: largePadding),
                            BlocBuilder<RewardsBloc, RewardsState>(
                              builder: (context, state) {
                                if (state.status == Status.loading) {
                                  return ListView.separated(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      return Container(
                                        height: 60,
                                        padding: EdgeInsets.symmetric(
                                          horizontal: mediumPadding,
                                          vertical:
                                              mediumPadding + smallPadding,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.grey.shade100,
                                          shape: BoxShape.rectangle,
                                          borderRadius: BorderRadius.circular(
                                            16,
                                          ),
                                          gradient: LinearGradient(
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                            colors: [
                                              Colors.grey.shade100.withAlpha(
                                                200,
                                              ),
                                              Colors.grey.shade100.withAlpha(
                                                100,
                                              ),
                                              Colors.grey.shade100.withAlpha(
                                                88,
                                              ),
                                              Colors.grey.shade100.withAlpha(
                                                88,
                                              ),
                                              Colors.grey.shade100,
                                              Colors.grey.shade100.withAlpha(
                                                70,
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                    separatorBuilder: (context, index) =>
                                        const SizedBox(height: mediumPadding),
                                    itemCount: 5,
                                  );
                                }
                                return ListView.separated(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(height: mediumPadding),
                                  itemCount: state.rewards.length,
                                  itemBuilder: (context, index) {
                                    return RewardTile(
                                      reward: state.rewards[index],
                                    );
                                  },
                                );
                              },
                            ),
                            const SizedBox(height: largePadding),
                            Text(
                              context.appLoc.description,
                              style: Theme.of(context).textTheme.titleMedium!
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: smallPadding),
                            Text(
                              context.appLoc.rewards_description,
                              style: Theme.of(context).textTheme.bodySmall,
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
      title: Text(
        context.appLoc.rewards,
        style: TextStyle(fontFamily: "Pretendard", color: Colors.black),
      ),
      leading: IconButton(
        onPressed: () {
          context.pop();
        },
        icon: const Icon(Icons.chevron_left_outlined, color: Colors.black),
      ),
      backgroundColor: Colors.white,
    );
  }
}
