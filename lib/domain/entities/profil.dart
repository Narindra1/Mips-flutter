import 'package:MIPS/domain/domain.dart';
import 'package:equatable/equatable.dart';

class Profil extends Equatable {
  const Profil({
    required this.user,
    required this.followers,
    required this.followings,
    required this.annonces,
  });
  final User user;
  final List<User> followings;
  final List<User> followers;
  final List<Annonce> annonces;

  @override
  List<Object> get props => [user, followings, followers, annonces];
}
