import 'dart:async';
import 'dart:convert';

import 'package:mips/common/common.dart';
import 'package:mips/common/services/environment_wrapper.dart';
import 'package:mips/data/data.dart';
import 'package:mips/data/models/devise_model.dart';
import 'package:mips/data/models/exchange_rate_model.dart';
import 'package:mips/data/models/more_info_model.dart';
import 'package:mips/data/models/province_model.dart';
import 'package:mips/data/models/reward_model.dart';
import 'package:mips/data/models/user_menu_profil_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';

import '../models/annonce_tarif_option_model.dart';

/// Gère toutes les requêtes API vers le serveur distant.
class RemoteDataSource {
  final Dio dio;

  const RemoteDataSource({required this.dio});

  /// Récupère la liste des annonces.
  /// [idMenu] : l'identifiant du menu ;
  /// [page] : l'index de la page (commence à 1) ;
  /// [query] : la chaîne de requête de recherche (peut être vide : "") ;
  /// return une liste de [AnnonceModel].
  Future<List<AnnonceModel>> fetchAnnoncesByMenu(
    int idMenu,
    int page,
    String query,
  ) async {
    return requestHandler(() async {
      String url = '';
      // Chargement des annonces avec pagination
      if (page > 1 || query != "") {
        if (query != "") {
          url = '/annonces/menus/$idMenu/paginate?page=$page&query=$query';
        } else {
          url = '/annonces/menus/$idMenu/paginate?page=$page';
        }
      } else {
        url = '/annonces/menus/$idMenu';
      }

      Response response = await dio.get(url);
      Map<String, dynamic> jsonResult = _json(response.data);
      List<AnnonceModel> annonceModelList = [];

      /// Désérialisation des données retournées par la pagination : /annonces/menus/$idMenu/paginate?page=$page...
      if (jsonResult["data"] != null) {
        List<dynamic> resultList = (jsonResult["data"] as List<dynamic>);
        for (var e in resultList) {
          annonceModelList.add(
            AnnonceModel.fromJson(e, annonceType: AnnonceType.general),
          );
        }
      }
      /// Désérialisation des données retournées par l'URL par défaut : /annonces/menus/$idMenu
      else {
        if (jsonResult["PREMIUM"] != null &&
            (jsonResult["PREMIUM"] as List).isNotEmpty) {
          List<dynamic> resultList = (jsonResult["PREMIUM"] as List<dynamic>);
          for (var e in resultList) {
            annonceModelList.add(
              AnnonceModel.fromJson(e, annonceType: AnnonceType.premium),
            );
          }
        }
        if (jsonResult["SPONSOR"] != null && jsonResult["SPONSOR"] != "") {
          annonceModelList.add(
            AnnonceModel.fromJson(
              jsonResult["SPONSOR"],
              annonceType: AnnonceType.sponsor,
            ),
          );
        }
        if (jsonResult["VIP"] != null &&
            (jsonResult["VIP"] as List).isNotEmpty) {
          List<dynamic> resultList = (jsonResult["VIP"] as List<dynamic>);

          for (var e in resultList) {
            annonceModelList.add(
              AnnonceModel.fromJson(e, annonceType: AnnonceType.vip),
            );
          }
        }
        if (jsonResult["PARTENAIRE"] != null &&
            jsonResult["PARTENAIRE"] != "") {
          annonceModelList.add(
            AnnonceModel.fromJson(
              jsonResult["PARTENAIRE"],
              annonceType: AnnonceType.partenaire,
            ),
          );
        }
        if (jsonResult["NORMAL"] != null &&
            (jsonResult["NORMAL"] as List).isNotEmpty) {
          List<dynamic> resultList = (jsonResult["NORMAL"] as List<dynamic>);
          for (var e in resultList) {
            annonceModelList.add(
              AnnonceModel.fromJson(e, annonceType: AnnonceType.general),
            );
          }
        }
      }

      return annonceModelList;
    });
  }

  Future<List<AnnonceModel>> fetchKaraAnnoncesByProvince(
    String province,
    int page,
    String query,
  ) async {
    return requestHandler(() async {
      String url = '';
      // Chargement des annonces avec pagination
      if (page > 1 || query != "") {
        if (query != "") {
          url =
              '/menus/kara_partenaires/$province/paginate?page=$page&query=$query';
        } else {
          url = '/menus/kara_partenaires/$province/paginate?page=$page';
        }
      } else {
        url = '/menus/kara_partenaires/$province';
      }

      Response response = await dio.get(url);
      List<dynamic> jsonResult = _json(response.data);
      List<AnnonceModel> annonceModelList = [];

      if (jsonResult.isNotEmpty) {
        for (var e in jsonResult) {
          annonceModelList.add(
            AnnonceModel.fromJson(
              e["annonce"],
              annonceType: AnnonceType.general,
            ),
          );
        }
      }

      if (kDebugMode) {
        print("PROVINCE : $annonceModelList");
      }

      return annonceModelList;
    });
  }

  /// Récupère la liste des avis.
  /// Retourne une liste de [AvisModel].
  Future<List<AvisModel>> getAllMipsInfo() async {
    return requestHandler(() async {
      Response response = await dio.get("/mips_info");
      Map<String, dynamic> resultList = _json(response.data);

      List<AvisModel> ret = (resultList["resultatSondage"] as List<dynamic>)
          .map((e) => AvisModel.fromJson(e, avisType: AvisType.normal))
          .toList();
      return ret;
    });
  }

  /// Récupère la liste des informations.
  /// Retourne une liste de [MoreInfoModel].
  Future<List<MoreInfoModel>> getAllMoreInfo() async {
    return requestHandler(() async {
      Response response = await dio.get("/mips-infos");
      List<dynamic> resultList = _json(response.data);
      return resultList.map((e) => MoreInfoModel.fromJson(e)).toList();
    });
  }

  /// Récupère la liste des avis.
  /// Retourne une liste de [AvisModel].
  Future<List<AvisModel>> getAllAvis() async {
    return requestHandler(() async {
      Response response = await dio.get("/avis");

      /// L'endpoint /avis retourne 2 listes =>
      /// [avisInfo] : liste des premières politiques d'avis, CGU
      /// ET
      /// [avis] : liste des avis normaux
      Map<String, dynamic> resultList = _json(response.data);

      List<AvisModel> ret = (resultList["avisInfo"] as List<dynamic>)
          .map((e) => AvisModel.fromJson(e, avisType: AvisType.avisInfo))
          .toList();
      // ret.addAll((resultList["avis"] as List<dynamic>)
      //     .map((e) => AvisModel.fromJson(e, avisType: AvisType.normal)));
      return ret;
    });
  }

  /// Récupère un avis spécifique.
  /// [id] : l'identifiant de l'avis.
  /// return  [AvisModel].
  Future<AvisModel> getAAvis(int id) async {
    return requestHandler(() async {
      Response response = await dio.get("/avis/$id");
      Map<String, dynamic> result = _json(response.data);
      return AvisModel.fromJson(result, avisType: AvisType.normal);
    });
  }

  /// Récupère tous les sondages.
  /// Retourne une liste de [SondageModel].
  Future<List<SondageModel>> getAllSondage() async {
    return requestHandler(() async {
      Response response = await dio.get("/annonces/menus/sondage");
      Map<String, dynamic> resultList = _json(response.data);
      List<dynamic> sondageList = resultList["SONDAGE"];
      return sondageList.map((e) => SondageModel.fromJson(e)).toList();
    });
  }

  /// Soumet un sondage.
  /// [sondageID] : id du sondage
  /// [optionID] :  id de l'option choisi
  /// return [SondageModel]
  Future<SondageModel> submitASondage(int sondageID, int optionID) async {
    return requestHandler(() async {
      Response response = await dio.post(
        "/annonces/menus/sondage/$sondageID",
        data: {"option_id": optionID},
      );
      Map<String, dynamic> sondage = _json(response.data);
      return SondageModel.fromJson(sondage);
    });
  }

  /// Récupère tous les annonces partenaire/sponsor dans tout les menus:
  /// (utilisé dans support/MahaPartenaire)
  /// return list [MahaPartenaireEltModel]
  Future<List<MahaPartenaireEltModel>> getAllMahaPartenaire() async {
    return requestHandler(() async {
      Response response = await dio.get("/support/offresStatus");
      List<dynamic> resultList = _json(response.data);

      return resultList.map((e) => MahaPartenaireEltModel.fromJson(e)).toList();
    });
  }

  /// Retourne le nombre total d'une annonce
  Future<int> fetchUserAnnoncesCount() async {
    return requestHandler(() async {
      Response response = await dio.get('/profil/mesAnnonces');
      Map<String, dynamic> jsonResult = _json(response.data);
      // print("HERERERERE : $jsonResult");
      return jsonResult["total"] ?? 0;
    });
  }

  /// Récupère les annonces de l'utilisateur.
  /// return list [AnnonceModel]
  Future<List<AnnonceModel>> fetchAnnoncesUser(int page, String query) async {
    return requestHandler(() async {
      String url = '';
      if (page > 1 || query != "") {
        if (query != "") {
          url = '/profil/mesAnnonces?page=$page&query=$query';
        } else {
          url = '/profil/mesAnnonces?page=$page';
        }
      } else {
        url = '/profil/mesAnnonces';
      }

      Response response = await dio.get(url);
      Map<String, dynamic> jsonResult = _json(response.data);
      if (kDebugMode) {
        print(jsonResult);
      }
      List<AnnonceModel> annonceModelList = [];

      if (jsonResult["data"] != null) {
        List<dynamic> resultList = (jsonResult["data"] as List<dynamic>);
        for (var e in resultList) {
          annonceModelList.add(
            AnnonceModel.fromJson(e, annonceType: AnnonceType.general),
          );
        }
      }

      return annonceModelList;
    });
  }

  /// Retourne le nombre total d'une annonce
  Future<int> fetchAnnoncesFollowedUsersCount() async {
    return requestHandler(() async {
      Response response = await dio.get('/follow/annonces');
      Map<String, dynamic> jsonResult = _json(response.data);
      if (kDebugMode) {
        print("HERERERERE : $jsonResult");
      }
      return jsonResult["total"] ?? 0;
    });
  }

  /// Vérifie si l'utilisateur suit une identité
  /// [id] : ID du membre suivi
  Future<bool> checkIsFollowingUser(int id) async {
    return requestHandler(() async {
      Response response = await dio.get('/follow/check/$id');
      Map<String, dynamic> jsonResult = _json(response.data);
      return jsonResult["isFollowing"] ?? false;
    });
  }

  /// Ne plus suivre un utilisateur
  /// [id] : ID du membre suivi
  Future<void> followAnUser(int id) async {
    return requestHandler(() async {
      await dio.post('/follow/user/$id');
      if (kDebugMode) {
        print("FOLLOWING USER");
      }
      return;
    });
  }

  /// Ne plus suivre un utilisateur
  /// [id] : ID du membre suivi
  Future<void> unfollowAnUser(int id) async {
    return requestHandler(() async {
      await dio.delete('/follow/user/$id');
      if (kDebugMode) {
        print("UNFOLLOWING USER");
      }
      return;
    });
  }

  /// Récupérer mes followers
  /// return list [UserModel]
  Future<List<UserModel>> fetchMyFollowersUsers() async {
    return requestHandler(() async {
      Response response = await dio.get('/follow/my-followers');
      List<dynamic> resultList = _json(response.data);
      return resultList
          .map(
            (e) => UserModel(
              id: e["id"] ?? 0,
              name: e["nom"] ?? "",
              photo: "",
              phoneNumber: e["phone"] ?? "",
              pseudo: e["pseudo"] ?? "",
              soldeFAKA: 0,
              mail: e["email"] ?? "",
              dateDeNaissance: "",
              genre: "",
              avatarUrl:
                  (GetIt.instance<EnvironmentWrapper>().baseUrl +
                  e["avatarUrl"]),
              lieuResidence: "",
              tokenORPassword: "",
            ),
          )
          .toList();
      // List<UserModel> myFollowers = [];
      // if (resultList.isNotEmpty) {
      //   myFollowers = resultList.map((e) => UserModel.fromJson(e)).toList();
      // }
      // return myFollowers;
    });
  }

  /// Récupérer mes following
  /// return list [UserModel]
  Future<List<UserModel>> fetchMyFollowingUsers() async {
    return requestHandler(() async {
      Response response = await dio.get('/follow/my-following');
      List<dynamic> resultList = _json(response.data);
      return resultList
          .map(
            (e) => UserModel(
              id: e["id"] ?? 0,
              name: e["nom"] ?? "",
              photo: "",
              phoneNumber: e["phone"] ?? "",
              pseudo: e["pseudo"] ?? "",
              soldeFAKA: 0,
              mail: e["email"] ?? "",
              dateDeNaissance: "",
              genre: "",
              avatarUrl:
                  (GetIt.instance<EnvironmentWrapper>().baseUrl +
                  e["avatarUrl"]),
              lieuResidence: "",
              tokenORPassword: "",
            ),
          )
          .toList();
      // List<UserModel> myFollowings = [];
      // if (resultList.isNotEmpty) {
      //   myFollowings = resultList.map((e) => UserModel.fromJson(e)).toList();
      // }
      // return myFollowings;
    });
  }

  /// Récupère les annonces des membres suivis.
  /// return list [AnnonceModel]
  Future<List<AnnonceModel>> fetchAnnoncesOfFollowedUsers(
    int page,
    String query,
  ) async {
    return requestHandler(() async {
      String url = '';
      // Chargement des annonces avec pagination
      if (page > 1 || query != "") {
        if (query != "") {
          url = '/follow/annonces?page=$page&query=$query';
        } else {
          url = '/follow/annonces?page=$page';
        }
      } else {
        url = '/follow/annonces';
      }

      Response response = await dio.get(url);
      Map<String, dynamic> jsonResult = _json(response.data);
      if (kDebugMode) {
        print(jsonResult);
      }
      List<AnnonceModel> annonceModelList = [];

      if (jsonResult["data"] != null) {
        List<dynamic> resultList = (jsonResult["data"] as List<dynamic>);
        for (var e in resultList) {
          annonceModelList.add(
            AnnonceModel.fromJson(e, annonceType: AnnonceType.general),
          );
        }
      }

      return annonceModelList;
    });
  }

  /// Change le mot de passe de l'utilisateur.
  /// [oldPassword] : ancien mot de passe
  /// [newPassword] : nouveau mot de passe
  /// return [UserModel]
  Future<UserModel> changePassword(
    String oldPassword,
    String newPassword,
  ) async {
    return requestHandler(() async {
      Response response = await dio.post(
        '/profil/change-password',
        data: {"old_password": oldPassword, "new_password": newPassword},
      );
      Map<String, dynamic> jsonResult = _json(response.data);
      return UserModel.fromJsonAuth(jsonResult);
    });
  }

  /// Réinitialise le mot de passe de l'utilisateur.
  /// [validationCode] : code de validation envoyé par mail
  /// [password] : nouveau mot de passe
  /// return [UserModel]
  Future<UserModel> resetPassword(
    String validationCode,
    String password,
  ) async {
    return requestHandler(() async {
      Response response = await dio.post(
        '/auth/reset-password',
        data: {"code_validation": validationCode, "new_password": password},
      );
      Map<String, dynamic> jsonResult = _json(response.data);
      return UserModel.fromJsonAuth(jsonResult);
    });
  }

  /// Effectue un transfert de KARA.
  /// [phoneReceiver] : numéro téléphone du bénéficiaire
  /// [amount] : montant en FAKA à transferer
  /// return [UserModel]
  Future<UserModel> transfertFaka(
    String phoneReceiver,
    int amount,
    String motif,
  ) async {
    return requestHandler(() async {
      Response response = await dio.post(
        '/profil/faka/transfert',
        data: {
          "numero": phoneReceiver.replaceAll(" ", ""),
          "montant": amount,
          "motif": motif,
        },
      );
      Map<String, dynamic> jsonResult = _json(response.data);
      return UserModel.fromJson(jsonResult);
    });
  }

  /// Vérifie le mot de passe de l'utilisateur.
  /// [password] : mot de passe de l'utilisateur
  /// return rien si mot de passe correct, renvoie une expeption sinon
  Future<void> checkPassword(String password) async {
    return requestHandler<void>(() async {
      await dio.post('/auth/verify-auth', data: {"password": password});
      return;
    });
  }

  /// Demande de réinitialisation de mot de passe (mot de passe oublié).
  /// [email] : email pour recevoir la code de validation
  Future<void> forgotPassword(String email) async {
    return requestHandler(() async {
      await dio.post('/auth/forgot-password', data: {"email": email});
      return;
    });
  }

  /// Récupère un menu
  /// [idScreen] : id du menu
  /// return [MenuModel]
  Future<MenuModel> fetchMenu(String idScreen) async {
    return requestHandler(() async {
      Response response = await dio.get('/menus/$idScreen/content');
      Map<String, dynamic> jsonResult = _json(response.data);
      return MenuModel.fromJson(jsonResult);
    });
  }

  /// Récupère les devises
  /// return [ExchangeRateModel]
  Future<ExchangeRateModel> fetchExchangeRate() async {
    return requestHandler(() async {
      Response response = await dio.get('/devises');
      Map<String, dynamic> result = _json(response.data);
      Map<String, dynamic> devisesMap = result["devises"];
      List<DeviseModel> devises = [];
      devises = devisesMap.entries
          .map((e) => DeviseModel.fromJson(e.key, {e.key: e.value}))
          .toList();
      return ExchangeRateModel(
        devises: devises.toList(),
        date: DateTime.tryParse(result["date"]) ?? DateTime.now(),
        source: result["source"],
      );
    });
  }

  /// Récupère les devises
  /// return [List<RewardModel>]
  Future<List<RewardModel>> fetchRewardList() async {
    return requestHandler(() async {
      Response response = await dio.get('/primes');
      List<dynamic> resultList = _json(response.data);
      List<RewardModel> rewardList = [];
      for (var e in resultList) {
        rewardList.add(RewardModel.fromJson(e));
      }
      return rewardList;
    });
  }

  /// Récupérer le bonus d'une annonce
  Future<void> fetchBonusFromAnnonce(int idAnnonce) async {
    return requestHandler(() async {
      await dio.post('/primes/forAnnonce/$idAnnonce');
      return;
    });
  }

  /// Ajout/enlève un menu dans favoris
  /// [idScreen] : id du menu
  /// [isLike] : true=ajout or false=enlève
  /// return [MenuModel]
  Future<MenuModel> likeMenu(String idScreen, bool isLike) async {
    return requestHandler(() async {
      Response response = await dio.post(
        '/menus/$idScreen/favoris',
        data: {"action": isLike ? "like" : "dislike"},
      );
      Map<String, dynamic> jsonResult = _json(response.data);
      return MenuModel.fromJson(jsonResult);
    });
  }

  /// Récupère les menus parents d'un menu donné.
  /// [idMenu] : id du menu à chercher les parents
  /// return List [MenuModel]
  Future<List<MenuModel>> getParentMenu(String idMenu) async {
    return requestHandler(() async {
      Response response = await dio.get('/menus/$idMenu/parents');
      var jsonResult = _json(response.data);
      List<MenuModel> menuParent = [];
      if (jsonResult is Map<String, dynamic>) {
        Map<String, dynamic> jsonResult = _json(response.data);
        if (jsonResult["3"] != null) {
          menuParent.add(MenuModel.fromJson(jsonResult["3"]));
        }
        if (jsonResult["2"] != null) {
          menuParent.add(MenuModel.fromJson(jsonResult["2"]));
        }
        if (jsonResult["1"] != null) {
          menuParent.add(MenuModel.fromJson(jsonResult["1"]));
        }
        if (jsonResult["0"] != null) {
          menuParent.add(MenuModel.fromJson(jsonResult["0"]));
        }
      } else if (jsonResult is List<dynamic>) {
        List<dynamic> jsonResult = _json(response.data);
        for (var e in jsonResult) {
          menuParent.add(MenuModel.fromJson(e));
        }
      }

      return menuParent;
    });
  }

  /// Récupère les tarifs des annonces avec leurs options associés à un menu donné.
  /// [idMenu] : id du menu
  /// return list [AnnonceTarifOptionModel]
  Future<List<AnnonceTarifOptionModel>> getMenuTarifWithOption(
    String idMenu,
  ) async {
    return requestHandler(() async {
      Response response = await dio.get('/menus/$idMenu/availables');
      Map<String, dynamic> jsonResult = _json(response.data);
      List<AnnonceTarifOptionModel> annoncesListTarifOptionModel = [];

      /// l'endpoint /menus/$idMenu/availables retourne une list option
      /// [GENERAL], [PREMIUM], [VIP], [PARTENAIRE], [SPONSOR]
      if (jsonResult["GENERAL"] != null) {
        annoncesListTarifOptionModel.add(
          AnnonceTarifOptionModel.fromJson(
            jsonResult["GENERAL"],
            AnnonceType.general,
          ),
        );
      }
      if (jsonResult["PREMIUM"] != null) {
        annoncesListTarifOptionModel.add(
          AnnonceTarifOptionModel.fromJson(
            jsonResult["PREMIUM"],
            AnnonceType.premium,
          ),
        );
      }
      if (jsonResult["VIP"] != null) {
        annoncesListTarifOptionModel.add(
          AnnonceTarifOptionModel.fromJson(jsonResult["VIP"], AnnonceType.vip),
        );
      }
      if (jsonResult["PARTENAIRE"] != null) {
        annoncesListTarifOptionModel.add(
          AnnonceTarifOptionModel.fromJson(
            jsonResult["PARTENAIRE"],
            AnnonceType.partenaire,
          ),
        );
      }
      if (jsonResult["SPONSOR"] != null) {
        annoncesListTarifOptionModel.add(
          AnnonceTarifOptionModel.fromJson(
            jsonResult["SPONSOR"],
            AnnonceType.sponsor,
          ),
        );
      }

      return annoncesListTarifOptionModel;
    });
  }

  /// Connecte un utilisateur.
  /// [login] : numéro de l'utilisateur
  /// [password] : mot de passe de l'utilisateur
  /// [staylogged] : options "rester connecté"
  /// return [UserModel]
  Future<UserModel> loginUser(
    String login,
    String password,
    bool stayLogged,
  ) async {
    return requestHandler(() async {
      Response response = await dio.post(
        '/auth/login/',
        data: {
          "email": login.replaceAll(" ", ""),
          "password": password,
          'a_vis': stayLogged ? 1 : 0,
        },
      );
      Map<String, dynamic> jsonResult = _json(response.data);

      return UserModel.fromJsonAuth(jsonResult);
    });
  }

  /// Déconnecte un utilisateur.
  Future<void> logoutUser() async {
    return requestHandler(() async {
      await dio.post('/auth/logout');
      return;
    });
  }

  /// Met à jour les informations d'un utilisateur.
  /// [UserModel] : instance de l'userModel
  /// return [UserModel] : l'instance de l'userModel mis à jour
  Future<UserModel> updateUser(UserModel userModel) async {
    return requestHandler(() async {
      Response response = await dio.put('/profil', data: userModel.toJson());
      Map<String, dynamic> jsonResult = _json(response.data);
      return UserModel.fromJson(jsonResult);
    });
  }

  /// Récupère les informations de l'utilisateur connecté.
  /// return [UserModel]
  Future<UserModel> fetchUserInfo() async {
    return requestHandler(() async {
      Response response = await dio.get('/profil');
      Map<String, dynamic> jsonResult = _json(response.data);
      return UserModel.fromJson(jsonResult);
    });
  }

  /// Récupère les informations de l'utilisateur connecté.
  /// return [UserModel]
  Future<UserModel> fetchUserInfoProfilById(int id) async {
    return requestHandler(() async {
      Response response = await dio.get('/profil/$id');
      Map<String, dynamic> jsonResult = _json(response.data);
      if (kDebugMode) {
        print("USER MODEL ");
      }
      return UserModel.fromJson(jsonResult);
    });
  }

  /// Récupère les informations de l'utilisateur connecté.
  /// return [int]
  Future<int> fetchUserProfilAnnoncesCount(int id) async {
    return requestHandler(() async {
      Response response = await dio.get('/profil/$id/annonces');
      Map<String, dynamic> jsonResult = _json(response.data);
      return jsonResult["total"] ?? 0;
    });
  }

  Future<List<AnnonceModel>> fetchAnnoncesUserProfilById(
    int id,
    int page,
    String query,
  ) async {
    return requestHandler(() async {
      String url = '';
      // Chargement des annonces avec pagination
      if (page > 1 || query != "") {
        if (query != "") {
          url = '/profil/$id/annonces?page=$page&query=$query';
        } else {
          url = '/profil/$id/annonces?page=$page';
        }
      } else {
        url = '/profil/$id/annonces';
      }

      Response response = await dio.get(url);
      Map<String, dynamic> jsonResult = _json(response.data);
      if (kDebugMode) {
        print(jsonResult);
      }
      List<AnnonceModel> annonceModelList = [];

      if (jsonResult["data"] != null) {
        List<dynamic> resultList = (jsonResult["data"] as List<dynamic>);
        for (var e in resultList) {
          annonceModelList.add(
            AnnonceModel.fromJson(e, annonceType: AnnonceType.general),
          );
        }
      }

      return annonceModelList;
    });
  }

  /// Enregistre un nouvel utilisateur.
  /// [UserModel] : instance userModel du nouvel utilisateur
  /// return [UserModel] : l'instance de l'userModel créée
  Future<UserModel> registerUser(UserModel userModel) async {
    return requestHandler(() async {
      Response response = await dio.post(
        '/auth/register',
        data: {
          "nom": userModel.name,
          "prenom": "",
          "pseudo": userModel.pseudo,
          "genre": userModel.genre,
          "phone": userModel.phoneNumber,
          "annee_naissance": userModel.dateDeNaissance,
          "lieu_residence": userModel.lieuResidence,
          "email": userModel.mail,
          "password": userModel.tokenORPassword,
        },
      );
      Map<String, dynamic> jsonResult = _json(response.data);
      return UserModel.fromJsonAuth(jsonResult);
    });
  }

  /// Récupère une annonce par son identifiant.
  /// [id] : id de l'annonce
  /// return [AnnonceModel]
  Future<AnnonceModel> fetchAnnonceById(String id) async {
    return requestHandler(() async {
      Response response = await dio.get('/annonces/$id');
      Map<String, dynamic> jsonResult = _json(response.data);
      if (kDebugMode) {
        print("ANNONCE MODEL : $jsonResult");
      }
      return AnnonceModel.fromJson(jsonResult);
    });
  }

  Future<List<AnnonceModel>> fetchAnnonceByIdWithPartnerSponsor(
    String id,
  ) async {
    return requestHandler(() async {
      Response response = await dio.get('/annonces/$id/withPubs');
      Map<String, dynamic> jsonResult = _json(response.data);
      List<AnnonceModel> annonceModelList = [];
      if (jsonResult["SPONSOR"] != null) {
        annonceModelList.add(
          AnnonceModel.fromJson(
            jsonResult["SPONSOR"],
            annonceType: AnnonceType.sponsor,
          ),
        );
      }
      if (jsonResult["PARTENAIRE"] != null) {
        annonceModelList.add(
          AnnonceModel.fromJson(
            jsonResult["PARTENAIRE"],
            annonceType: AnnonceType.partenaire,
          ),
        );
      }
      if (jsonResult["annonceDetails"] != null) {
        annonceModelList.add(
          AnnonceModel.fromJson(
            jsonResult["annonceDetails"],
            annonceType: AnnonceType.general,
          ),
        );
      }

      return annonceModelList;
    });
  }

  /// Récupère la liste des annonces.
  /// [idMenu] : l'identifiant du menu ;
  /// [page] : l'index de la page (commence à 1) ;
  /// [query] : la chaîne de requête de recherche (peut être vide : "") ;
  /// return une liste de [AnnonceModel].
  Future<List<AnnonceModel>> fetchRecentsAnnonces(
    int idMenu,
    int page,
    String query,
  ) async {
    return requestHandler(() async {
      String url = '';
      // Chargement des annonces avec pagination
      if (page > 1 || query != "") {
        if (query != "") {
          url = '/annonces?page=$page&query=$query';
        } else {
          url = '/annonces?page=$page';
        }
      } else {
        url = '/annonces';
      }

      Response response = await dio.get(url);
      Map<String, dynamic> jsonResult = _json(response.data);
      if (kDebugMode) {
        print(jsonResult);
      }
      List<AnnonceModel> annonceModelList = [];

      if (jsonResult["data"] != null) {
        List<dynamic> resultList = (jsonResult["data"] as List<dynamic>);
        for (var e in resultList) {
          if (e["type"] != null) {
            if (kDebugMode) {
              print("object");
            }
            if (e["type"]["nom"] == "VIP") {
              annonceModelList.add(
                AnnonceModel.fromJson(e, annonceType: AnnonceType.vip),
              );
            } else if (e["type"]["nom"] == "PREMIUM") {
              annonceModelList.add(
                AnnonceModel.fromJson(e, annonceType: AnnonceType.premium),
              );
            } else {
              annonceModelList.add(
                AnnonceModel.fromJson(e, annonceType: AnnonceType.general),
              );
            }
          }
        }
      }

      return annonceModelList;
    });
  }

  /// Prolonge la validité d'une annonce.
  /// [idAnnonce] : id de l'annonce à prolonger
  /// [idTarifOption] : id du tarifOption choisie
  /// return [AnnonceModel]
  Future<AnnonceModel> extendValidity(int idAnnonce, int idTarifOption) async {
    return requestHandler(() async {
      Response response = await dio.post(
        '/annonces/$idAnnonce/prolonger',
        data: {"optionId": idTarifOption},
      );
      Map<String, dynamic> jsonResult = _json(response.data);

      return AnnonceModel.fromJson(jsonResult);
    });
  }

  /// Récupère une annonce popup.
  /// [isPair] : true si recuperation annonce 2, false si recuperation annonce 1
  /// return [AnnonceModel]
  Future<AnnonceModel> fetchAnnoncePopup(bool isPair) async {
    return requestHandler(() async {
      Response response = await dio.get('/annonces/popup/${isPair ? 2 : 1}');
      Map<String, dynamic> jsonResult = _json(response.data);
      return AnnonceModel.fromJson(jsonResult);
    });
  }

  /// Récupère les informations du menu de profil de l'utilisateur.
  /// return [UserMenuProfilModel]
  Future<UserMenuProfilModel> getUserMenuProfil() async {
    return requestHandler(() async {
      Response response = await dio.get('/profil/menu');
      Map<String, dynamic> jsonResult = _json(response.data);
      return UserMenuProfilModel.fromJson(jsonResult);
    });
  }

  /// Retourne le nombre total d'une annonce
  Future<int> fetchUserFavoriteAnnoncesCount() async {
    return requestHandler(() async {
      Response response = await dio.get('/profil/menu');
      Map<String, dynamic> jsonResult = _json(response.data);
      if (kDebugMode) {
        print("HERERERERE : $jsonResult");
      }
      return jsonResult["annonceFavoris"]["total"] ?? 0;
    });
  }

  Future<List<AnnonceModel>> fetchUserFavoriteAnnonces(
    int page,
    String query,
  ) async {
    return requestHandler(() async {
      String url = '';
      // Chargement des annonces avec pagination
      if (page > 1 || query != "") {
        if (query != "") {
          url = '/profil/menu?page=$page&query=$query';
        } else {
          url = '/profil/menu?page=$page';
        }
      } else {
        url = '/profil/menu';
      }

      Response response = await dio.get(url);
      Map<String, dynamic> jsonResult = _json(response.data);
      if (kDebugMode) {
        print(jsonResult);
      }
      List<AnnonceModel> annonceModelList = [];

      if (jsonResult["annonceFavoris"] != null) {
        List<dynamic> resultList =
            (jsonResult["annonceFavoris"]["data"] as List<dynamic>);
        if (kDebugMode) {
          print("RESULTAT FAVORIS : ${jsonResult["annonceFavoris"]}");
        }
        for (var e in resultList) {
          annonceModelList.add(
            AnnonceModel.fromJson(e, annonceType: AnnonceType.general),
          );
        }
      }

      return annonceModelList;
    });
  }

  /// Met à jour une annonce existante.
  /// [annonceModel] : instance de l'annonce modifiée
  /// return [AnnonceModel]
  Future<AnnonceModel> updateAnnonce(AnnonceModel annonceModel) async {
    return requestHandler(() async {
      Response response = await dio.put(
        '/annonces/${annonceModel.id}',
        data: annonceModel.toJson(),
      );
      var result = _json(response.data);

      /// Depend de l'objet retourné
      /// si le retour est id de l'annonce
      if (result is int) {
        return annonceModel.copyWith(id: result);
      } else if (result is String) {
        return annonceModel.copyWith(id: int.parse(result));
      }
      /// si le retour est Annonce Json
      else {
        return AnnonceModel.fromJson(
          result,
          annonceType: annonceModel.annonceType,
        );
      }
    });
  }

  /// Supprime une annonce.
  /// [id] : id de l'annonce à supprimer
  Future<void> deleteAnnonce(String id) async {
    return requestHandler(() async {
      await dio.delete('/annonces/$id');
      return;
    });
  }

  /// Supprime un utilisateur.
  Future<void> deleteUser() async {
    return requestHandler(() async {
      await dio.delete('/profil');
      return;
    });
  }

  /// Annule le téléchargement d'une image.
  /// [uploadCancelToken] : l'instance DIO pour annuler l'upload
  /// return true ( ignore le résultat );
  Future<bool> cancelImageUpload(CancelToken uploadCancelToken) async {
    uploadCancelToken.cancel();
    return true;
  }

  /// Vérifie les mises à jour de l'application.
  /// return [String] : format X.X.X
  Future<String> checkUpdate() async {
    return requestHandler(() async {
      Response response = await dio.get('/app/getUpdate');
      Map<String, dynamic> jsonResult = _json(response.data);
      return jsonResult["version"];
    });
  }

  /// Upload une image.
  /// [imageByte] : image brute en Uint8List
  /// [idMenu] : id du menu de l'annonce
  /// [onProgress] : callback qui met à jour la progression (en pourcentage )de l'upload
  /// [cancelToken] : instance pour annuler l'upload
  /// return [ImageModel]
  Future<ImageModel> uploadImage(
    Uint8List imageByte,
    String idMenu,
    Function(double progress)? onProgress,
    CancelToken? cancelToken,
  ) async {
    String imageBase64 = "";

    imageBase64 = AppUtils.uint8ListImageToBase64(imageByte);
    AppUtils.showDebugLog(
      runtimeType,
      "imageByte: ${imageByte.length / 1024} KB, base64Len=${imageBase64.length / 1024} KB",
    );
    return requestHandler(() async {
      Response response = await dio.post(
        '/annonces/images',
        data: {"image": imageBase64, "idMenu": idMenu},
        onSendProgress: (int sent, int total) {
          if (onProgress != null) {
            onProgress((sent / total) * 100);
          }
        },
        cancelToken: cancelToken,
      );
      Map<String, dynamic> jsonResult = _json(response.data);
      return ImageModel.fromJson(jsonResult);
    });
  }

  /// Vérifie l'authentification de l'utilisateur.
  /// utilise le token sauvé
  ///
  /// si non authentifié: envoie un erreur
  /// return [UserModel] si authentifié
  Future<UserModel> checkUserAuth() async {
    return requestHandler(() async {
      Response response = await dio.get('/profil');
      Map<String, dynamic> jsonResult = _json(response.data);
      return UserModel.fromJson(jsonResult);
    });
  }

  /// Crée une nouvelle annonce.
  /// [annonceModel] : instance de la nouvelle annonce
  /// [idTarifOptions] : id de l'option de tarifs choisi
  /// return [AnnonceModel] : l'annonce créée
  Future<AnnonceModel> createAnnonce(
    AnnonceModel annonceModel,
    int idTarifOptions,
  ) async {
    return requestHandler(() async {
      Response response = await dio.post(
        '/annonces',
        data: annonceModel.toJson()..["option_id"] = idTarifOptions,
        onSendProgress: (int sent, int total) {
          AppUtils.showDebugLog(
            runtimeType,
            "createAnnonce uploading: $sent/$total",
          );
        },
      );
      var result = _json(response.data);

      /// Depend de l'objet retourné
      /// si le retour est id de l'annonce
      if (result is int) {
        return annonceModel.copyWith(id: result);
      } else if (result is String) {
        return annonceModel.copyWith(id: int.parse(result));
      }
      /// si le retour est un json
      else if (result is Map<String, dynamic>) {
        annonceModel = annonceModel.copyWith(
          id: result["id"] ?? 0,
          dateDeCreation: result["created_at"] ?? " ",
        );
        return annonceModel;
      }
      /// si la requete n'a pas comporté une erreur
      else {
        return annonceModel;
      }
    });
  }

  /// Crée une nouvelle annonce.
  /// [annonceModel] : instance de la nouvelle annonce
  /// [idTarifOptions] : id de l'option de tarifs choisi
  /// return [AnnonceModel] : l'annonce créée
  Future<AnnonceModel> createAnnoncePlainteSuggestion(
    AnnonceModel annonceModel,
    int idTarifOptions,
  ) async {
    return requestHandler(() async {
      Response response = await dio.post(
        '/plainte_suggestion',
        data: annonceModel.toJson()..["option_id"] = idTarifOptions,
        onSendProgress: (int sent, int total) {
          AppUtils.showDebugLog(
            runtimeType,
            "createAnnonce uploading: $sent/$total",
          );
        },
      );
      var result = _json(response.data);

      /// Depend de l'objet retourné
      /// si le retour est id de l'annonce
      if (result is int) {
        return annonceModel.copyWith(id: result);
      } else if (result is String) {
        return annonceModel.copyWith(id: int.parse(result));
      }
      /// si le retour est un json
      else if (result is Map<String, dynamic>) {
        annonceModel = annonceModel.copyWith(
          id: result["id"] ?? 0,
          dateDeCreation: result["created_at"] ?? " ",
        );
        return annonceModel;
      }
      /// si la requete n'a pas comporté une erreur
      else {
        return annonceModel;
      }
    });
  }

  /// Récupère les commentaires d'une annonce.
  /// [idAnnonce] : id de l'annonce contenant les commentaires
  /// [page] : page du commentaire (commence par 1 )
  /// return list [CommentaireModel]
  Future<List<CommentaireModel>> fetchCommentaire(
    String idAnnonce,
    int page,
  ) async {
    return requestHandler(() async {
      Response response = await dio.get(
        '/annonces/$idAnnonce/commentaires/paginate?page=$page',
      );
      var jsonResult = _json(response.data);
      if (jsonResult["data"] != null) {
        List<dynamic> resultList = (jsonResult["data"] as List<dynamic>);
        return (resultList).map((e) => CommentaireModel.fromJson(e)).toList();
      } else {
        return [];
      }
    });
  }

  /// Récupère la liste des avatars.
  /// return list [AvatarModel]
  Future<List<AvatarModel>> fetchAvatarList() async {
    return requestHandler(() async {
      Response response = await dio.get('/avatar');
      var jsonResult = _json(response.data);
      return (jsonResult as List<dynamic>)
          .map((e) => AvatarModel.fromJson(e))
          .toList();
    });
  }

  /// Récupère la liste des provinces.
  /// return list [ProvinceModel]
  Future<List<ProvinceModel>> fetchKaraProvinceList() async {
    return requestHandler(() async {
      Response response = await dio.get('/menus/kara_partenaires');
      var jsonResult = _json(response.data);
      return (jsonResult["provinces"] as List<dynamic>)
          .map((e) => ProvinceModel.fromJson(e))
          .toList();
    });
  }

  /// Récupère la liste des provinces.
  /// return list [ProvinceModel]
  Future<void> karaSubscription(List<String> provinces, String slug) async {
    return requestHandler(() async {
      Response response = await dio.post(
        '/menus/kara_partenaires/subscribe',
        data: {"provinces": provinces, "slug": slug},
      );
      var jsonResult = _json(response.data);
      if (kDebugMode) {
        print("INSCRIPTION KARA : $jsonResult");
      }
      return;
    });
  }

  /// Achète un avatar.
  /// endpoint pas encore disponible
  /// TO DO
  Future<void> buyAvatar(int id, int nombre) async {
    return requestHandler(() async {
      // Response response = await dio.get(
      //   '/avatars',
      // );

      // // var jsonResult = _json(response.data);
    });
  }

  /// Crée un commentaire.
  /// [idAnnonce] : id de l'annonce
  /// [content] : contenue du commentaire
  /// return [CommentaireModel] : le commentaire créé
  Future<CommentaireModel> createCommentaire(
    int idAnnonce,
    String content,
  ) async {
    return requestHandler(() async {
      Response response = await dio.post(
        '/annonces/$idAnnonce/commentaires',
        data: {"comment": content},
      );

      var jsonResult = _json(response.data);
      return CommentaireModel.fromJson(jsonResult);
    });
  }

  /// Marque une annonce comme favorite ou non.
  /// [id] : id de l'annonce
  /// [isLike] : true si ajout dans favoris, false si enleve du favoris
  /// return [AnnonceModel]
  Future<AnnonceModel> makeFavAnnonce(int id, bool isLike) async {
    return requestHandler(() async {
      Response response = await dio.post(
        '/annonces/$id/favoris',
        data: {"action": isLike ? "favs" : "unFavs"},
      );

      Map<String, dynamic> jsonResult = _json(response.data);
      AnnonceModel annonce = AnnonceModel.fromJson(jsonResult);
      return annonce;
    });
  }

  /// Réagit à une annonce (like/dislike).
  /// [id] : id de l'annonce
  /// [isLike] : true si like, false si dislike
  /// return [AnnonceModel]
  Future<AnnonceModel> reactAnnonce(int id, bool isLike) async {
    return requestHandler(() async {
      Response response = await dio.post(
        '/annonces/$id/reaction',
        data: {"action": isLike ? "like" : "dislike"},
      );

      Map<String, dynamic> jsonResult = _json(response.data);
      AnnonceModel annonce = AnnonceModel.fromJson(jsonResult);
      return annonce;
    });
  }

  /// Pour l'instant, met à jour l'état de like/dislike d'un commentaire.
  /// [commentaireModel] : instance du commentaire
  /// return [CommentaireModel]
  Future<CommentaireModel> updateCommentaire(
    CommentaireModel commentaireModel,
  ) async {
    return requestHandler(() async {
      Response response = await dio.post(
        '/annonces/${commentaireModel.annonceID}/commentaires/${commentaireModel.id}/reaction',
        data: {"action": commentaireModel.hasLike ? "like" : "dislike"},
      );

      Map<String, dynamic> jsonResult = _json(response.data);
      commentaireModel = commentaireModel.copyWith(
        likeCount: jsonResult["reactions_count"] ?? 0,
        hasLike: jsonResult["hasLike"],
      );
      return commentaireModel;
    });
  }

  /// Supprime un commentaire.
  /// [id] : id du commentaire
  /// [idAnnonce] : id de l'annonce
  /// return null
  Future<void> deleteCommentaire(String id, String idAnnonce) async {
    return requestHandler(() async {
      await dio.delete('/annonces/$idAnnonce/commentaires/$id');
      return;
    });
  }

  /// Récupère les messages de l'utilisateur
  Future<List<MessageModel>> fetchUserMessage(int page) async {
    try {
      Response response = await dio.get('/notification?page=$page');

      if (response.statusCode == 200) {
        List<dynamic> resultList = _json(response.data);

        return (resultList).map((e) => MessageModel.fromJson(e)).toList();
      } else {
        throw Exception();
      }
    } catch (e) {
      AppUtils.showDebugLog(runtimeType, e.toString());
      if (e is DioException) {
        if (e.response != null && e.response?.statusCode == 404) {
          throw PageNotFoundException(
            message:
                " ${(e.response?.data)["message"]} ${((e.response?.data)["data"]) ?? ""}",
          );
        } else if (e.type == DioExceptionType.connectionError) {
          throw NoConnectionException();
        }
        throw ServerException(
          message:
              (" ${(e.response?.data)["message"]} ${((e.response?.data)["data"]) ?? ""}"),
        );
      }

      throw ServerException(message: e.toString());
    }
  }

  /// Ouvre(marquer comme lus) un messages de l'utilisateur
  Future<void> viewUserMessage(int id) async {
    try {
      Response response = await dio.get('/notification/$id');

      if (response.statusCode == 200) {
        _json(response.data);

        return;
      } else {
        throw Exception();
      }
    } catch (e) {
      AppUtils.showDebugLog(runtimeType, e.toString());
      if (e is DioException) {
        if (e.response != null && e.response?.statusCode == 404) {
          throw PageNotFoundException(
            message:
                " ${(e.response?.data)["message"]} ${((e.response?.data)["data"]) ?? ""}",
          );
        } else if (e.type == DioExceptionType.connectionError) {
          throw NoConnectionException();
        }
        throw ServerException(
          message:
              (" ${(e.response?.data)["message"]} ${((e.response?.data)["data"]) ?? ""}"),
        );
      }

      throw ServerException(message: e.toString());
    }
  }

  Future<void> viewAllUserMessage() async {
    try {
      Response response = await dio.get('/notification/view_all');

      if (response.statusCode == 200) {
        _json(response.data);

        return;
      } else {
        throw Exception();
      }
    } catch (e) {
      AppUtils.showDebugLog(runtimeType, e.toString());
      if (e is DioException) {
        if (e.response != null && e.response?.statusCode == 404) {
          throw PageNotFoundException(
            message:
                " ${(e.response?.data)["message"]} ${((e.response?.data)["data"]) ?? ""}",
          );
        } else if (e.type == DioExceptionType.connectionError) {
          throw NoConnectionException();
        }
        throw ServerException(
          message:
              (" ${(e.response?.data)["message"]} ${((e.response?.data)["data"]) ?? ""}"),
        );
      }

      throw ServerException(message: e.toString());
    }
  }

  /// Supprime tous les messages de l'utilisateur
  Future<void> deleteAllUserMessage() async {
    return requestHandler(() async {
      await dio.delete('/notification/delete_all');
      return;
    });
  }

  /// Supprime un messages de l'utilisateur
  Future<void> deleteUserMessage(int id) async {
    return requestHandler(() async {
      await dio.delete('/notification/$id');
      return;
    });
  }

  /// Récupère l'historique des transactions de l'utilisateur.
  /// TO DO: ENDPOINT PAS ENCORE DISPONIBLE [page] : page index (commence par 1)
  /// return list [TransactionHistoryModel]
  Future<List<TransactionHistoryModel>> fetchUserTransactionHistory(
    int page,
  ) async {
    return requestHandler(() async {
      Response response = await dio.get('/profil/faka/historique');
      List<dynamic> resultList = _json(response.data);

      return (resultList)
          .map((e) => TransactionHistoryModel.fromJson(e))
          .toList();
    });
  }

  /// Recupère le nombre de messages non lus de l'utilisateur
  ///
  Future<int> getUserUnreadMessageCount() async {
    return requestHandler(() async {
      Response response = await dio.get('/notification/unread-count');
      int resultList = _json(response.data);
      return resultList;
    });
  }

  /// Gère la désérialisation de la réponse JSON et les erreurs de serveur.
  dynamic _json(dynamic data) {
    Map<String, dynamic> result;
    if (data is String) {
      result = jsonDecode(data);
    } else {
      result = data;
    }
    try {
      if (result["message"] != null) {
        String resultType = result["message"];
        if (resultType == "Success") {
          return result["data"];
        } else {
          throw Exception();
        }
      } else {
        return result;
      }
    } on Exception {
      throw const ServerException(message: "Bad server response");
    }
  }

  /// Gère les requêtes API en encapsulant l'appel et en gérant les erreurs courantes.
  Future<T> requestHandler<T>(Future<T> Function() requestBody) async {
    try {
      var result = await requestBody();
      return result;
    } catch (e) {
      AppUtils.showDebugLog(runtimeType, e.toString());
      if (e is DioException) {
        if (e.response != null && e.response?.statusCode == 404) {
          throw PageNotFoundException(
            message:
                " ${(e.response?.data)["message"]} ${((e.response?.data)["data"]) ?? ""}",
          );
        } else if (e.type == DioExceptionType.connectionError) {
          throw NoConnectionException();
        } else if (e.response?.statusCode == 402 ||
            e.response?.statusCode == 401) {
          if (e.requestOptions.path.endsWith("/auth/register")) {
            throw UserRegisterException(
              message:
                  ((e.response?.data)["message"]) +
                  ((e.response?.data)["data"],).toString(),
            );
          } else {
            throw UserRegisterException(
              message:
                  ((e.response?.data)["message"]) +
                  ((e.response?.data)["data"]).toString(),
            );
          }
        }
        throw ServerException(
          message:
              (" ${(e.response?.data)["message"]} ${((e.response?.data)["data"]) ?? ""}"),
        );
      }

      throw ServerException(message: e.toString());
    }
  }
}
