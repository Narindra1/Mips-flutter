part of 'follow_bloc.dart';

enum AnnoncesOfFollowedUsersCountStatus { loading, loaded, error }

enum FollowUserStatus { loading, loaded, error }

enum UnFollowUserStatus { loading, loaded, error }

enum IsFollowingStatus { loading, loaded, error }

enum FollowersStatus { loading, loaded, error }

enum FollowingStatus { loading, loaded, error }

enum AnnoncesFollowedStatus { loading, loaded, error }

class FollowState extends Equatable {
  const FollowState({
    required this.annoncesOfFollowedUsersCount,
    required this.isFollowing,
    required this.myFollowers,
    required this.myFollowings,
    required this.annoncesOfFollowedUsers,
    required this.isNextListAvailable,
    required this.unFollowUserStatus,
    required this.followUserStatus,
    required this.isFollowingStatus,
    required this.followersStatus,
    required this.followingStatus,
    required this.annoncesFollowedStatus,
    required this.annoncesOfFollowedUsersCountStatus,
  });
  final int annoncesOfFollowedUsersCount;
  final bool isFollowing;
  final List<User> myFollowers;
  final List<User> myFollowings;
  final List<Annonce> annoncesOfFollowedUsers;
  final bool isNextListAvailable;
  final UnFollowUserStatus unFollowUserStatus;
  final FollowUserStatus followUserStatus;
  final IsFollowingStatus isFollowingStatus;
  final FollowersStatus followersStatus;
  final FollowingStatus followingStatus;
  final AnnoncesFollowedStatus annoncesFollowedStatus;
  final AnnoncesOfFollowedUsersCountStatus annoncesOfFollowedUsersCountStatus;

  factory FollowState.initial() {
    return FollowState(
      annoncesOfFollowedUsersCount: 0,
      isFollowing: false,
      myFollowers: [],
      myFollowings: [],
      annoncesOfFollowedUsers: [],
      isNextListAvailable: false,
      unFollowUserStatus: UnFollowUserStatus.loading,
      followUserStatus: FollowUserStatus.loading,
      isFollowingStatus: IsFollowingStatus.loading,
      followersStatus: FollowersStatus.loading,
      followingStatus: FollowingStatus.loading,
      annoncesFollowedStatus: AnnoncesFollowedStatus.loading,
      annoncesOfFollowedUsersCountStatus:
          AnnoncesOfFollowedUsersCountStatus.loading,
    );
  }

  FollowState copyWith({
    int? annoncesOfFollowedUsersCount,
    bool? isFollowing,
    List<User>? myFollowers,
    List<User>? myFollowings,
    List<Annonce>? annoncesOfFollowedUsers,
    bool? isNextListAvailable,
    FollowUserStatus? followUserStatus,
    UnFollowUserStatus? unFollowUserStatus,
    IsFollowingStatus? isFollowingStatus,
    FollowersStatus? followersStatus,
    FollowingStatus? followingStatus,
    AnnoncesFollowedStatus? annoncesFollowedStatus,
    AnnoncesOfFollowedUsersCountStatus? annoncesOfFollowedUsersCountStatus,
  }) {
    return FollowState(
      annoncesOfFollowedUsersCount:
          annoncesOfFollowedUsersCount ?? this.annoncesOfFollowedUsersCount,
      isFollowing: isFollowing ?? this.isFollowing,
      myFollowers: myFollowers ?? this.myFollowers,
      myFollowings: myFollowings ?? this.myFollowings,
      annoncesOfFollowedUsers:
          annoncesOfFollowedUsers ?? this.annoncesOfFollowedUsers,
      isNextListAvailable: isNextListAvailable ?? this.isNextListAvailable,
      unFollowUserStatus: unFollowUserStatus ?? this.unFollowUserStatus,
      followUserStatus: followUserStatus ?? this.followUserStatus,
      isFollowingStatus: isFollowingStatus ?? this.isFollowingStatus,
      followersStatus: followersStatus ?? this.followersStatus,
      followingStatus: followingStatus ?? this.followingStatus,
      annoncesFollowedStatus:
          annoncesFollowedStatus ?? this.annoncesFollowedStatus,
      annoncesOfFollowedUsersCountStatus: annoncesOfFollowedUsersCountStatus ??
          this.annoncesOfFollowedUsersCountStatus,
    );
  }

  @override
  List<Object> get props => [
        annoncesOfFollowedUsersCount,
        isFollowing,
        myFollowers,
        myFollowings,
        annoncesOfFollowedUsers,
        unFollowUserStatus,
        isNextListAvailable,
        followUserStatus,
        isFollowingStatus,
        followersStatus,
        followingStatus,
        annoncesFollowedStatus,
        annoncesOfFollowedUsersCountStatus,
      ];
}
