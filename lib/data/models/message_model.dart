import 'package:mips/domain/domain.dart';

/// Modèle représentant un message de l'application.
///
/// Champs :
/// - [id] : identifiant unique du message.
/// - [title] : titre du message.
/// - [content] : contenu du message.
/// - [date] : date d'envoi  du message (au format String).
/// - [isViewed] : indique si le message a été consulté par l'utilisateur.

class MessageModel {
  final int id;
  final String title;
  final String content;
  final String date;
  final bool isViewed;

  const MessageModel({
    required this.id,
    required this.title,
    required this.content,
    required this.date,
    required this.isViewed,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'titre': title,
      'body': content,
      'created_at': date,
      'isread': isViewed,
    };
  }

  factory MessageModel.fromJson(Map<String, dynamic> map) {
    return MessageModel(
      id: map['id'] as int,
      title: map['titre'] as String,
      content: map['body'] as String,
      date: map['created_at'] as String,
      isViewed: map['isread'] as bool,
    );
  }

  Message toEntity() {
    return Message(
      id: id,
      content: content,
      date: date,
      isViewed: isViewed,
      title: title,
    );
  }

  factory MessageModel.fromEntity(Message message) {
    return MessageModel(
      id: message.id,
      content: message.content,
      date: message.date,
      isViewed: message.isViewed,
      title: message.title,
    );
  }
}
