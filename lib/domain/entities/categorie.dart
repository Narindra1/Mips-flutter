/// Classe gérant l’interaction de navigation dans le menu utilisateur.
///
/// Stocke le menu sélectionné pour la route DemandeDePub.
class Categorie {
  final int id;
  final String name;
  final String reference;
  final bool isFree;

  const Categorie(
      {required this.id,
      required this.name,
      required this.isFree,
      required this.reference});

  Categorie copyWith({
    int? id,
    String? name,
    String? reference,
    bool? isFree,
  }) {
    return Categorie(
      id: id ?? this.id,
      name: name ?? this.name,
      isFree: isFree ?? this.isFree,
      reference: reference ?? this.reference,
    );
  }
}
