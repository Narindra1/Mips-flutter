import 'package:MIPS/common/utils/app_utils.dart';

/// Entité représentant un message utilisateur.
///
/// Contient :
/// - l’identifiant unique du message ([id])
/// - le titre du message ([title])
/// - le contenu du message ([content])
/// - la date d’envoi ([date])
/// - indique si le message a été lu ([isViewed])
class Message {
  final int id;
  final String title;
  final String content;
  final String date;
  final bool isViewed;

  const Message({
    required this.id,
    required this.title,
    required this.content,
    required this.date,
    required this.isViewed,
  });

  Message copyWith({
    int? id,
    String? title,
    String? content,
    String? date,
    bool? isViewed,
  }) {
    return Message(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      date: date ?? this.date,
      isViewed: isViewed ?? this.isViewed,
    );
  }

  String get formattedDate => AppUtils.formatDateMin(date);
}
