import 'package:equatable/equatable.dart';

class Province extends Equatable {
  const Province({
    required this.id,
    required this.reference,
    required this.nbrPartenaire,
    required this.nom,
    required this.description,
    required this.hasLike,
  });
  final int id;
  final String reference;
  final int nbrPartenaire;
  final String nom;
  final String description;
  final bool hasLike;

  @override
  List<Object> get props => [
        id,
        reference,
        nbrPartenaire,
        nom,
        description,
        hasLike,
      ];
}
