import 'package:mips/domain/domain.dart';

/// Modèle représentant l'historique d'une transaction.
///
/// Champs :
/// - [id] : identifiant unique de la transaction.
/// - [idSender] : identifiant de l'expéditeur.
/// - [isIncome] : indique s'il s'agit d'un revenu (true) ou d'une dépense (false).
/// - [numSender] : numéro de téléphone ou identifiant de l'expéditeur.
/// - [idReceiver] : identifiant du destinataire.
/// - [numReceiver] : numéro de téléphone ou identifiant du destinataire.
/// - [montantFaka] : montant de la transaction.
/// - [type] : type de la transaction.
/// - [slug] : id de l'annonce.
/// - [message] : message ou note associée à la transaction.
/// - [date] : date de la transaction.
class TransactionHistoryModel {
  final int id;
  final int idSender;
  final bool isIncome;
  final String numSender;
  final int idReceiver;
  final String numReceiver;
  final int montantFaka;
  final String type;
  final String slug;
  final String message;
  final String date;

  const TransactionHistoryModel({
    required this.id,
    required this.idSender,
    required this.numSender,
    required this.idReceiver,
    required this.numReceiver,
    required this.montantFaka,
    required this.type,
    required this.slug,
    required this.isIncome,
    required this.message,
    required this.date,
  });

  factory TransactionHistoryModel.fromJson(Map<String, dynamic> json) {
    int idSender = 0;
    String numSender = "";
    int idReceiver = 0;
    String numReceiver = "";
    String slug = "";

    if (json['auteur_basic'] != null) {
      idSender = (json['auteur_basic'])['id'] ?? 0;
      numSender = (json['auteur_basic'])['phone'] ?? "";
    }

    if (json['beneficiaire_basic'] != null) {
      idReceiver = (json['beneficiaire_basic'])['id'] ?? 0;
      numReceiver = (json['beneficiaire_basic'])['phone'] ?? "";
    }

    if (json['data'] != null) {
      slug = (json['data'])['annonceSlug'] ?? "";
    }

    return TransactionHistoryModel(
      id: json['id'],
      idSender: idSender,
      numSender: numSender,
      idReceiver: idReceiver,
      numReceiver: numReceiver,
      montantFaka: json['montant'],
      isIncome: json['isIncome'],
      type: json['type'] as String,
      slug: slug,
      message: json['message'] as String,
      date: json['created_at'] as String,
    );
  }

  /// Si idSender ou idReceiver est 0; c'est envoyé par l'administration
  TransactionHistory toEntity() {
    return TransactionHistory(
      id: id,
      idSender: idSender,
      isIncome: isIncome,
      numSender: idSender == 0 ? "Administration" : numSender,
      idReceiver: idReceiver,
      numReceiver: idReceiver == 0 ? "Administration" : numReceiver,
      montantFaka: montantFaka,
      slug: slug,
      type: type,
      message: message,
      date: date,
    );
  }
}
