import 'annonce_tarif_option.dart';

/// Entité représentant un élément du menu MahaPartenaire .
///
/// Contient :
/// - l’identifiant du menu associé ([idMenu])
/// - le titre du menu ([titleMenu])
/// - l’option tarifaire de l’annonce sponsor ([annonceSponsorTarifOption])
/// - l’option tarifaire de l’annonce partenaire ([annoncePartenaireTarifOption])
class MahaPartenaireElt {
  final int idMenu;
  final String titleMenu;
  final AnnonceTarifOption annonceSponsorTarifOption;
  final AnnonceTarifOption annoncePartenaireTarifOption;

  const MahaPartenaireElt({
    required this.idMenu,
    required this.titleMenu,
    required this.annonceSponsorTarifOption,
    required this.annoncePartenaireTarifOption,
  });
}
