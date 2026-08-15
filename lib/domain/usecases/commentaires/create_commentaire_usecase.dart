import 'package:mips/domain/domain.dart';

import '../../../common/common.dart';

class CreateCommentaireUseCase {
  final CommentaireRepository commentaireRepository;

  const CreateCommentaireUseCase({required this.commentaireRepository});

  Future<Result<Failure, Commentaire>> call(
    int idAnnonce,
    String content,
  ) async {
    return commentaireRepository.createCommentaire(idAnnonce, content);
  }
}
