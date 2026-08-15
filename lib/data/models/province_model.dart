import 'package:mips/domain/entities/province.dart';
import 'package:equatable/equatable.dart';

class ProvinceModel extends Equatable {
  const ProvinceModel({
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

  factory ProvinceModel.fromJson(Map<String, dynamic> json) {
    return ProvinceModel(
      id: json["id"] ?? 0,
      reference: json["reference"] ?? "",
      nbrPartenaire: json["nbrPartenaire"] ?? 0,
      nom: json["nom"] ?? "",
      description: json["description"] ?? "",
      hasLike: json["hasLike"] ?? false,
    );
  }

  Province toEntity() {
    return Province(
      id: id,
      reference: reference,
      nbrPartenaire: nbrPartenaire,
      nom: nom,
      description: description,
      hasLike: hasLike,
    );
  }

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
