import 'package:mips/domain/entities/devise.dart';

class DeviseModel {
  final String change;
  final double value;

  const DeviseModel({required this.change, required this.value});

  Map<String, dynamic> toJson() {
    return {'change': change, 'value': value};
  }

  factory DeviseModel.fromJson(String change, Map<String, dynamic> map) {
    return DeviseModel(
      change: change,
      value: double.parse(map[change].toString()),
    );
  }

  Devise toEntity() {
    return Devise(change: change, value: value);
  }
}
