import 'package:MIPS/common/common.dart';
import 'package:MIPS/data/data.dart';
import 'package:MIPS/domain/domain.dart';

/// Model pour les differente Option de tarif des annonces
class AnnonceTarifOptionModel {
  final bool isAvailable;
  final String dateAvailability;
  final String clientName;
  final AnnonceModel? annonceModel;
  final AnnonceType annonceType;
  final String tarifTitle;
  final List<TarifModel> tarifsModel;

  const AnnonceTarifOptionModel({
    required this.tarifTitle,
    required this.annonceType,
    this.annonceModel,
    required this.clientName,
    required this.tarifsModel,
    required this.dateAvailability,
    required this.isAvailable,
  });

  factory AnnonceTarifOptionModel.fromJson(
      Map<String, dynamic> map, AnnonceType annonceType) {
    List<TarifModel> tarifList = [];
    if (map["options"] != null &&
        map["options"] is List &&
        (map["options"] as List).isNotEmpty) {
      List<dynamic> resultList = (map["options"] as List<dynamic>);
      for (var e in resultList) {
        tarifList.add(TarifModel.fromJson(e));
      }
    }
    return AnnonceTarifOptionModel(
      annonceModel:
          map["annonce"] != null ? AnnonceModel.fromJson(map["annonce"]) : null,
      isAvailable: (map['est_libre'] as bool),
      dateAvailability: map['date_libre'] ?? "2025-05-23",
      clientName: (map['client'] != null)
          ? (map['client']["pseudo"] ?? "User")
          : "User",
      annonceType: annonceType,
      tarifTitle: annonceType.name.toString().toUpperCase(),
      tarifsModel: tarifList,
    );
  }

  AnnonceTarifOption toEntity() {
    return AnnonceTarifOption(
        clientName: clientName,
        tarifTitle: tarifTitle,
        annonceType: annonceType,
        annonce: annonceModel?.toEntity(),
        tarifs: tarifsModel.map((e) => e.toEntity()).toList(),
        dateAvailability: dateAvailability,
        isAvailable: isAvailable);
  }
}

/// Model pour les tarif
class TarifModel {
  final String periode;
  final int priceInFaka;
  final int id;

  const TarifModel({
    required this.id,
    required this.periode,
    required this.priceInFaka,
  });

  factory TarifModel.fromJson(Map<String, dynamic> map) {
    return TarifModel(
      id: map['id'] as int,
      periode: map['duree'] as String,
      priceInFaka: map['faka'] as int,
    );
  }

  Tarif toEntity() {
    return Tarif(periode: periode, priceInFaka: priceInFaka, id: id);
  }
}
