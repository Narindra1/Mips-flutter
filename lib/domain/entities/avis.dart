import '../../common/constants/constant.dart';

class Avis {
  final int id;
  final String title;
  final String dateUpdate;
  final String htmlURL;
  final AvisType avisType;

  const Avis({
    required this.id,
    required this.title,
    required this.avisType,
    required this.dateUpdate,
    required this.htmlURL,
  });
}
