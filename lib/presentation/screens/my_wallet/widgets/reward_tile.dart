import 'package:MIPS/common/constants/constant.dart';
import 'package:MIPS/domain/entities/reward.dart';
import 'package:MIPS/presentation/configurations/colors_list.dart';
import 'package:MIPS/presentation/routes/route.dart';
import 'package:MIPS/presentation/routes/router.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class RewardTile extends StatelessWidget {
  const RewardTile({
    super.key,
    required this.reward,
  });
  final Reward reward;

  @override
  Widget build(BuildContext context) {
    Map<RewardType, String> requests = {
      RewardType.connexion: "Connexion quotidienne",
      RewardType.pub: "Regarder differentes publicités",
      RewardType.popUp: "Regarder des PopUps",
      RewardType.sondage: "Réponder des sondages",
    };
    if (reward.rewardType != RewardType.none) {
      return MaterialButton(
        onPressed: reward.counted == reward.counts
            ? null
            : () {
                if (reward.rewardType == RewardType.pub) {
                  AppRouter.go(context, RoutesNames.mahaPartenaireList);
                }
                if (reward.rewardType == RewardType.sondage) {
                  AppRouter.go(context, RoutesNames.sondageList,
                      queryParameters: {"title": "Sondage"});
                }
              },
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: mediumPadding,
            vertical: mediumPadding + smallPadding,
          ),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: reward.counted == reward.counts
                  ? [
                      secondaryColor.withAlpha(200),
                      secondaryColor.withAlpha(100),
                      secondaryColor.withAlpha(88),
                      secondaryColor.withAlpha(88),
                      secondaryColor,
                      secondaryColor.withAlpha(70),
                    ]
                  : [
                      Colors.grey.shade200.withAlpha(200),
                      Colors.grey.shade200.withAlpha(100),
                      Colors.grey.shade200.withAlpha(88),
                      Colors.grey.shade200.withAlpha(88),
                      Colors.grey.shade200,
                      Colors.grey.shade200.withAlpha(70),
                    ],
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Row(
                  spacing: 10.0,
                  children: [
                    Container(
                      height: 42,
                      width: 42,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: tertiaryColor.withAlpha(200),
                        ),
                        color: Colors.white54,
                      ),
                      child: const Icon(
                        Ionicons.image,
                        color: tertiaryColor,
                      ),
                    ),
                    Flexible(
                      child: Text(
                        "${requests[reward.rewardType]} ${reward.rewardType == RewardType.connexion ? "" : "(${reward.counted}/${reward.counts})"}",
                        maxLines: 2,
                        style: Theme.of(context).textTheme.bodyMedium,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 40,
                width: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(16),
                  border: reward.counted == reward.counts
                      ? null
                      : Border.all(
                          color: tertiaryColor.withAlpha(200),
                        ),
                  color:
                      reward.counted == reward.counts ? null : Colors.white54,
                ),
                child: reward.counted == reward.counts
                    ? const Icon(
                        Ionicons.checkbox,
                        color: tertiaryColor,
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image(
                            height: 24,
                            width: 24,
                            image: AssetImage("assets/imgs/mips_coin.png"),
                          ),
                          Text(
                            "+${reward.amount}",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  color: tertiaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ],
                      ),
              )
            ],
          ),
        ),
      );
    }
    return SizedBox();
  }
}
