// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:mips/domain/entities/devise.dart';
import 'package:equatable/equatable.dart';

class ExchangeRate extends Equatable {
  final List<Devise> devises;
  final DateTime date;
  final String source;

  const ExchangeRate({
    required this.devises,
    required this.date,
    required this.source,
  });

  @override
  List<Object> get props => [devises, date, source];
}
