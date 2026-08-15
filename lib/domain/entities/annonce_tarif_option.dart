import 'package:mips/common/common.dart';
import 'package:mips/domain/domain.dart';
import 'package:mips/presentation/configurations/extension_for_localization.dart';
import 'package:flutter/material.dart';

/// Entité représentant une option tarifaire pour une annonce.
///
/// Contient :
/// - la disponibilité de l’option ([isAvailable])
/// - la date de disponibilité ([dateAvailability])
/// - le type d’annonce concerné ([annonceType])
/// - le nom du client si l'option est prise par un client ([clientName] )
/// - l’annonce associée, si disponible ([annonce])
/// - le titre du tarif ([tarifTitle])
/// - la liste des tarifs disponibles ([tarifs])
class AnnonceTarifOption {
  final bool isAvailable;
  final String dateAvailability;
  final AnnonceType annonceType;
  final String clientName;
  final Annonce? annonce;
  final String tarifTitle;
  final List<Tarif> tarifs;

  const AnnonceTarifOption({
    required this.tarifTitle,
    required this.annonceType,
    required this.tarifs,
    required this.clientName,
    this.annonce,
    required this.dateAvailability,
    required this.isAvailable,
  });

  String getReadableAvailability(BuildContext context) {
    return AppUtils.dateAvailablity(context, annonceType, dateAvailability);
  }

  String getReadableAvailabilityMin() {
    return AppUtils.formatDateMin(dateAvailability);
  }
}

class Tarif {
  final int id;
  final String periode;
  final int priceInFaka;

  const Tarif({
    required this.id,
    required this.periode,
    required this.priceInFaka,
  });

  @override
  String toString() {
    return "$id, $periode,$priceInFaka";
  }

  String getPriceInFakaMin() {
    if (priceInFaka >= 1000000) {
      return '${(priceInFaka / 1000000).toStringAsFixed(1).replaceAll(RegExp(r"\.0$"), "")}M';
    } else if (priceInFaka >= 1000) {
      return '${(priceInFaka / 1000).toStringAsFixed(1).replaceAll(RegExp(r"\.0$"), "")}K';
    } else {
      return priceInFaka.toString();
    }
  }

  String getReadablePeriode() {
    String ret = periode;
    final RegExp regex = RegExp(r'^(\d+)(week|month|year)$');
    final match = regex.firstMatch(ret);

    if (match == null) {
      return ret;
    }

    // Extract number and unit
    final int count = int.parse(match.group(1)!);
    final String unit = match.group(2)!;

    // Use AppLocalizations based on unit
    try {
      if (unit == 'week') {
        return GlobalContextService.snackbarKey.currentContext!.appLoc
            .duration_week(count);
      } else if (unit == 'month') {
        return GlobalContextService.snackbarKey.currentContext!.appLoc
            .duration_month(count);
      } else if (unit == 'year') {
        return GlobalContextService.snackbarKey.currentContext!.appLoc
            .duration_year(count);
      }
    } on Exception catch (e) {
      AppUtils.showDebugLog(runtimeType, "error tarif format:${e.toString()}");
    }
    return ret;
  }

  String priceInFakaFormatted() {
    return AppUtils.formatNumberWithSpaces(priceInFaka);
  }
}
