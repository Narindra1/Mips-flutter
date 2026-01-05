import 'package:MIPS/domain/entities/image_entity.dart';
import 'package:get_it/get_it.dart';

import '../../common/services/environment_wrapper.dart';

/// Model pour les image
class ImageModel {
  final int id;
  final String url;
  final String urlMiniature;

  const ImageModel(
      {required this.id, required this.url, required this.urlMiniature});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'url': url,
    };
  }

  factory ImageModel.fromJson(Map<String, dynamic> map) {
    return ImageModel(
      id: map['id'] as int,
      url:
          GetIt.instance<EnvironmentWrapper>().baseUrl + (map['url'] as String),
      urlMiniature: GetIt.instance<EnvironmentWrapper>().baseUrl +
          (map['url_min'] as String),
    );
  }

  factory ImageModel.fromEntity(ImageEntity image) {
    return ImageModel(
        id: image.id, url: image.url, urlMiniature: image.urlMiniature);
  }

  ImageEntity toEntity() {
    return ImageEntity(id: id, url: url, urlMiniature: urlMiniature);
  }
}
