import 'package:MIPS/domain/domain.dart';
import 'package:MIPS/common/common.dart';

class UpdateCommentaireUseCase {
  final CommentaireRepository commentaireRepository;

  const UpdateCommentaireUseCase({
    required this.commentaireRepository,
  });

  Future<Result<Failure, Commentaire>> call(Commentaire commentaire) async {
    return commentaireRepository.updateCommentaire(commentaire);
  }
}
