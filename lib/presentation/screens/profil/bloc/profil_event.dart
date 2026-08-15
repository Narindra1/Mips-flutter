part of 'profil_bloc.dart';

sealed class ProfilEvent extends Equatable {
  const ProfilEvent();

  @override
  List<Object> get props => [];
}

class UserProfilLoaded extends ProfilEvent {
  const UserProfilLoaded({required this.id});
  final int id;
}

class AnnonceListUserProfilLoaded extends ProfilEvent {
  const AnnonceListUserProfilLoaded({
    required this.id,
    required this.pageIndex,
    required this.query,
  });
  final int id;
  final int pageIndex;
  final String query;
}

class LoadMoreAnnonceUserProfil extends ProfilEvent {
  const LoadMoreAnnonceUserProfil({required this.id});
  final int id;
}

class AnnonceListUserProfilCountLoaded extends ProfilEvent {
  const AnnonceListUserProfilCountLoaded({required this.id});
  final int id;
}
