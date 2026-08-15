import 'package:mips/common/services/environment_wrapper.dart';
import 'package:mips/domain/entities/avatar.dart';
import 'package:get_it/get_it.dart';

/// Model pour le Avatar
class AvatarModel {
  final int id;
  final int priceEnFaka;
  final int priceEnAriary;
  final String urlImage;
  final String localImage;

  const AvatarModel({
    required this.id,
    required this.priceEnFaka,
    required this.urlImage,
    required this.priceEnAriary,
    required this.localImage,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'faka': priceEnFaka,
      'urlImage': urlImage,
      'localImage': localImage,
    };
  }

  factory AvatarModel.fromJson(Map<String, dynamic> map) {
    return AvatarModel(
      id: map['id'] ?? 0,
      priceEnFaka: map['faka'] ?? 0,
      priceEnAriary: map['montant'] ?? 0,
      urlImage:
          GetIt.instance<EnvironmentWrapper>().baseUrl + (map['image'] ?? ""),
      localImage: map['localImage'] ?? "",
    );
  }

  Avatar toEntity() {
    return Avatar(
      id: id,
      priceEnFaka: priceEnFaka,
      priceFakaAriary: priceEnAriary,
      urlImage: urlImage,
      localImage: localImage,
    );
  }
}
