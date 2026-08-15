part of 'demande_pub_bloc.dart';

enum Status {
  demandeSubmiting,
  errorSubmiting,
  doneSubmiting,
  none,
  loading,
  errorLoading,
  loaded
}

class DemandePubState {
  final List<ImageUpload> imagesAnnonceUpload;
  final Status status;
  final String idMenu;
  final List<AnnonceTarifOption> annonceTarif;
  final List<Menu> categoriesMenuParent;
  final int indexAnnonceTarifOptionSelected;
  final int indexTarifSelected;
  final String errorMessage;

  factory DemandePubState.initial() {
    return const DemandePubState(
        status: Status.none,
        idMenu: "0",
        imagesAnnonceUpload: [],
        indexAnnonceTarifOptionSelected: 0,
        indexTarifSelected: 0,
        categoriesMenuParent: [],
        errorMessage: "",
        annonceTarif: []);
  }

  const DemandePubState(
      {required this.imagesAnnonceUpload,
      required this.status,
      required this.idMenu,
      required this.categoriesMenuParent,
      required this.errorMessage,
      required this.indexAnnonceTarifOptionSelected,
      required this.indexTarifSelected,
      required this.annonceTarif});

  DemandePubState copyWith({
    List<ImageUpload>? imagesAnnonceUpload,
    Status? status,
    String? idMenu,
    AnnonceType? annonceType,
    List<Menu>? categoriesMenuParent,
    List<AnnonceTarifOption>? annonceTarif,
    int? indexAnnonceTarifOptionSelected,
    int? indexTarifSelected,
    String? errorMessage,
  }) {
    return DemandePubState(
      indexAnnonceTarifOptionSelected: indexAnnonceTarifOptionSelected ??
          this.indexAnnonceTarifOptionSelected,
      indexTarifSelected: indexTarifSelected ?? this.indexTarifSelected,
      imagesAnnonceUpload: imagesAnnonceUpload ?? this.imagesAnnonceUpload,
      status: status ?? this.status,
      idMenu: idMenu ?? this.idMenu,
      errorMessage: errorMessage ?? this.errorMessage,
      annonceTarif: annonceTarif ?? this.annonceTarif,
      categoriesMenuParent: categoriesMenuParent ?? this.categoriesMenuParent,
    );
  }
}
