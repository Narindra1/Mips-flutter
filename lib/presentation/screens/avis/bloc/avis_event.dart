part of 'avis_bloc.dart';

@immutable
sealed class AvisEvent {}

class LoadListEvent extends AvisEvent {}

class LoadAnAvisEvent extends AvisEvent {
  final int id;

  LoadAnAvisEvent({
    required this.id,
  });
}
