import 'package:mips/common/constants/constant.dart';
import 'package:mips/domain/entities/reward.dart';

class RewardModel {
  const RewardModel({
    required this.rewardType,
    required this.amount,
    required this.counts,
    required this.counted,
    required this.annonceClickedList,
    required this.sondageRespondedList,
  });
  final RewardType rewardType;
  final int amount;
  final int counts;
  final int counted;
  final List<AnnonceClickedModel> annonceClickedList;
  final List<SondageRespondedModel> sondageRespondedList;

  factory RewardModel.fromJson(Map<String, dynamic> map) {
    RewardType rewardType = RewardType.connexion;
    List<AnnonceClickedModel> annonceClickedList = [];
    List<SondageRespondedModel> sondageRespondedList = [];

    if (map["type"] != null) {
      switch (map["type"]) {
        case "CONNEXION_QUOTIDIENNE":
          rewardType = RewardType.connexion;
          break;
        case "CLICK_PUBLICITE":
          rewardType = RewardType.pub;
          if (map["annonces"] != null) {
            for (var e in map["annonces"] as List<dynamic>) {
              annonceClickedList.add(AnnonceClickedModel.fromJson(e));
            }
            print("ANNONCES : ${annonceClickedList.length}");
          }
          break;
        case "CLICK_POP_UP":
          rewardType = RewardType.popUp;
          break;
        case "SONDAGE_RESPONSE":
          rewardType = RewardType.sondage;
          if (map["sondages"] != null) {
            for (var e in map["sondages"] as List<dynamic>) {
              sondageRespondedList.add(SondageRespondedModel.fromJson(e));
            }
            print("SONDAGES : ${sondageRespondedList.length}");
          }
          break;
        default:
          rewardType = RewardType.none;
          break;
      }
    }

    return RewardModel(
      rewardType: rewardType,
      amount: map["montant"] ?? 0,
      counts: map["count"] ?? 0,
      counted: map["already_given"] ?? 0,
      annonceClickedList: annonceClickedList,
      sondageRespondedList: sondageRespondedList,
    );
  }

  Reward toEntity() {
    return Reward(
      rewardType: rewardType,
      amount: amount,
      counts: counts,
      counted: counted,
      annonceClickedList: annonceClickedList.map((e) => e.toEntity()).toList(),
      sondageRespondedList: sondageRespondedList
          .map((e) => e.toEntity())
          .toList(),
    );
  }
}

class AnnonceClickedModel {
  const AnnonceClickedModel({
    required this.id,
    required this.slug,
    required this.type,
    required this.menu,
  });
  final int id;
  final String slug;
  final String type;
  final String menu;

  factory AnnonceClickedModel.fromJson(Map<String, dynamic> map) {
    return AnnonceClickedModel(
      id: map["id"] ?? 0,
      slug: map["slug"] ?? "",
      type: map["type"] ?? "",
      menu: map["menu"] ?? "",
    );
  }

  AnnonceClicked toEntity() {
    return AnnonceClicked(id: id, slug: slug, type: type, menu: menu);
  }
}

class SondageRespondedModel {
  const SondageRespondedModel({required this.id, required this.question});
  final int id;
  final String question;

  factory SondageRespondedModel.fromJson(Map<String, dynamic> map) {
    return SondageRespondedModel(
      id: map["id"] ?? 0,
      question: map["question"] ?? "",
    );
  }

  SondageResponded toEntity() {
    return SondageResponded(id: id, question: question);
  }
}
