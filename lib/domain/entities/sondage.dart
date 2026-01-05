/// Entité représentant un sondage.
///
/// Contient :
/// - l’identifiant du sondage ([id])
/// - le thème du sondage ([theme])
/// - la date limite de participation ([dateLimite])
/// - la date de publication du sondage ([datePublication])
/// - l’option sélectionnée par l’utilisateur ([userSelectedOption])
/// - le nombre total de réponses ([totalResponseCount])
/// - la liste des options de réponse ([sondageOption])
class Sondage {
  final int id;
  final String theme;
  final String themeUrlImage;
  final String dateLimite;
  final String datePublication;
  final int userSelectedOption;
  final int totalResponseCount;
  final List<SondageOption> sondageOption;

  const Sondage(
      {required this.id,
      required this.theme,
      required this.themeUrlImage,
      required this.dateLimite,
      required this.datePublication,
      required this.userSelectedOption,
      required this.sondageOption,
      required this.totalResponseCount});

  Sondage copyWith({
    int? id,
    String? theme,
    String? themeUrlImage,
    String? dateLimite,
    String? datePublication,
    int? userSelectedOption,
    int? totalResponseCount,
    List<SondageOption>? sondageOption,
  }) {
    return Sondage(
      id: id ?? this.id,
      theme: theme ?? this.theme,
      themeUrlImage: themeUrlImage ?? this.themeUrlImage,
      dateLimite: dateLimite ?? this.dateLimite,
      datePublication: datePublication ?? this.datePublication,
      userSelectedOption: userSelectedOption ?? this.userSelectedOption,
      totalResponseCount: totalResponseCount ?? this.totalResponseCount,
      sondageOption: sondageOption ?? this.sondageOption,
    );
  }
}

class SondageOption {
  final int id;
  final String optionText;
  final String imageUrl;

  const SondageOption({
    required this.id,
    required this.optionText,
    required this.imageUrl,
  });
}
