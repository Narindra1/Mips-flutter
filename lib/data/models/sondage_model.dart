import 'package:mips/common/services/environment_wrapper.dart';
import 'package:mips/domain/domain.dart';
import 'package:get_it/get_it.dart';

/// Modèle représentant un sondage.
///
/// Champs :
/// - [id] : identifiant unique du sondage.
/// - [theme] : thème/question du sondage.
/// - [dateLimite] : date limite de participation.
/// - [datePublication] : date de publication du sondage.
/// - [userSelectedOption] : index de l'option sélectionnée par l'utilisateur (peut être nul si aucune sélection).
/// - [totalResponseCount] : nombre total de réponses enregistrées.
/// - [sondageOption] : liste des options proposées pour le sondage.

class SondageModel {
  final int id;
  final String theme;
  final String themeUrlImage;
  final String dateLimite;
  final String datePublication;
  final int? userSelectedOption;
  final int totalResponseCount;
  final List<SondageOptionModel> sondageOption;

  const SondageModel({
    required this.id,
    required this.theme,
    required this.themeUrlImage,
    required this.dateLimite,
    required this.datePublication,
    required this.userSelectedOption,
    required this.sondageOption,
    required this.totalResponseCount,
  });

  factory SondageModel.fromJson(Map<String, dynamic> json) {
    int responseCount = 0;
    List<SondageOptionModel> sondageOptionList = (json['options'] as List).map((
      e,
    ) {
      return SondageOptionModel.fromJson(e);
    }).toList();
    for (var e in sondageOptionList) {
      responseCount = responseCount + e.responseCount;
    }

    return SondageModel(
      id: json['id'],
      theme: json['question'],
      themeUrlImage: json['question_image'] != null
          ? (GetIt.instance<EnvironmentWrapper>().baseUrl +
                json['question_image'])
          : "",
      dateLimite: json['date_limit'],
      datePublication: json['date_creation'],
      userSelectedOption: json['user_selected_option'],
      sondageOption: sondageOptionList,
      totalResponseCount: responseCount,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'theme': theme,
      'date_limite': dateLimite,
      'date_publication': datePublication,
      'user_selected_option': userSelectedOption,
      'options': sondageOption.map((e) => e.toJson()).toList(),
    };
  }

  Sondage toEntity() {
    return Sondage(
      id: id,
      theme: theme,
      themeUrlImage: themeUrlImage,
      dateLimite: dateLimite,
      datePublication: datePublication,
      totalResponseCount: totalResponseCount,
      userSelectedOption: userSelectedOption ?? -1,
      sondageOption: sondageOption.map((e) => e.toEntity()).toList(),
    );
  }
}

/// Modèle représentant une option d'un sondage.
///
/// Champs :
/// - [id] : identifiant unique de l'option.
/// - [optionText] : texte de l'option.
/// - [responseCount] : nombre de réponses pour cette option.

class SondageOptionModel {
  final int id;
  final String optionText;
  final String imageUrl;
  final int responseCount;

  const SondageOptionModel({
    required this.id,
    required this.optionText,
    required this.imageUrl,
    required this.responseCount,
  });

  factory SondageOptionModel.fromJson(Map<String, dynamic> json) {
    return SondageOptionModel(
      id: json['id'],
      optionText: json['label'],
      imageUrl: json['imageUrl'] != null
          ? (GetIt.instance<EnvironmentWrapper>().baseUrl + json['imageUrl'])
          : "",
      responseCount: json['responses_count'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'option': optionText};
  }

  SondageOption toEntity() {
    return SondageOption(id: id, optionText: optionText, imageUrl: imageUrl);
  }
}
