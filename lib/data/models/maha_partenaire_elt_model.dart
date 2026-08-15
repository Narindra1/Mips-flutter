import 'package:mips/domain/domain.dart';
import 'package:mips/domain/entities/maha_partenaire_elt.dart';

import '../../common/constants/constant.dart';
import 'annonce_tarif_option_model.dart';

/// Model pour les element de MahaPartenaire (menu: support=> MahaPartenaire)
class MahaPartenaireEltModel {
  final int idMenu;
  final String titleMenu;
  final AnnonceTarifOptionModel annonceSponsorTarifsOptionModel;
  final AnnonceTarifOptionModel annoncePartenaireTarifsOptionModel;

  const MahaPartenaireEltModel({
    required this.idMenu,
    required this.titleMenu,
    required this.annonceSponsorTarifsOptionModel,
    required this.annoncePartenaireTarifsOptionModel,
  });

  factory MahaPartenaireEltModel.fromJson(Map<String, dynamic> map) {
    return MahaPartenaireEltModel(
      idMenu: map['idMenu'] as int,
      titleMenu: map['nomMenu'] as String,
      annoncePartenaireTarifsOptionModel: AnnonceTarifOptionModel.fromJson(
        map["offre"]["PARTENAIRE"],
        AnnonceType.partenaire,
      ),
      annonceSponsorTarifsOptionModel: AnnonceTarifOptionModel.fromJson(
        map["offre"]["SPONSOR"],
        AnnonceType.sponsor,
      ),
    );
  }

  MahaPartenaireElt toEntity() {
    return MahaPartenaireElt(
      idMenu: idMenu,
      titleMenu: titleMenu,
      annoncePartenaireTarifOption: annoncePartenaireTarifsOptionModel
          .toEntity(),
      annonceSponsorTarifOption: annonceSponsorTarifsOptionModel.toEntity(),
    );
  }
}
