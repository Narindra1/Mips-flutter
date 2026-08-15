import 'package:mips/common/constants/constant.dart';
import 'package:mips/domain/entities/reward.dart';
import 'package:mips/presentation/configurations/colors_list.dart';
import 'package:mips/presentation/configurations/extension_for_localization.dart';
import 'package:mips/presentation/routes/route.dart';
import 'package:mips/presentation/routes/router.dart';
import 'package:flutter/material.dart';

class RewardTile extends StatelessWidget {
  const RewardTile({super.key, required this.reward});
  final Reward reward;

  @override
  Widget build(BuildContext context) {
    Map<RewardType, String> requests = {
      RewardType.connexion: context.appLoc.daily_connection,
      RewardType.pub: context.appLoc.claim_bonuses_partner_sponsor_pubs,
      RewardType.popUp: context.appLoc.claim_kara_bonuses_popup_ads,
      RewardType.sondage: context.appLoc.take_surveys,
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
                  AppRouter.go(
                    context,
                    RoutesNames.sondageList,
                    queryParameters: {"title": context.appLoc.survey},
                  );
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
                        border: Border.all(color: tertiaryColor.withAlpha(200)),
                        color: Colors.white54,
                      ),
                      child: const Icon(Icons.image, color: tertiaryColor),
                    ),
                    Flexible(
                      child: Text(
                        "${requests[reward.rewardType]} ${reward.rewardType == RewardType.connexion ? "" : "(${reward.counted}/${reward.counts})"}",
                        maxLines: 4,
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
                      : Border.all(color: tertiaryColor.withAlpha(200)),
                  color: reward.counted == reward.counts
                      ? null
                      : Colors.white54,
                ),
                child: reward.counted == reward.counts
                    ? const Icon(Icons.check, color: tertiaryColor)
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
                            style: Theme.of(context).textTheme.bodyMedium!
                                .copyWith(
                                  color: tertiaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ],
                      ),
              ),
            ],
          ),
        ),
      );
    }
    return SizedBox();
  }
}
