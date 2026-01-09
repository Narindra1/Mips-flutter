import 'package:MIPS/common/common.dart';
import 'package:MIPS/domain/domain.dart';
import 'package:MIPS/domain/usecases/annonces/create_annonce_plainte_suggestion_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

import '../../../bloc/annonce_bloc.dart';

part 'demande_pub_event.dart';

part 'demande_pub_state.dart';

class DemandePubBloc extends Bloc<DemandePubEvent, DemandePubState> {
  final UploadImageAnnonceUseCase uploadImageAnnonceUseCase;
  final UpdateAnnonceUseCase updateAnnonceUseCase;
  final CreateAnnonceUseCase createAnnonceUseCase;
  final CreateAnnoncePlainteSuggestionUsecase
      createAnnoncePlainteSuggestionUsecase;
  final GetParentMenuScreenUseCase getParentScreenUseCase;
  final GetMenuTarifOptionsUseCase getMenuTarifOptionsUseCase;
  final ExtendValidityAnnonceUsecase extendValidityAnnonceUsecase;

  final ImagePicker _picker = ImagePicker();
  late final AnnonceBloc? annonceBloc;
  bool isEditMode = false;

  DemandePubBloc(
      {required this.uploadImageAnnonceUseCase,
      required this.createAnnonceUseCase,
      required this.createAnnoncePlainteSuggestionUsecase,
      required this.updateAnnonceUseCase,
      required this.getMenuTarifOptionsUseCase,
      required this.extendValidityAnnonceUsecase,
      required this.getParentScreenUseCase})
      : super(DemandePubState.initial()) {
    on<AnnonceTypeChangeEvent>(
      (event, emit) {
        emit(state.copyWith(annonceType: event.annonceType));
      },
    );
    on<AnnonceTarifSelectEvent>(
      (event, emit) {
        emit(state.copyWith(
            indexTarifSelected: event.index,
            indexAnnonceTarifOptionSelected: 0));
      },
    );
    on<AnnonceTarifOptionSelectEvent>(
      (event, emit) {
        emit(state.copyWith(indexAnnonceTarifOptionSelected: event.index));
      },
    );
    on<ReorderImageEvent>(_onReorderImage);
    // on<AddImageEvent>((event, emit) async {
    //   if (state.imagesAnnonceUpload.length >= maxImageAnnonceNumber) return;

    //   // ================= IMAGE DE LA GALERIE =================
    //   if (event.path == "") {
    //     final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    //     if (pickedFile == null) return;

    //     double fileSize = (await pickedFile.length()) / (1024 * 1024);

    //     ImageUpload imageUpload = ImageUpload(
    //       imageEntity: const ImageEntity(id: 0, url: "", urlMiniature: ""),
    //       cancelUploadToken: CancelToken(),
    //       imageSize: fileSize,
    //       status: ImageUploadStatus.uploading,
    //       uploadProgress: 0.0,
    //     );

    //     // ✅ CLONAGE DE LA LISTE
    //     final newImages = List<ImageUpload>.from(state.imagesAnnonceUpload);
    //     newImages.add(imageUpload);

    //     emit(state.copyWith(imagesAnnonceUpload: newImages));

    //     var result = await uploadImageAnnonceUseCase(
    //       File(pickedFile.path),
    //       state.idMenu,
    //       (progress) {
    //         imageUpload.uploadProgress = progress;

    //         // ✅ NOUVELLE RÉFÉRENCE
    //         emit(state.copyWith(
    //           imagesAnnonceUpload:
    //               List<ImageUpload>.from(state.imagesAnnonceUpload),
    //         ));
    //       },
    //       imageUpload.cancelUploadToken,
    //     );

    //     if (result.isSuccess()) {
    //       imageUpload.imageEntity = result.getSuccess()!;
    //       imageUpload.status = ImageUploadStatus.uploaded;
    //     } else {
    //       imageUpload.status = ImageUploadStatus.error;
    //     }

    //     emit(state.copyWith(
    //       imagesAnnonceUpload:
    //           List<ImageUpload>.from(state.imagesAnnonceUpload),
    //     ));
    //   }

    //   // ================= IMAGE PAR DÉFAUT =================
    //   else {
    //     final bytes = await rootBundle.load(event.path);
    //     final file = File(
    //         '${(await getTemporaryDirectory()).path}/${event.path.split('/').last}')
    //       ..writeAsBytesSync(bytes.buffer.asUint8List());

    //     double fileSize = await file.length() / (1024 * 1024);

    //     ImageUpload imageUpload = ImageUpload(
    //       imageEntity: const ImageEntity(id: 0, url: "", urlMiniature: ""),
    //       cancelUploadToken: CancelToken(),
    //       imageSize: fileSize,
    //       status: ImageUploadStatus.uploading,
    //       uploadProgress: 0.0,
    //     );

    //     final newImages = List<ImageUpload>.from(state.imagesAnnonceUpload);
    //     newImages.add(imageUpload);

    //     emit(state.copyWith(imagesAnnonceUpload: newImages));

    //     var result = await uploadImageAnnonceUseCase(
    //       file,
    //       state.idMenu,
    //       (progress) {
    //         imageUpload.uploadProgress = progress;
    //         emit(state.copyWith(
    //           imagesAnnonceUpload:
    //               List<ImageUpload>.from(state.imagesAnnonceUpload),
    //         ));
    //       },
    //       imageUpload.cancelUploadToken,
    //     );

    //     if (result.isSuccess()) {
    //       imageUpload.imageEntity = result.getSuccess()!;
    //       imageUpload.status = ImageUploadStatus.uploaded;
    //     } else {
    //       imageUpload.status = ImageUploadStatus.error;
    //     }

    //     emit(state.copyWith(
    //       imagesAnnonceUpload:
    //           List<ImageUpload>.from(state.imagesAnnonceUpload),
    //     ));
    //   }
    // });
    // THE FIRST
    on<AddImageEvent>((event, emit) async {
      if (state.imagesAnnonceUpload.length < maxImageAnnonceNumber) {
        if (event.path == "") {
          final pickedFile =
              await _picker.pickImage(source: ImageSource.gallery);
          if (pickedFile != null) {
            double fileSize = (await pickedFile.length()) / (1024 * 1024);
            ImageUpload imageUpload = ImageUpload(
                imageEntity:
                    const ImageEntity(id: 0, url: "", urlMiniature: ""),
                cancelUploadToken: CancelToken(),
                imageSize: fileSize,
                status: ImageUploadStatus.uploading,
                uploadProgress: 0.0);
            emit(state.copyWith(
                imagesAnnonceUpload: state.imagesAnnonceUpload
                  ..add(imageUpload)));
            var result = await uploadImageAnnonceUseCase(
              File(pickedFile.path),
              state.idMenu,
              (progress) {
                AppUtils.showDebugLog(
                    runtimeType, "on progress Image Upload: $progress");
                imageUpload.uploadProgress = progress;
                emit(state.copyWith(
                    imagesAnnonceUpload: state.imagesAnnonceUpload));
              },
              imageUpload.cancelUploadToken,
            );

            if (result.isSuccess()) {
              imageUpload.imageEntity = result.getSuccess()!;
              imageUpload.status = ImageUploadStatus.uploaded;
              AppUtils.showDebugLog(
                  runtimeType, imageUpload.imageEntity.toString());

              emit(state.copyWith(
                  imagesAnnonceUpload: state.imagesAnnonceUpload));
            } else {
              imageUpload.status = ImageUploadStatus.error;
              AppUtils.showDebugLog(
                  runtimeType, imageUpload.imageEntity.toString());
              emit(state.copyWith(
                  imagesAnnonceUpload: state.imagesAnnonceUpload));
            }
          }
        } else {
          final bytes = await rootBundle.load(event.path);
          final file = File(
              '${(await getTemporaryDirectory()).path}/${event.path.split('/').last}')
            ..writeAsBytesSync(bytes.buffer.asUint8List());

          double fileSize = await file.length() / (1024 * 1024);

          ImageUpload imageUpload = ImageUpload(
            imageEntity: const ImageEntity(id: 0, url: "", urlMiniature: ""),
            cancelUploadToken: CancelToken(),
            imageSize: fileSize,
            status: ImageUploadStatus.uploading,
            uploadProgress: 0.0,
          );

          emit(state.copyWith(
            imagesAnnonceUpload: state.imagesAnnonceUpload..add(imageUpload),
          ));

          var result = await uploadImageAnnonceUseCase(
            file,
            state.idMenu,
            (progress) {
              AppUtils.showDebugLog(
                  runtimeType, "on progress Image Upload: $progress");
              imageUpload.uploadProgress = progress;
              emit(state.copyWith(
                  imagesAnnonceUpload: state.imagesAnnonceUpload));
            },
            imageUpload.cancelUploadToken,
          );

          if (result.isSuccess()) {
            imageUpload.imageEntity = result.getSuccess()!;
            imageUpload.status = ImageUploadStatus.uploaded;
          } else {
            imageUpload.status = ImageUploadStatus.error;
          }

          emit(state.copyWith(imagesAnnonceUpload: state.imagesAnnonceUpload));
        }
      }
    });
    // on<RemoveImageEvent>((event, emit) {
    //   final newImages = List<ImageUpload>.from(state.imagesAnnonceUpload);
    //   try {
    //     if (newImages[event.index].status == ImageUploadStatus.uploading) {
    //       newImages[event.index].cancelUploadToken.cancel();
    //     }
    //   } catch (_) {
    //     AppUtils.showDebugLog(runtimeType, "Error canceling upload image");
    //   }
    //   newImages.removeAt(event.index);
    //   emit(state.copyWith(imagesAnnonceUpload: newImages));
    // });
    // THE FIRST
    on<RemoveImageEvent>((event, emit) {
      // Cancel upload operation if uploading;
      try {
        if (state.imagesAnnonceUpload[event.index].status ==
            ImageUploadStatus.uploading) {
          state.imagesAnnonceUpload[event.index].cancelUploadToken.cancel();
        }
      } catch (e) {
        AppUtils.showDebugLog(runtimeType, "Error canceling upload image");
      }
      emit(state.copyWith(
          imagesAnnonceUpload: state.imagesAnnonceUpload
            ..removeAt(event.index)));
    });

    on<InitBloc>((event, emit) async {
      /// Récupère l’arborescence des menus à partir de `categoriesInit`.
      /// Utile pour afficher la hiérarchie des menus /catégories courantes.
      if (int.parse(event.idMenu) > 0) {
        emit(state.copyWith(status: Status.loading));
        annonceBloc = event.annonceBLoc;

        ///  Récupère les info du menu parents
        var result = await getParentScreenUseCase(event.idMenu);

        int indexAnnonceTarif = 0;
        List<ImageUpload> imageUploads = [];
        if (annonceBloc != null && annonceBloc!.state.selectedAnnonce != null) {
          isEditMode = true;
          AnnonceType annonceType =
              annonceBloc!.state.selectedAnnonce!.annonceType;
          if (state.annonceTarif.isNotEmpty) {
            for (int j = 0; j < state.annonceTarif.length; j++) {
              if (state.annonceTarif[j].annonceType == annonceType) {
                indexAnnonceTarif = j;
              }
            }
          }
          for (var img in annonceBloc!.state.selectedAnnonce!.photos) {
            if (img.id > 0) {
              imageUploads.add(ImageUpload(
                  status: ImageUploadStatus.uploaded,
                  cancelUploadToken: CancelToken(),
                  imageEntity: img,
                  imageSize: 0,
                  uploadProgress: 0));
            }
          }
        }

        ///  Récupère les info des tarifs
        var resultInfotarif = await getMenuTarifOptionsUseCase(event.idMenu);
        if (result.isError() || resultInfotarif.isError()) {
          emit(state.copyWith(status: Status.errorLoading));
        } else {
          List<AnnonceTarifOption> tarifsOption = [];
          for (int i = 0; i < resultInfotarif.getSuccess()!.length; i++) {
            // Si Mode prolongement de validité
            if (event.modeExtendValidity) {
              // annnoce bloc doit etre non null
              if (annonceBloc != null) {
                if (resultInfotarif.getSuccess()![i].annonceType ==
                    annonceBloc!.state.selectedAnnonce!.annonceType) {
                  tarifsOption.add(resultInfotarif.getSuccess()![i]);
                }
              }
            } else {
              if (resultInfotarif.getSuccess()![i].annonceType !=
                      AnnonceType.partenaire &&
                  resultInfotarif.getSuccess()![i].annonceType !=
                      AnnonceType.sponsor) {
                if (event.modeVIPOnly) {
                  if (resultInfotarif.getSuccess()![i].annonceType ==
                      AnnonceType.vip) {
                    tarifsOption.add(resultInfotarif.getSuccess()![i]);
                  }
                } else {
                  if (resultInfotarif.getSuccess()![i].annonceType !=
                      AnnonceType.vip) {
                    tarifsOption.add(resultInfotarif.getSuccess()![i]);
                  }
                }
              }
            }
          }
          emit(state.copyWith(
            status: Status.loaded,
            idMenu: event.idMenu,
            imagesAnnonceUpload: imageUploads,
            indexTarifSelected: indexAnnonceTarif,
            annonceTarif: tarifsOption,
            categoriesMenuParent: result.getSuccess(),
          ));
        }
      }
    });
    on<InitComplainBloc>((event, emit) async {
      /// Récupère l’arborescence des menus à partir de `categoriesInit`.
      /// Utile pour afficher la hiérarchie des menus PLAINTES ET SUGGESTIONS
      if (int.parse(event.idMenu) > 0) {
        emit(state.copyWith(status: Status.loading));
        int indexAnnonceTarif = 0;
        List<ImageUpload> imageUploads = [];
        emit(state.copyWith(
            status: Status.loaded,
            idMenu: event.idMenu,
            imagesAnnonceUpload: imageUploads,
            indexTarifSelected: indexAnnonceTarif,
            annonceTarif: [
              const AnnonceTarifOption(
                  tarifTitle: "",
                  annonceType: AnnonceType.general,
                  tarifs: [Tarif(id: 1, periode: "", priceInFaka: 0)],
                  clientName: "",
                  dateAvailability: "",
                  isAvailable: true),
            ]));
      }
    });
    on<InitBlocPartenaireSponsor>((event, emit) async {
      /// Récupère l’arborescence des menus à partir de `categoriesInit`.
      /// Utile pour afficher la hiérarchie des menus PARTENTAIRE ET SPONSOR.
      if (int.parse(event.idMenu) > 0) {
        emit(state.copyWith(status: Status.loading));

        ///  Récupère les info du menu parents
        var result = await getParentScreenUseCase(event.idMenu);

        int indexAnnonceTarif = 0;
        List<ImageUpload> imageUploads = [];

        ///  Récupère les info des tarifs
        var resultInfotarif = await getMenuTarifOptionsUseCase(event.idMenu);
        if (result.isError() || resultInfotarif.isError()) {
          emit(state.copyWith(status: Status.errorLoading));
        } else {
          List<AnnonceTarifOption> tarifsOption = [];
          for (int i = 0; i < resultInfotarif.getSuccess()!.length; i++) {
            if (resultInfotarif.getSuccess()![i].annonceType ==
                event.annonceType) {
              tarifsOption.add(resultInfotarif.getSuccess()![i]);
            }
          }
          emit(state.copyWith(
            status: Status.loaded,
            idMenu: event.idMenu,
            imagesAnnonceUpload: imageUploads,
            indexTarifSelected: indexAnnonceTarif,
            annonceTarif: tarifsOption,
            categoriesMenuParent: result.getSuccess(),
          ));
        }
      }
    });
    on<ExtendValidityEvent>(_onExtendValidityEvent);
    on<SubmitFormEvent>((event, emit) async {
      emit(state.copyWith(status: Status.demandeSubmiting));
      Result<Failure, Annonce> result;
      if (isEditMode) {
        result = await updateAnnonceUseCase(Annonce(
            slug: "",
            reactionCount: 0,
            isWebsitePub: false,
            isLiked: false,
            authorID: 0,
            menuParentRef: "0",
            menuRacineRef: "",
            menuRacineName: "",
            customHtmlUrl: "",
            dateLimit: "",
            parrain: event.parrain,
            menuParentID: int.parse(event.idMenu),
            id: annonceBloc!.state.selectedAnnonce!.id,
            title: event.title,
            descriptionCourte: event.descriptionCourte,
            descriptionDetaille: event.descriptionDetaillee,
            photos: List.generate(state.imagesAnnonceUpload.length, (index) {
              return state.imagesAnnonceUpload[index].imageEntity;
            }),
            commentaires: [],
            emplacement: event.emplacement,
            contact: event.contact,
            dateDeCreation: "",
            annonceType: annonceBloc!.state.selectedAnnonce!.annonceType,
            author: "User1",
            isFavs: false,
            menuParentName: event.titleMenu));
      } else {
        result = await createAnnonceUseCase(
            Annonce(
                isLiked: false,
                reactionCount: 0,
                isWebsitePub: false,
                slug: "",
                authorID: 0,
                dateLimit: "",
                menuParentRef: "0",
                menuRacineRef: "",
                menuRacineName: "",
                parrain: event.parrain,
                customHtmlUrl: "",
                menuParentID: int.parse(event.idMenu),
                id: 0,
                title: event.title,
                descriptionCourte: event.descriptionCourte,
                descriptionDetaille: event.descriptionDetaillee,
                photos:
                    List.generate(state.imagesAnnonceUpload.length, (index) {
                  return state.imagesAnnonceUpload[index].imageEntity;
                }),
                commentaires: [],
                emplacement: event.emplacement,
                annonceType:
                    state.annonceTarif[state.indexTarifSelected].annonceType,
                contact: event.contact,
                dateDeCreation: "",
                author: "User1",
                isFavs: false,
                menuParentName: event.titleMenu),
            state.annonceTarif[state.indexTarifSelected]
                .tarifs[state.indexAnnonceTarifOptionSelected].id);
      }
      if (result.isSuccess()) {
        emit(state.copyWith(status: Status.doneSubmiting));
        if (isEditMode) {
          annonceBloc!
              .add(AnnonceSelectedModifiedEvent(annonce: result.getSuccess()!));
        }
      } else {
        emit(state.copyWith(
            status: Status.errorSubmiting,
            errorMessage: result.getError()?.message));
      }
    });
    on<SubmitPlainteFormEvent>((event, emit) async {
      emit(state.copyWith(status: Status.demandeSubmiting));
      Result<Failure, Annonce> result;
      result = await createAnnoncePlainteSuggestionUsecase(
          Annonce(
              isLiked: false,
              reactionCount: 0,
              isWebsitePub: false,
              slug: "",
              authorID: 0,
              dateLimit: "",
              menuParentRef: "0",
              menuRacineRef: "",
              menuRacineName: "",
              parrain: event.parrain,
              customHtmlUrl: "",
              menuParentID: int.parse(event.idMenu),
              id: 0,
              title: event.title,
              descriptionCourte: event.descriptionCourte,
              descriptionDetaille: event.descriptionDetaillee,
              photos: List.generate(state.imagesAnnonceUpload.length, (index) {
                return state.imagesAnnonceUpload[index].imageEntity;
              }),
              commentaires: [],
              emplacement: event.emplacement,
              annonceType:
                  state.annonceTarif[state.indexTarifSelected].annonceType,
              contact: event.contact,
              dateDeCreation: "",
              author: "User1",
              isFavs: false,
              menuParentName: event.titleMenu),
          state.annonceTarif[state.indexTarifSelected]
              .tarifs[state.indexAnnonceTarifOptionSelected].id);

      if (result.isSuccess()) {
        emit(state.copyWith(status: Status.doneSubmiting));
        if (isEditMode) {
          annonceBloc!
              .add(AnnonceSelectedModifiedEvent(annonce: result.getSuccess()!));
        }
      } else {
        emit(state.copyWith(
            status: Status.errorSubmiting,
            errorMessage: result.getError()?.message));
      }
    });
  }

  void _onExtendValidityEvent(ExtendValidityEvent event, Emitter emit) async {
    emit(state.copyWith(status: Status.demandeSubmiting));
    Result<Failure, Annonce> result;

    result = await extendValidityAnnonceUsecase(
        annonceBloc!.state.selectedAnnonce!.id,
        state.annonceTarif[state.indexTarifSelected]
            .tarifs[state.indexAnnonceTarifOptionSelected].id);

    if (result.isSuccess()) {
      emit(state.copyWith(status: Status.doneSubmiting));
      if (isEditMode) {
        annonceBloc!
            .add(AnnonceSelectedModifiedEvent(annonce: result.getSuccess()!));
      }
    } else {
      emit(state.copyWith(
          status: Status.errorSubmiting,
          errorMessage: result.getError()?.message));
    }
  }

  void _onReorderImage(ReorderImageEvent event, Emitter<DemandePubState> emit) {
    final List<ImageUpload> updatedImages =
        List.from(state.imagesAnnonceUpload);
    final image = updatedImages.removeAt(event.oldIndex);
    updatedImages.insert(event.newIndex, image);
    emit(state.copyWith(imagesAnnonceUpload: updatedImages));
  }
}
