part of 'my_menu_profil_bloc.dart';

sealed class MyMenuProfilEvent extends Equatable {
  const MyMenuProfilEvent();
  @override
  List<Object> get props => [];
}

class LoadUserMenuProfilEvent extends MyMenuProfilEvent {}

class DeleteAnnonceFromFavsEvent extends MyMenuProfilEvent {
  final int id;

  const DeleteAnnonceFromFavsEvent({
    required this.id,
  });
}

class DeleteMenuFromFavsEvent extends MyMenuProfilEvent {
  final int id;

  const DeleteMenuFromFavsEvent({
    required this.id,
  });
}

class LoadAnnoncesFavorisCount extends MyMenuProfilEvent {}

class LoadAnnoncesFavoris extends MyMenuProfilEvent {
  final int pageIndex;
  const LoadAnnoncesFavoris({required this.pageIndex});
}

class LoadMoreAnnoncesFavoris extends MyMenuProfilEvent {
  const LoadMoreAnnoncesFavoris();
}
