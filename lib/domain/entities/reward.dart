import 'package:MIPS/common/constants/constant.dart';
import 'package:equatable/equatable.dart';

class Reward extends Equatable {
  const Reward({
    required this.rewardType,
    required this.amount,
    required this.counts,
    required this.counted,
    required this.annonceClickedList,
    required this.sondageRespondedList,
  });
  final RewardType rewardType;
  final int amount;
  final int counts;
  final int counted;
  final List<AnnonceClicked> annonceClickedList;
  final List<SondageResponded> sondageRespondedList;

  @override
  List<Object> get props => [
        rewardType,
        amount,
        counts,
        counted,
        annonceClickedList,
        sondageRespondedList,
      ];
}

class AnnonceClicked extends Equatable {
  const AnnonceClicked({
    required this.id,
    required this.slug,
    required this.type,
    required this.menu,
  });
  final int id;
  final String slug;
  final String type;
  final String menu;

  @override
  List<Object> get props => [id, slug, type, menu];
}

class SondageResponded extends Equatable {
  const SondageResponded({
    required this.id,
    required this.question,
  });
  final int id;
  final String question;

  @override
  List<Object> get props => [id, question];
}
