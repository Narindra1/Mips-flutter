import 'package:mips/domain/entities/avis.dart';

import '../../common/constants/constant.dart';

/// Model pour le Avis
class AvisModel {
  final int id;
  final String title;
  final String dateUpdate;
  final String htmlURL;
  final AvisType avisType;

  const AvisModel({
    required this.id,
    required this.title,
    required this.avisType,
    required this.dateUpdate,
    required this.htmlURL,
  });

  factory AvisModel.fromJson(
    Map<String, dynamic> map, {
    required AvisType avisType,
  }) {
    return AvisModel(
      id: map['id'] as int,
      title: map['titre'] as String,
      avisType: avisType,
      dateUpdate: map['updated_at'] as String,
      htmlURL: map['content_url'] as String,
    );
  }

  Avis toEntity() {
    return Avis(
      id: id,
      title: title,
      avisType: avisType,
      dateUpdate: dateUpdate,
      htmlURL: htmlURL,
    );
  }
}
