part of 'avatar_bloc.dart';

@immutable
sealed class AvatarEvent {}

class LoadAvatarListEvent extends AvatarEvent {}

class BuyAvatarEvent extends AvatarEvent {
  final int id;
  final int number;
  final String moyenDePaiement;

  BuyAvatarEvent(
      {required this.id, required this.number, required this.moyenDePaiement});
}

class SelectedAvatarEvent extends AvatarEvent {
  final int id;

  SelectedAvatarEvent({
    required this.id,
  });
}
