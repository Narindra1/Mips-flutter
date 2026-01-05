part of 'mes_annonces_screen_bloc.dart';

sealed class MesAnnoncesScreenEvent {
  const MesAnnoncesScreenEvent();
}

class LoadMesAnnoncesCount extends MesAnnoncesScreenEvent {}

class LoadMesAnnonces extends MesAnnoncesScreenEvent {
  final int pageIndex;
  const LoadMesAnnonces({required this.pageIndex});
}

class LoadMoreMesAnnonces extends MesAnnoncesScreenEvent {
  const LoadMoreMesAnnonces();
}
