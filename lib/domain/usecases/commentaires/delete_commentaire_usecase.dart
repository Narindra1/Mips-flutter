import 'package:MIPS/domain/domain.dart';
import 'package:MIPS/common/common.dart';

class DeleteCommentaireUseCase {
  final CommentaireRepository commentaireRepository;

  const DeleteCommentaireUseCase({
    required this.commentaireRepository,
  });

  Future<Result<Failure, SuccessResult>> call(int id, int annonceID) async {
    return commentaireRepository.deleteCommentaire(
        id.toString(), annonceID.toString());
  }
}
