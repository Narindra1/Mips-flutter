import 'package:MIPS/domain/domain.dart';

import '../../../common/common.dart';

class GetCommentaireByAnnonceUseCase {
  final CommentaireRepository commentaireRepository;

  const GetCommentaireByAnnonceUseCase({
    required this.commentaireRepository,
  });

  Future<Result<Failure, List<Commentaire>>> call(
      String annonceID, int page) async {
    return commentaireRepository.getCommentairesByAnnonce(annonceID, page);
  }
}
