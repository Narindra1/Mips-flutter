part of 'follow_bloc.dart';

sealed class FollowEvent extends Equatable {
  const FollowEvent();

  @override
  List<Object> get props => [];
}

class LoadAnnonceListOfFollowedUsersCount extends FollowEvent {}

class LoadAnnonceListFollow extends FollowEvent {
  final int pageIndex;
  const LoadAnnonceListFollow({required this.pageIndex});
}

class LoadMoreListAnnonce extends FollowEvent {
  const LoadMoreListAnnonce();
}

class CheckFollowingEvent extends FollowEvent {
  const CheckFollowingEvent({required this.id});
  final int id;
}

class FollowUserEvent extends FollowEvent {
  const FollowUserEvent({required this.id});
  final int id;
}

class UnFollowUserEvent extends FollowEvent {
  const UnFollowUserEvent({required this.id});
  final int id;
}

class FollowersLoadedEvent extends FollowEvent {
  const FollowersLoadedEvent();
}

class FollowingLoadedEvent extends FollowEvent {
  const FollowingLoadedEvent();
}

// class AnnoncesFollowedEvent extends FollowEvent {
//   const AnnoncesFollowedEvent({
//     required this.page,
//     required this.query,
//   });
//   final int page;
//   final String query;
// }
