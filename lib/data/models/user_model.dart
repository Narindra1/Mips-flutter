import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';

import '../../common/services/environment_wrapper.dart';
import '../../domain/domain.dart';

/// Modèle représentant un utilisateur.
///
/// Champs :
/// - [id] : identifiant unique de l'utilisateur.
/// - [name] : nom de l'utilisateur( Pas utilisé par l'appli).
/// - [pseudo] : pseudonyme ou surnom.
/// - [genre] : genre de l'utilisateur.
/// - [photo] : chemin ou URL vers la photo de profil.
/// - [avatarUrl] : URL de l'avatar.
/// - [_phoneNumber] : numéro de téléphone (privé).
/// - [dateDeNaissance] : année de naissance.
/// - [lieuResidence] : lieu de résidence.
/// - [tokenORPassword] : token d'authentification ou mot de passe.
/// - [soldeFAKA] : solde FAKA (monnaie ou crédit interne).
/// - [mail] : adresse e-mail.
///
class UserModel extends Equatable {
  final int id;
  final String name;
  final String pseudo;
  final String genre;
  final String photo;
  final String avatarUrl;
  final String _phoneNumber;
  final String dateDeNaissance;
  final String? dateDAdhesion;
  final String lieuResidence;
  final String tokenORPassword;
  final int soldeFAKA;
  final String mail;

  const UserModel(
      {required this.id,
      required this.name,
      required this.photo,
      required String phoneNumber,
      this.dateDAdhesion,
      required this.pseudo,
      required this.soldeFAKA,
      required this.mail,
      required this.dateDeNaissance,
      required this.genre,
      required this.avatarUrl,
      required this.lieuResidence,
      required this.tokenORPassword})
      : _phoneNumber = phoneNumber;

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json["id"],
      name: json["nom"] ?? "",
      pseudo: json["pseudo"] ?? "",
      mail: json["email"] ?? "",
      phoneNumber: (json["phone"] ?? "").toString(),
      genre: json["genre"] ?? "M",
      dateDeNaissance: (json["annee_naissance"] ?? "").toString(),
      dateDAdhesion: (json["created_at"] ?? "").toString(),
      lieuResidence: (json["lieu_residence"] ?? "").toString(),
      photo: json["image"] ?? "",

      /// URL de base + /images/avatar/....
      avatarUrl: GetIt.instance<EnvironmentWrapper>().baseUrl +
          (json["avatarUrl"] ?? ""),
      tokenORPassword: json["password"] ?? "",
      soldeFAKA: json["faka"] == null ? 0 : (json["faka"])["montant"],
      // soldeFAKA: (json["faka"])["montant"],
    );
  }

  factory UserModel.fromJsonAuth(Map<String, dynamic> json) {
    return UserModel(
      id: (json["user"])["id"],
      name: ((json["user"])["nom"]) ?? "",
      phoneNumber: "",
      lieuResidence: "",
      dateDeNaissance: "",
      dateDAdhesion: "",
      genre: "M",
      photo: json["image"] ?? "",

      /// URL de base + /images/avatar/....
      avatarUrl: GetIt.instance<EnvironmentWrapper>().baseUrl +
          (json["avatarUrl"] ?? ""),
      pseudo: ((json["user"])["pseudo"]) ?? "",
      tokenORPassword: json["token"],
      mail: json["mail"] ?? "",
      soldeFAKA: 0,
    );
  }

  factory UserModel.fromEntity(User user) {
    return UserModel(
      id: user.id,
      name: user.name,
      phoneNumber: user.phoneNumber,
      photo: user.photo,
      pseudo: user.pseudo,
      mail: user.mail,
      tokenORPassword: user.tokenORPassword,
      soldeFAKA: user.soldeFAKA,
      avatarUrl: user.avatarUrl,
      dateDeNaissance: user.dateDeNaissance,
      dateDAdhesion: user.dateDAdhesion,
      genre: user.isMasculin ? "M" : "F",
      lieuResidence: user.lieuResidence,
    );
  }

  /// getter qui enlève tous les espaces dans le numéro de téléphone
  String get phoneNumber => _phoneNumber.replaceAll(" ", '');

  User toEntity() {
    return User(
      id: id,
      name: name,
      pseudo: pseudo,
      avatarUrl: avatarUrl,
      phoneNumber: phoneNumber,
      tokenORPassword: tokenORPassword,
      photo: photo,
      mail: mail,
      dateDeNaissance: dateDeNaissance,
      dateDAdhesion: dateDAdhesion,
      isMasculin: genre == "M",
      lieuResidence: lieuResidence,
      soldeFAKA: soldeFAKA,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nom': name,
      'prenom': "",
      'pseudo': pseudo,
      'genre': genre,
      'phone': phoneNumber.replaceAll(" ", ''),
      'annee_naissance': dateDeNaissance,
      'lieu_residence': lieuResidence,
      'email': mail,
      'password': tokenORPassword,
    };
  }

  @override
  List<Object> get props => [
        id,
        name,
        photo,
        avatarUrl,
        phoneNumber,
        pseudo,
        soldeFAKA,
        tokenORPassword,
        mail
      ];

  UserModel copyWith({
    int? id,
    String? name,
    String? pseudo,
    String? genre,
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
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      pseudo: pseudo ?? this.pseudo,
      genre: genre ?? this.genre,
      photo: photo ?? this.photo,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      dateDeNaissance: anneeNaissance ?? this.dateDeNaissance,
      dateDAdhesion: dateDAdhesion ?? this.dateDAdhesion,
      lieuResidence: lieuResidence ?? this.lieuResidence,
      tokenORPassword: tokenORPassword ?? this.tokenORPassword,
      soldeFAKA: soldeFAKA ?? this.soldeFAKA,
      mail: mail ?? this.mail,
    );
  }
}
