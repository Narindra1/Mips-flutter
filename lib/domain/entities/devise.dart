// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class Devise extends Equatable {
  final String change;
  final double value;

  const Devise({
    required this.change,
    required this.value,
  });

  @override
  List<Object> get props => [change, value];
}
