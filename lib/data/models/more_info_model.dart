import 'package:mips/domain/entities/more_info.dart';

class MoreInfoModel {
  final int id;
  final String title;
  final String content;

  const MoreInfoModel({
    required this.id,
    required this.title,
    required this.content,
  });

  factory MoreInfoModel.fromJson(Map<String, dynamic> map) {
    return MoreInfoModel(
      id: map['id'] as int,
      title: map['titre'] as String,
      content: map['contenu'] as String,
    );
  }

  MoreInfo toEntity() {
    return MoreInfo(id: id, title: title, content: content);
  }
}
