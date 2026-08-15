part of 'exchange_rate_bloc.dart';

enum Status { loading, loaded, error }

final class ExchangeRateState extends Equatable {
  const ExchangeRateState({
    required this.devise,
    required this.date,
    required this.source,
    required this.status,
    required this.error,
  });
  final List<Devise> devise;
  final DateTime date;
  final String source;
  final Status status;
  final String error;

  ExchangeRateState copyWith({
    List<Devise>? devise,
    DateTime? date,
    String? source,
    Status? status,
    String? error,
  }) {
    return ExchangeRateState(
      devise: devise ?? this.devise,
      date: date ?? this.date,
      source: source ?? this.source,
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }

  @override
  List<Object> get props => [devise, status, error, date, source];
}
