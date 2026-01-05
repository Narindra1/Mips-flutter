import 'package:equatable/equatable.dart';

import '../../common/utils/app_utils.dart';

/// Modèle représentant un utilisateur de l'application.
///
/// Contient :
/// - l’identifiant de l’utilisateur ([id])
/// - le nom ([name])
/// - le pseudo de l’utilisateur ([pseudo])
/// - genre masculin ou non ([isMasculin])
/// - URL de la photo de profil ([photo])
/// - URL de l’avatar ([avatarUrl])
/// - numéro de téléphone ([phoneNumber])
/// - date de naissance ([dateDeNaissance])
/// - lieu de résidence ([lieuResidence])
/// - token ou mot de passe (selon contexte) ([tokenORPassword])
/// - solde de l'utilisateur en FAKA ([soldeFAKA])
/// - adresse email ([mail])
class User extends Equatable {
  final int id;
  final String name;
  final String pseudo;
  final bool isMasculin;
  final String photo;
  final String avatarUrl;
  final String phoneNumber;
  final String dateDeNaissance;
  final String? dateDAdhesion;
  final String lieuResidence;
  final String tokenORPassword;
  final int soldeFAKA;
  final String mail;

  @override
  List<Object?> get props => [
        id,
        name,
        photo,
        avatarUrl,
        phoneNumber,
        pseudo,
        soldeFAKA,
        tokenORPassword,
        dateDAdhesion,
        mail
      ];

  const User({
    required this.id,
    required this.name,
    required this.pseudo,
    required this.isMasculin,
    required this.photo,
    required this.avatarUrl,
    required this.phoneNumber,
    required this.dateDeNaissance,
    this.dateDAdhesion,
    required this.lieuResidence,
    required this.tokenORPassword,
    required this.soldeFAKA,
    required this.mail,
  });

  User copyWith({
    int? id,
    String? name,
    String? pseudo,
    bool? isMasculin,
    String? photo,
    String? avatarUrl,
    String? phoneNumber,
    String? anneeNaissance,
    String? dateDAdhesion,
    String? lieuResidence,
    String? tokenORPassword,
    int? soldeFAKA,
    String? mail,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      pseudo: pseudo ?? this.pseudo,
      isMasculin: isMasculin ?? this.isMasculin,
      photo: photo ?? this.photo,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      dateDAdhesion: dateDAdhesion ?? this.dateDAdhesion,
      dateDeNaissance: anneeNaissance ?? dateDeNaissance,
      lieuResidence: lieuResidence ?? this.lieuResidence,
      tokenORPassword: tokenORPassword ?? this.tokenORPassword,
      soldeFAKA: soldeFAKA ?? this.soldeFAKA,
      mail: mail ?? this.mail,
    );
  }

  String get contactFormatted {
    return AppUtils.formatNumber(phoneNumber);
  }
}
