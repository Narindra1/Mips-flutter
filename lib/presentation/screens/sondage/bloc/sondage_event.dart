part of 'sondage_bloc.dart';

@immutable
sealed class SondageEvent {}

class LoadSondagelistEvent extends SondageEvent {}

class SubmitSondageEvent extends SondageEvent {
  final int optionSelected;
  final int sondageId;

  SubmitSondageEvent({
    required this.optionSelected,
    required this.sondageId,
  });
}
