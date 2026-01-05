import 'package:MIPS/common/constants/constant.dart';
import 'package:MIPS/common/services/environment_wrapper.dart';
import 'package:MIPS/data/data.dart';
import 'package:MIPS/domain/entities/profil.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';

class ProfilModel extends Equatable {
  const ProfilModel({
    required this.user,
    required this.followers,
    required this.followings,
    required this.annonces,
  });
  final UserModel user;
  final List<UserModel> followings;
  final List<UserModel> followers;
  final List<AnnonceModel> annonces;

  factory ProfilModel.fromJson(Map<String, dynamic> map) {
    UserModel user = UserModel(
      id: map["id"] ?? 0,
      name: map["nom"] ?? "",
      photo: "",
      phoneNumber: map["phone"] ?? "",
      pseudo: map["pseudo"] ?? "",
      soldeFAKA: 0,
      mail: "",
      dateDeNaissance: "",
      dateDAdhesion: map["created_at"] ?? "",
      genre: "",
      avatarUrl:
          (GetIt.instance<EnvironmentWrapper>().baseUrl + map["avatarUrl"]),
      lieuResidence: "",
      tokenORPassword: "",
    );
    List<UserModel> followers = [];
    if (map["followers"] != null && (map["followers"] as List).isNotEmpty) {
      for (var follower in map["followers"]) {
        followers.add(UserModel(
          id: follower["id"] ?? 0,
          name: follower["nom"] ?? "",
          photo: "",
          phoneNumber: follower["phone"] ?? "",
          pseudo: follower["pseudo"] ?? "",
          soldeFAKA: 0,
          mail: "",
          dateDeNaissance: "",
          genre: "",
          avatarUrl: GetIt.instance<EnvironmentWrapper>().baseUrl +
              follower["avatarUrl"],
          lieuResidence: "",
          tokenORPassword: "",
        ));
      }
    }
    List<UserModel> followings = [];
    if (map["following"] != null && (map["following"] as List).isNotEmpty) {
      for (var following in map["following"]) {
        followings.add(UserModel(
          id: following["id"] ?? 0,
          name: following["nom"] ?? "",
          photo: "",
          phoneNumber: following["phone"] ?? "",
          pseudo: following["pseudo"] ?? "",
          soldeFAKA: 0,
          mail: "",
          dateDeNaissance: "",
          genre: "",
          avatarUrl: GetIt.instance<EnvironmentWrapper>().baseUrl +
              following["avatarUrl"],
          lieuResidence: "",
          tokenORPassword: "",
        ));
      }
    }
    List<AnnonceModel> annonces = [];
    if (map["annonces"] != null && (map["annonces"] as List).isNotEmpty) {
      for (var annonce in map["annonces"]) {
        List<ImageModel> photoJson = [];
        if (annonce["images"] != null &&
            (annonce["images"] as List<dynamic>).isNotEmpty) {
          for (var image in (annonce["images"] as List<dynamic>)) {
            if (image['url'] != null &&
                image['url'] != "photo1.png" &&
                image['url'] != "photo2.png" &&
                image['url'] != "photo3.png") {
              photoJson.add(ImageModel.fromJson(image));
            }
          }
        }
        annonces.add(
          AnnonceModel(
            id: annonce["id"] ?? 0,
            slug: annonce["slug"] ?? "",
            title: annonce["titre"] ?? "",
            descriptionCourte: annonce["description_courte"] ?? "",
            descriptionDetaille: annonce["description_detaille"] ?? "",
            menuParentRef: "",
            menuRacineRef: "",
            menuRacineName: "",
            photos: photoJson,
            isWebsitePub: false,
            commentaires: [],
            emplacement: annonce["lieu"] ?? "",
            contact: annonce["contact"] ?? "",
            dateDeCreation: annonce["created_at"] ?? "",
            dateLimit: annonce["limited_date"] ?? "",
            annonceType: AnnonceType.general,
            author: map["nom"] ?? "",
            authorID: map["id"] ?? 0,
            menuParentID: 0,
            menuParentName: "",
            isLiked: false,
            reactionCount: 0,
            customHtmlUrl: "",
            parrain: "",
            isFavs: false,
          ),
        );
      }
    }

    print("FOLLOWERS : ${followers.length}");
    print("FOLLOWINGS : ${followings.length}");
    print("ANNONCES : ${annonces.length}");

    return ProfilModel(
      user: user,
      followers: followers,
      followings: followings,
      annonces: annonces,
    );
  }

  Profil toEntity() {
    return Profil(
      user: user.toEntity(),
      followers: followers.map((e) => e.toEntity()).toList(),
      followings: followings.map((e) => e.toEntity()).toList(),
      annonces: annonces.map((e) => e.toEntity()).toList(),
    );
  }

  @override
  List<Object> get props => [user, followings, followers, annonces];
}
