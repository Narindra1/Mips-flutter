/// Entité représentant une transaction effectuée par l'utilisateur.
///
/// Contient :
/// - l’identifiant de la transaction ([id])
/// - l’identifiant de l’expéditeur ([idSender])
/// - type de transaction : revenu ou dépense ([isIncome])
/// - numéro de l’expéditeur ([numSender])
/// - identifiant du destinataire ([idReceiver])
/// - numéro du destinataire ([numReceiver])
/// - montant en KARA transféré ([montantFaka])
/// - type de transaction ([type])
/// - message associé à la transaction ([message])
/// - date de la transaction ([date])
class TransactionHistory {
  final int id;
  final int idSender;
  final bool isIncome;
  final String numSender;
  final int idReceiver;
  final String numReceiver;
  final int montantFaka;
  final String type;
  final String message;
  final String date;

  const TransactionHistory({
    required this.id,
    required this.idSender,
    required this.numSender,
    required this.idReceiver,
    required this.numReceiver,
    required this.montantFaka,
    required this.type,
    required this.message,
    required this.isIncome,
    required this.date,
  });
}
