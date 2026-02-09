import 'package:MIPS/common/common.dart';
import 'package:MIPS/domain/domain.dart';
import 'package:MIPS/domain/entities/message.dart';
import 'package:MIPS/domain/entities/transaction_history.dart';

/// Interface pour la gestion des opérations liées à l’utilisateur.
///
/// Permet de :
/// - gérer l’authentification et l’inscription ([loginUser], [registerUser]),
/// - récupérer et mettre à jour les informations utilisateur ([getUserInfo], [updateUser]),
/// - changer ou réinitialiser le mot de passe ([changePassword], [resetPassword], [forgotPassword], [checkPassword]),
/// - effectuer un transfert de solde FAKA ([transfertFaka]),
/// - gérer la déconnexion et la suppression de compte ([logoutUser], [deleteUser]),
/// - récupérer les informations du profil utilisateur et des favoris ([getUserMenuProfil]),
/// - consulter les messages de l’utilisateur ([getUserMessages], [getAMessage]),
/// - consulter l’historique des transactions ([getTransactionHistory]).
///
/// Chaque méthode retourne un [Result] encapsulant un succès ou un [Failure]
/// en cas d'erreur réseau ou applicative.
abstract class UserRepository {
  Future<Result<Failure, User>> getUserInfo();

  Future<Result<Failure, SuccessResult>> deleteUser();

  Future<Result<Failure, SuccessResult>> logoutUser();

  Future<Result<Failure, User>> updateUser(User user);

  Future<Result<Failure, User>> transfertFaka(
      String phoneReceiver, int amount, String motif);

  Future<Result<Failure, SuccessResult>> checkPassword(String password);

  Future<Result<Failure, User>> loginUser(
      String login, String password, bool stayLogged);

  Future<Result<Failure, User>> registerUser(User user);

  Future<Result<Failure, User>> changePassword(
      String oldPassword, String newPassword);

  Future<Result<Failure, User>> resetPassword(
      String validationCode, String password);

  Future<Result<Failure, SuccessResult>> forgotPassword(String email);

  Future<Result<Failure, UserMenuProfil>> getUserMenuProfil();

  Future<Result<Failure, List<Message>>> getUserMessages(int page);

  Future<Result<Failure, SuccessResult>> viewUserMessage(int messageId);

  Future<Result<Failure, SuccessResult>> viewAllUserMessage();

  Future<Result<Failure, SuccessResult>> deleteAllUserMessage();

  Future<Result<Failure, SuccessResult>> deleteUserMessage(int messageId);

  Future<Result<Failure, int>> getUserUnreadMessageCount();

  Future<Result<Failure, List<TransactionHistory>>> getTransactionHistory(
      int page);
}
