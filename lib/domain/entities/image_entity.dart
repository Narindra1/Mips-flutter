import 'package:equatable/equatable.dart';

/// Entité représentant une image.
///
/// Contient :
/// - l’identifiant unique de l’image ([id])
/// - l’URL de l’image principale ([url])
/// - l’URL de la miniature ([urlMiniature])
class ImageEntity extends Equatable {
  final int id;
  final String url;
  final String urlMiniature;

  const ImageEntity({
    required this.id,
    required this.url,
    required this.urlMiniature,
  });

  @override
  List<Object> get props => [id, url, urlMiniature];

  @override
  String toString() {
    return 'ImageEntity{id: $id, url: $url, urlMiniature $urlMiniature}';
  }

  ImageEntity copyWith({
    int? id,
    String? url,
    String? urlMiniature,
  }) {
    return ImageEntity(
      id: id ?? this.id,
      url: url ?? this.url,
      urlMiniature: urlMiniature ?? this.urlMiniature,
    );
  }
}
