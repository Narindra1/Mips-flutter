import 'package:equatable/equatable.dart';

/// Entité représentant un commentaire d’annonce.
///
/// Contient :
/// - l’identifiant de l’annonce associée ([annonceID])
/// - l’identifiant unique du commentaire ([id])
/// - le contenu du commentaire ([content])
/// - le nom de l’auteur ([authorName])
/// - l’identifiant de l’auteur ([authorID])
/// - la date de création ([dateDeCreation])
/// - le nombre de likes ([likeCount])
/// - indique si l’utilisateur actuel a liké ce commentaire ([hasLike])

class Commentaire extends Equatable {
  final int annonceID;
  final int id;
  final String content;
  final String authorName;
  final String authorID;
  final String authorAvatarUrl;
  final String dateDeCreation;
  final int likeCount;
  final bool hasLike;

  const Commentaire({
    required this.annonceID,
    required this.id,
    required this.content,
    required this.authorName,
    required this.authorID,
    required this.authorAvatarUrl,
    required this.dateDeCreation,
    required this.likeCount,
    required this.hasLike,
  });

  @override
  List<Object> get props => [id, content, authorName, authorID];

  Commentaire copyWith({
    int? annonceID,
    int? id,
    String? content,
    String? authorName,
    String? authorID,
    String? authorAvatarUrl,
    String? dateDeCreation,
    int? likeCount,
    bool? hasLike,
  }) {
    return Commentaire(
      annonceID: annonceID ?? this.annonceID,
      id: id ?? this.id,
      content: content ?? this.content,
      authorName: authorName ?? this.authorName,
      authorID: authorID ?? this.authorID,
      authorAvatarUrl: authorAvatarUrl ?? this.authorAvatarUrl,
      dateDeCreation: dateDeCreation ?? this.dateDeCreation,
      likeCount: likeCount ?? this.likeCount,
      hasLike: hasLike ?? this.hasLike,
    );
  }

  @override
  String toString() {
    return "$id,$content,$authorName,$authorID,$authorAvatarUrl,$likeCount,$hasLike";
  }
}
