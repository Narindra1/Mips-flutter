part of 'demande_pub_bloc.dart';

@immutable
sealed class DemandePubEvent {}

class AddImageEvent extends DemandePubEvent {
  final String path;

  AddImageEvent({
    this.path = "",
  });
}

class InitBloc extends DemandePubEvent {
  final String idMenu;
  final AnnonceBloc? annonceBLoc;
  final bool modeVIPOnly;
  final bool modeExtendValidity;

  InitBloc(
      {required this.idMenu,
      this.annonceBLoc,
      this.modeVIPOnly = false,
      this.modeExtendValidity = false});
}

class InitComplainBloc extends DemandePubEvent {
  final String idMenu;

  InitComplainBloc({required this.idMenu});
}

class ReorderImageEvent extends DemandePubEvent {
  final int oldIndex;
  final int newIndex;

  ReorderImageEvent(
    this.oldIndex,
    this.newIndex,
  );
}

class InitBlocPartenaireSponsor extends DemandePubEvent {
  final String idMenu;
  final AnnonceType annonceType;

  InitBlocPartenaireSponsor({required this.idMenu, required this.annonceType});
}

class RemoveImageEvent extends DemandePubEvent {
  final int index;

  RemoveImageEvent(this.index);
}

class SubmitFormEvent extends DemandePubEvent {
  final String title;
  final String descriptionCourte;
  final String descriptionDetaillee;
  final String emplacement;
  final String contact;
  final String idMenu;
  final String titleMenu;
  final String idAnnonce;
  final String parrain;

  SubmitFormEvent({
    required this.idAnnonce,
    required this.title,
    required this.descriptionCourte,
    required this.descriptionDetaillee,
    required this.emplacement,
    required this.contact,
    required this.idMenu,
    required this.parrain,
    required this.titleMenu,
  });
}

class SubmitPlainteFormEvent extends DemandePubEvent {
  final String title;
  final String descriptionCourte;
  final String descriptionDetaillee;
  final String emplacement;
  final String contact;
  final String idMenu;
  final String titleMenu;
  final String idAnnonce;
  final String parrain;

  SubmitPlainteFormEvent({
    required this.idAnnonce,
    required this.title,
    required this.descriptionCourte,
    required this.descriptionDetaillee,
    required this.emplacement,
    required this.contact,
    required this.idMenu,
    required this.parrain,
    required this.titleMenu,
  });
}

class ExtendValidityEvent extends DemandePubEvent {}

class AnnonceTypeChangeEvent extends DemandePubEvent {
  final AnnonceType annonceType;

  AnnonceTypeChangeEvent({
    required this.annonceType,
  });
}

class AnnonceTarifSelectEvent extends DemandePubEvent {
  final int index;

  AnnonceTarifSelectEvent({
    required this.index,
  });
}

class AnnonceTarifOptionSelectEvent extends DemandePubEvent {
  final int index;

  AnnonceTarifOptionSelectEvent({
    required this.index,
  });
}
