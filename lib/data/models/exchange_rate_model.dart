import 'package:mips/data/models/devise_model.dart';
import 'package:mips/domain/entities/exchange_rate.dart';

class ExchangeRateModel {
  final List<DeviseModel> devises;
  final DateTime date;
  final String source;

  const ExchangeRateModel({
    required this.devises,
    required this.date,
    required this.source,
  });

  Map<String, dynamic> toJson() {
    return {
      'devises': devises.map((e) => e.toEntity()).toList(),
      'date': date.toString(),
      'source': source,
    };
  }

  factory ExchangeRateModel.fromJson(Map<String, dynamic> map) {
    List<dynamic> resultList = (map["devises"] as List<dynamic>);
    List<DeviseModel> deviseList = [];
    for (var e in resultList) {
      deviseList.add(DeviseModel.fromJson(e.keys.frist, e));
    }

    return ExchangeRateModel(
      devises: deviseList,
      date: map["date"] ?? DateTime.now(),
      source: map["source"] ?? "",
    );
  }

  ExchangeRate toEntity() {
    return ExchangeRate(
      devises: devises.map((e) => e.toEntity()).toList(),
      date: date,
      source: source,
    );
  }
}
