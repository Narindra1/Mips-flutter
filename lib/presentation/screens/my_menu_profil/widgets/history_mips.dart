import 'package:mips/common/constants/constant.dart';
import 'package:mips/common/utils/app_utils.dart';
import 'package:mips/presentation/bloc/app_bloc.dart';
import 'package:mips/presentation/configurations/extension_for_localization.dart';
import 'package:flutter/material.dart';

class HistoryMips extends StatelessWidget {
  const HistoryMips({super.key, required this.appState, required this.index});
  final AppState appState;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 1),
      decoration: BoxDecoration(
        // color: Colors.amber,
        borderRadius: BorderRadius.circular(mediumPadding),
        border: Border.all(color: Colors.grey.shade200, width: 2),
      ),
      child: ListTile(
        titleTextStyle: Theme.of(context).textTheme.titleSmall,
        subtitleTextStyle: Theme.of(
          context,
        ).textTheme.bodySmall?.copyWith(color: Colors.grey.shade600),
        isThreeLine: true,
        title: Row(
          children: [
            Expanded(
              child: Text(
                matchTransactionType(
                  context,
                  appState.transactionHistory[index].type,
                ),
                style: Theme.of(context).textTheme.titleSmall,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(smallPadding),
              decoration: BoxDecoration(
                color: !appState.transactionHistory[index].isIncome
                    ? Colors.red.shade400
                    : Colors.green,
                borderRadius: BorderRadius.circular(mediumPadding),
              ),
              child: Row(
                children: [
                  Image.asset(
                    width: 24,
                    height: 24,
                    mipsCoin,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(width: smallPadding),
                  Text(
                    "${appState.transactionHistory[index].isIncome ? "+" : "-"}${appState.transactionHistory[index].montantFaka}",
                    style: const TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            matchTransactionMessageByType(
              context,
              appState.transactionHistory[index].type,
              appState.transactionHistory[index].slug,
              message: appState.transactionHistory[index].message,
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    AppUtils.formatDateReadableWithMonth(
                      context,
                      appState.transactionHistory[index].date,
                    ),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String matchTransactionType(BuildContext context, String type) {
    String transaction = "";
    switch (type) {
      case "CONNEXION_QUOTIDIENNE":
        transaction = context.appLoc.daily_connection;
        break;
      case "CONSULTER_ANNONCE":
        transaction = context.appLoc.ad_consultation;
        break;
      case "DONATION_GRANT":
        transaction = context.appLoc.first_connection;
        break;
      case "ADMIN_GRANT":
        transaction = context.appLoc.mips_bonus;
        break;
      case "PARTICIPER_SONDAGE":
        transaction = context.appLoc.survey_participation;
        break;
      case "PROLONGER_OFFRE":
        transaction = context.appLoc.announcement_extension;
        break;
      case "ACHAT_OFFRE_KARA":
        transaction = context.appLoc.using_kara;
        break;
      case "USER_TRANSFER":
        transaction = context.appLoc.kara_transfer;
        break;
      case "BONUS_ANNONCE":
        transaction = context.appLoc.bonus_announce;
        break;
      default:
        transaction = "";
        break;
    }
    return transaction;
  }

  Widget matchTransactionMessageByType(
    BuildContext context,
    String type,
    String slug, {
    String message = "",
  }) {
    String messageToSend = "";
    switch (type) {
      case "CONNEXION_QUOTIDIENNE":
        messageToSend = "";
        break;
      case "CONSULTER_ANNONCE":
        messageToSend = context.appLoc.bonus_from_announce(slug);
        break;
      case "DONATION_GRANT":
        messageToSend = "";
        break;
      case "ADMIN_GRANT":
        messageToSend = "";
        break;
      case "PARTICIPER_SONDAGE":
        messageToSend = "";
        break;
      case "PROLONGER_OFFRE":
        messageToSend = "";
        break;
      case "ACHAT_OFFRE_KARA":
        messageToSend = "";
        break;
      case "USER_TRANSFER":
        messageToSend = message == "Ami(e)"
            ? context.appLoc.friend
            : message == "Partenaire KARA"
            ? context.appLoc.kara_partner
            : message;
        break;
      case "BONUS_ANNONCE":
        messageToSend = context.appLoc.bonus_from_announce(slug);
        break;
      default:
        messageToSend = "";
        break;
    }
    return messageToSend == ""
        ? SizedBox()
        : Text(messageToSend, maxLines: 3, overflow: TextOverflow.ellipsis);
  }
}
