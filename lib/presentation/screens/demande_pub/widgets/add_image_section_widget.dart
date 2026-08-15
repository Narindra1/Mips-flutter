import 'package:mips/presentation/configurations/extension_for_localization.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:reorderables/reorderables.dart';

import '../../../../common/constants/constant.dart';
import '../../../../domain/entities/image_upload.dart';
import '../../../configurations/colors_list.dart';
import '../../../widgets/app_panel_widget.dart';
import '../../../widgets/loading_image_cache_widget.dart';
import '../bloc/demande_pub_bloc.dart';

enum ImageSectionType { normal, mahaNouvelle, conseil }

class AddImageSectionWidget extends StatefulWidget {
  AddImageSectionWidget({
    super.key,
    required this.context,
    required this.state,
    required String menuParentRef,
  }) {
    if (menuParentRef == mahaNouvelleMenuRef) {
      imageSectionType = ImageSectionType.mahaNouvelle;
    } else if (menuParentRef == blablaZoneMenuRef) {
      imageSectionType = ImageSectionType.conseil;
    } else {
      imageSectionType = ImageSectionType.normal;
    }
    haveDefaultImage = imageSectionType != ImageSectionType.normal;
  }

  final BuildContext context;
  final DemandePubState state;
  late final ImageSectionType imageSectionType;
  late final bool haveDefaultImage;

  @override
  State<AddImageSectionWidget> createState() => _AddImageSectionWidgetState();
}

class _AddImageSectionWidgetState extends State<AddImageSectionWidget>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return AppPanelWidget(
      child: AspectRatio(
        aspectRatio: 3 / 1,
        child: Row(
          children: [
            Flexible(
              flex: widget.state.imagesAnnonceUpload.length,
              child: ReorderableRow(
                mainAxisSize: MainAxisSize.min,
                scrollController: ScrollController(),
                children: List.generate(
                  widget.state.imagesAnnonceUpload.length,
                  (index) => AspectRatio(
                    key: Key(
                      widget.state.imagesAnnonceUpload[index].imageEntity.id
                          .toString(),
                    ),
                    aspectRatio: 1 / 1,
                    child: Padding(
                      padding: const EdgeInsets.all(mediumPadding),
                      child: _getChild(index),
                    ),
                  ),
                ),
                onReorder: (oldIndex, newIndex) {
                  widget.context.read<DemandePubBloc>().add(
                    ReorderImageEvent(oldIndex, newIndex),
                  );
                },
              ),
            ),
            if (widget.state.imagesAnnonceUpload.length < maxImageAnnonceNumber)
              Flexible(
                child: _getChild(widget.state.imagesAnnonceUpload.length),
              ),
          ],
        ),
      ),
    );
  }

  Widget _getChild(int index) {
    if (index == widget.state.imagesAnnonceUpload.length) {
      if (widget.state.imagesAnnonceUpload.isEmpty) {
        return AspectRatio(
          aspectRatio: 3,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: InkWell(
                  borderRadius: BorderRadius.circular(mediumPadding),
                  onTap:
                      widget.state.imagesAnnonceUpload.length >=
                          maxImageAnnonceNumber
                      ? null
                      : () {
                          widget.context.read<DemandePubBloc>().add(
                            AddImageEvent(),
                          );
                        },
                  child: DottedBorder(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(smallPadding),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.add_circle_outline, size: 32),
                            const SizedBox(height: smallPadding),
                            Text(widget.context.appLoc.add_photo_label),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              if (widget.haveDefaultImage) const SizedBox(width: largePadding),
              if (widget.haveDefaultImage)
                Text(
                  widget.context.appLoc.or_text,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              if (widget.haveDefaultImage) const SizedBox(width: largePadding),
              if (widget.haveDefaultImage)
                AspectRatio(
                  aspectRatio: 1,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(mediumPadding),
                    onTap:
                        widget.state.imagesAnnonceUpload.length >=
                            maxImageAnnonceNumber
                        ? null
                        : () {
                            _showImagePickerDialog();
                          },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border.all(color: Colors.grey.shade400),
                        borderRadius: BorderRadius.circular(mediumPadding),
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(smallPadding),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.search, size: 32),
                              const SizedBox(height: smallPadding),
                              Text(
                                widget.context.appLoc.browse_image,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        );
      }
      return AspectRatio(
        aspectRatio: 1,
        child: InkWell(
          borderRadius: BorderRadius.circular(mediumPadding),
          onTap:
              widget.state.imagesAnnonceUpload.length >= maxImageAnnonceNumber
              ? null
              : () {
                  widget.context.read<DemandePubBloc>().add(AddImageEvent());
                },
          child: DottedBorder(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(smallPadding),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.add_circle_outline, size: 32),
                    const SizedBox(height: smallPadding),
                    Text(widget.context.appLoc.add_photo_label),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }
    final ImageUpload image = widget.state.imagesAnnonceUpload[index];
    Widget imageUploadWidget = SizedBox(key: Key("${index}1"));
    if (image.status == ImageUploadStatus.uploading) {
      imageUploadWidget = Container(
        padding: const EdgeInsets.all(smallPadding),
        width: double.infinity,
        height: double.infinity,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              LinearProgressIndicator(value: image.uploadProgress / 100),
              const SizedBox(height: smallPadding),
              Text(
                "${image.imageSize.toStringAsFixed(2)} Mo",
                style: const TextStyle(
                  color: tertiaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      );
    } else if (image.status == ImageUploadStatus.error) {
      imageUploadWidget = SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(smallPadding),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.error, color: tertiaryColor),
                const SizedBox(height: smallPadding),
                Text(widget.context.appLoc.error_upload),
              ],
            ),
          ),
        ),
      );
    } else {
      imageUploadWidget = CachedNetworkImage(
        imageUrl: image.imageEntity.url,
        fit: BoxFit.cover,
        progressIndicatorBuilder: (context, url, progress) =>
            const LoadingImageCacheWidget(),
        errorWidget: (context, url, error) => const Icon(Icons.error, size: 42),
      );
    }
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(mediumPadding),
          ),
        ),
        imageUploadWidget,
        Positioned(
          top: 4,
          right: 4,
          child: GestureDetector(
            onTap: () {
              widget.context.read<DemandePubBloc>().add(
                RemoveImageEvent(index),
              );
            },
            child: const Icon(Icons.cancel, color: tertiaryColor),
          ),
        ),
      ],
    );
  }

  void _showImagePickerDialog() async {
    List<String> imagePaths =
        widget.imageSectionType == ImageSectionType.mahaNouvelle
        ? mahaNouvelleDefaultImage
        : conseilDefaultImage;
    await showDialog<String>(
      context: widget.context,
      builder: (context2) {
        return AlertDialog(
          title: Text(widget.context.appLoc.choose_img),
          content: SizedBox(
            width: double.maxFinite,
            child: GridView.builder(
              shrinkWrap: true,
              itemCount: imagePaths.length,
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 250,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 5 / 3,
              ),
              itemBuilder: (context3, index) {
                final imagePath = imagePaths[index];
                return GestureDetector(
                  onTap: () {
                    widget.context.read<DemandePubBloc>().add(
                      AddImageEvent(path: imagePath),
                    );
                    widget.context.pop();
                  },
                  child: Stack(
                    fit: StackFit.expand,
                    children: [Image.asset(imagePath, fit: BoxFit.contain)],
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}

// class AddImageSectionWidget extends StatelessWidget {
//   AddImageSectionWidget(
//       {super.key,
//       required this.context,
//       required this.state,
//       required String menuParentRef}) {
//     if (menuParentRef == mahaNouvelleMenuRef) {
//       imageSectionType = ImageSectionType.mahaNouvelle;
//     } else if (menuParentRef == blablaZoneMenuRef) {
//       imageSectionType = ImageSectionType.conseil;
//     } else {
//       imageSectionType = ImageSectionType.normal;
//     }
//     haveDefaultImage = imageSectionType != ImageSectionType.normal;
//   }

//   final BuildContext context;
//   late final ImageSectionType imageSectionType;
//   late final bool haveDefaultImage;

//   final DemandePubState state;

//   @override
//   Widget build(BuildContext context) {
//     return AppPanelWidget(
//       child: AspectRatio(
//         aspectRatio: 3 / 1,
//         child: Row(
//           children: [
//             Flexible(
//               flex: state.imagesAnnonceUpload.length,
//               child: ReorderableRow(
//                 mainAxisSize: MainAxisSize.min,
//                 children: List.generate(
//                   state.imagesAnnonceUpload.length,
//                   (index) => AspectRatio(
//                       key: Key(state.imagesAnnonceUpload[index].imageEntity.id
//                           .toString()),
//                       aspectRatio: 1 / 1,
//                       child: Padding(
//                           padding: const EdgeInsets.all(mediumPadding),
//                           child: _getChild(index))),
//                 ),
//                 onReorder: (oldIndex, newIndex) {
//                   context
//                       .read<DemandePubBloc>()
//                       .add(ReorderImageEvent(oldIndex, newIndex));
//                 },
//               ),
//             ),
//             if (state.imagesAnnonceUpload.length < maxImageAnnonceNumber)
//               Flexible(child: _getChild(state.imagesAnnonceUpload.length))
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _getChild(int index) {
//     if (index == state.imagesAnnonceUpload.length) {
//       if (state.imagesAnnonceUpload.isEmpty) {
//         return AspectRatio(
//           aspectRatio: 3,
//           child: Row(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               AspectRatio(
//                 aspectRatio: 1,
//                 child: InkWell(
//                   borderRadius: BorderRadius.circular(mediumPadding),
//                   onTap: state.imagesAnnonceUpload.length >=
//                           maxImageAnnonceNumber
//                       ? null
//                       : () {
//                           context.read<DemandePubBloc>().add(AddImageEvent());
//                         },
//                   child: DottedBorder(
//                     // color: Colors.black26,
//                     // radius: const Radius.circular(mediumPadding),
//                     // borderType: BorderType.RRect,
//                     child: Center(
//                       child: Padding(
//                         padding: const EdgeInsets.all(smallPadding),
//                         child: Column(
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             const Icon(
//                               Icons.add_circle_outline,
//                               size: 32,
//                             ),
//                             const SizedBox(
//                               height: smallPadding,
//                             ),
//                             Text(context.appLoc.add_photo_label),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               if (haveDefaultImage)
//                 const SizedBox(
//                   width: largePadding,
//                 ),
//               if (haveDefaultImage)
//                 Text(
//                   context.appLoc.or_text,
//                   style: const TextStyle(fontWeight: FontWeight.bold),
//                 ),
//               if (haveDefaultImage)
//                 const SizedBox(
//                   width: largePadding,
//                 ),
//               if (haveDefaultImage)
//                 AspectRatio(
//                   aspectRatio: 1,
//                   child: InkWell(
//                     borderRadius: BorderRadius.circular(mediumPadding),
//                     onTap: state.imagesAnnonceUpload.length >=
//                             maxImageAnnonceNumber
//                         ? null
//                         : () {
//                             _showImagePickerDialog();
//                           },
//                     child: Container(
//                       decoration: BoxDecoration(
//                         color: Colors.transparent,
//                         border: Border.all(color: Colors.grey.shade400),
//                         borderRadius: BorderRadius.circular(mediumPadding),
//                       ),
//                       child: Center(
//                         child: Padding(
//                           padding: const EdgeInsets.all(smallPadding),
//                           child: Column(
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               const Icon(
//                                 Icons.search,
//                                 size: 32,
//                               ),
//                               const SizedBox(
//                                 height: smallPadding,
//                               ),
//                               Text(
//                                 context.appLoc.browse_image,
//                                 textAlign: TextAlign.center,
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//             ],
//           ),
//         );
//       }
//       return AspectRatio(
//         aspectRatio: 1,
//         child: InkWell(
//           borderRadius: BorderRadius.circular(mediumPadding),
//           onTap: state.imagesAnnonceUpload.length >= maxImageAnnonceNumber
//               ? null
//               : () {
//                   context.read<DemandePubBloc>().add(AddImageEvent());
//                 },
//           child: DottedBorder(
//             // color: Colors.black26,
//             // radius: const Radius.circular(mediumPadding),
//             // borderType: BorderType.RRect,
//             child: Center(
//               child: Padding(
//                 padding: const EdgeInsets.all(smallPadding),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     const Icon(
//                       Icons.add_circle_outline,
//                       size: 32,
//                     ),
//                     const SizedBox(
//                       height: smallPadding,
//                     ),
//                     Text(context.appLoc.add_photo_label),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       );
//     }
//     final ImageUpload image = state.imagesAnnonceUpload[index];
//     Widget imageUploadWidget = SizedBox(
//       key: Key("${index}1"),
//     );
//     if (image.status == ImageUploadStatus.uploading) {
//       imageUploadWidget = Container(
//         padding: const EdgeInsets.all(smallPadding),
//         width: double.infinity,
//         height: double.infinity,
//         child: Center(
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               LinearProgressIndicator(
//                 value: image.uploadProgress / 100,
//               ),
//               const SizedBox(
//                 height: smallPadding,
//               ),
//               Text(
//                 "${image.imageSize.toStringAsFixed(2)} Mo",
//                 style: const TextStyle(
//                     color: tertiaryColor, fontWeight: FontWeight.bold),
//               ),
//             ],
//           ),
//         ),
//       );
//     } else if (image.status == ImageUploadStatus.error) {
//       imageUploadWidget = SizedBox(
//           width: double.infinity,
//           height: double.infinity,
//           child: Center(
//             child: Padding(
//               padding: const EdgeInsets.all(smallPadding),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   const Icon(
//                     Icons.error,
//                     color: tertiaryColor,
//                   ),
//                   const SizedBox(
//                     height: smallPadding,
//                   ),
//                   Text(context.appLoc.error_upload)
//                 ],
//               ),
//             ),
//           ));
//     } else {
//       imageUploadWidget = CachedNetworkImage(
//         imageUrl: image.imageEntity.url,
//         fit: BoxFit.cover,
//         progressIndicatorBuilder: (context, url, progress) =>
//             const LoadingImageCacheWidget(),
//         errorWidget: (context, url, error) => const Icon(
//           Icons.error,
//           size: 42,
//         ),
//       );
//     }
//     return Stack(
//       alignment: Alignment.center,
//       children: [
//         Container(
//           decoration: BoxDecoration(
//               color: Colors.grey.shade200,
//               borderRadius: BorderRadius.circular(mediumPadding)),
//         ),
//         imageUploadWidget,
//         Positioned(
//           top: 4,
//           right: 4,
//           child: GestureDetector(
//             onTap: () {
//               context.read<DemandePubBloc>().add(RemoveImageEvent(index));
//             },
//             child: const Icon(
//               Icons.cancel,
//               color: tertiaryColor,
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   void _showImagePickerDialog() async {
//     List<String> imagePaths = imageSectionType == ImageSectionType.mahaNouvelle
//         ? mahaNouvelleDefaultImage
//         : conseilDefaultImage;
//     /* final selected =*/ await showDialog<String>(
//       context: context,
//       builder: (context2) {
//         return AlertDialog(
//           title: Text(context.appLoc.choose_img),
//           content: SizedBox(
//             width: double.maxFinite,
//             child: GridView.builder(
//               shrinkWrap: true,
//               itemCount: imagePaths.length,
//               gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
//                 maxCrossAxisExtent: 250, // Max width for each item
//                 mainAxisSpacing: 10,
//                 crossAxisSpacing: 10,
//                 childAspectRatio: 5 / 3, // Keep square aspect ratio
//               ),
//               itemBuilder: (context3, index) {
//                 final imagePath = imagePaths[index];
//                 return GestureDetector(
//                   onTap: () {
//                     context
//                         .read<DemandePubBloc>()
//                         .add(AddImageEvent(path: imagePath));
//                     context.pop();
//                   },
//                   child: Stack(
//                     fit: StackFit.expand,
//                     children: [
//                       Image.asset(imagePath, fit: BoxFit.contain),
//                     ],
//                   ),
//                 );
//               },
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
