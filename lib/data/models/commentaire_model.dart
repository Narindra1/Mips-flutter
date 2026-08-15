import 'package:mips/common/services/environment_wrapper.dart';
import 'package:mips/domain/domain.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';

/// Model pour le commentaire
class CommentaireModel extends Equatable {
  final int id;
  final int annonceID;
  final String content;
  final String authorName;
  final int authorID;
  final String authorAvatarUrl;
  final String dateDeCreation;
  final int likeCount;
  final bool hasLike;

  const CommentaireModel({
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

  factory CommentaireModel.fromJson(Map<String, dynamic> json) {
    String authorName = "User1";
    int authorID = 0;
    String authorAvatarUrl = "";

    if (json["auteur_basic"] != null) {
      authorName = (json["auteur_basic"])["pseudo"] ?? "User1";
      authorID = (json["auteur_basic"])["id"] ?? 0;
      authorAvatarUrl = (json["auteur_basic"])["avatarUrl"] ?? "";
    }
    return CommentaireModel(
      annonceID: json["annonce_id"] ?? 0,
      id: json["id"] ?? 0,
      content: json["contenu"] ?? "",
      authorName: authorName,
      authorID: authorID,
      authorAvatarUrl:
          GetIt.instance<EnvironmentWrapper>().baseUrl + authorAvatarUrl,
      dateDeCreation: json["created_at"] ?? "",
      likeCount: json["reactions_count"] ?? 0,
      hasLike: json["hasLike"] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {'contenu': content, 'hasLike': hasLike};
  }

  Commentaire toEntity() {
    return Commentaire(
      annonceID: annonceID,
      id: id,
      content: content,
      authorName: authorName,
      authorID: authorID.toString(),
      authorAvatarUrl: authorAvatarUrl,
      hasLike: hasLike,
      dateDeCreation: dateDeCreation,
      likeCount: likeCount,
    );
  }

  factory CommentaireModel.fromEntity(Commentaire commentaire) {
    return CommentaireModel(
      annonceID: commentaire.annonceID,
      id: commentaire.id,
      content: commentaire.content,
      authorName: commentaire.authorName,
      authorID: int.parse(commentaire.authorID),
      authorAvatarUrl: commentaire.authorAvatarUrl,
      likeCount: commentaire.likeCount,
      dateDeCreation: commentaire.dateDeCreation,
      hasLike: commentaire.hasLike,
    );
  }

  @override
  List<Object> get props => [
    id,
    content,
    authorName,
    authorID,
    authorAvatarUrl,
  ];

  CommentaireModel copyWith({
    int? id,
    String? content,
    String? authorName,
    int? authorID,
    String? authorAvatarUrl,
    String? dateDeCreation,
    int? likeCount,
    bool? hasLike,
  }) {
    return CommentaireModel(
      annonceID: annonceID,
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
}
