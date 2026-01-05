import 'package:MIPS/common/common.dart';
import 'package:MIPS/domain/domain.dart';
import 'package:MIPS/presentation/configurations/colors_list.dart';
import 'package:MIPS/presentation/configurations/extension_for_localization.dart';
import 'package:MIPS/presentation/presentation.dart';
import 'package:MIPS/presentation/screens/base/base_screen.dart';
import 'package:MIPS/presentation/screens/demande_pub/widgets/demande_pub_textfield_widget.dart';
import 'package:MIPS/presentation/widgets/message_displayer_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:ionicons/ionicons.dart';
import '../../../domain/entities/image_upload.dart';
import '../../routes/route.dart';
import '../../widgets/error_page_widget.dart';
import 'widgets/add_image_section_widget.dart';
import 'bloc/demande_pub_bloc.dart';

class DemandePlaintesScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final String idMenu;
  final String title;
  final titleController = TextEditingController();
  final descriptionCourteController = TextEditingController();
  final descriptionDetailleeController = TextEditingController();

  DemandePlaintesScreen({
    super.key,
    required this.idMenu,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    print("DEMANDE PLAINTE : $idMenu AND $title");
    return _buildNewAnnoncePage(context);
  }

  Widget _buildNewAnnoncePage(BuildContext context) {
    return BaseScreen(
      annoncePartner: context.read<AppBloc>().state.annoncePartenaireMenu ??
          context.read<AppBloc>().state.annoncePartenaire,
      annonceSponsor: context.read<AppBloc>().state.annonceSponsorMenu ??
          context.read<AppBloc>().state.annonceSponsor,
      leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: Icon(
            Ionicons.chevron_back,
            color: Colors.black,
          )),
      title: Text(
        title,
        style: TextStyle(
          fontFamily: "Pretendard",
          color: Colors.black,
        ),
      ),
      content: BlocProvider(
        create: (context) => GetIt.instance<DemandePubBloc>()
          ..add(InitComplainBloc(
            idMenu: idMenu,
          )),
        child: BlocBuilder<DemandePubBloc, DemandePubState>(
            buildWhen: (previous, current) {
          if (current.status == Status.errorSubmiting &&
              previous.status != Status.errorSubmiting) {
            MessageDisplayerUtils.showErrorDialog(
                context, current.errorMessage);
          }
          return true;
        }, builder: (context, state) {
          if (state.status == Status.doneSubmiting) {
            return PopScope(
              canPop: false,
              onPopInvokedWithResult: (didPop, result) {
                if (didPop) {
                  if (context.read<AnnonceBloc?>() != null) {
                    context.read<AnnonceBloc>().add(
                          LoadAnnonceList(id: int.parse(idMenu), pageIndex: 1),
                        );
                  }
                }
              },
              // onPopInvokedWithResult: (didPop, result) async {
              //   if (context.read<AnnonceBloc?>() != null) {
              //     context.read<AnnonceBloc>().add(
              //         LoadAnnonceList(id: int.parse(idMenu), pageIndex: 1));
              //   }
              //   Navigator.of(context).pop();
              //   if (didPop) {
              //     return;
              //   }
              // },
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(largePadding),
                  child: Container(
                    padding: const EdgeInsets.all(largePadding),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(mediumPadding),
                      // color: Colors.white,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          context.appLoc.plainte_sent,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(
                          height: largePadding,
                        ),
                        const Icon(
                          Icons.done_outline_rounded,
                          size: 32,
                          color: tertiaryColor,
                        ),
                        const SizedBox(
                          height: mediumPadding,
                        ),
                        Text(
                          context.appLoc.plainte_sent_extendedtext,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: largePadding * 2,
                        ),
                        FilledButton(
                            onPressed: () {
                              context.pop();
                            },
                            child: Text(context.appLoc.fermer))
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
          if (state.status == Status.errorLoading) {
            return RefreshIndicator(
              onRefresh: () async {
                context
                    .read<DemandePubBloc>()
                    .add(InitBloc(idMenu: idMenu, modeVIPOnly: false));
              },
              child: const CustomScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  slivers: [
                    SliverFillRemaining(
                      child: Center(
                        child: ErrorPageWidget(),
                      ),
                    ),
                  ]),
            );
          }
          return Stack(
            children: [
              Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(
                          horizontal: largePadding, vertical: largePadding),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            DemandePubTextFieldWidget(
                              controller: titleController,
                              label: context.appLoc.title,
                              hintText: "",
                              validator: (value) => value == null ||
                                      value.isEmpty
                                  ? context.appLoc.ann_title_validation_error
                                  : null,
                            ),
                            const SizedBox(height: 12.0),
                            DemandePubTextFieldWidget(
                              controller: descriptionDetailleeController,
                              label: context.appLoc.ann_desc_long_title,
                              maxLines: 4,
                              hintText: "",
                              validator: (value) =>
                                  value == null || value.isEmpty
                                      ? context
                                          .appLoc.ann_desc_long_validation_error
                                      : null,
                            ),
                            const SizedBox(height: 20.0),
                            Text(
                              context.appLoc.add_images_capture_titles(
                                  maxImageAnnonceNumber),
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            const SizedBox(height: 10.0),
                            AddImageSectionWidget(
                                menuParentRef: "",
                                context: context,
                                state: state),
                            const SizedBox(height: 10.0),
                            Align(
                              alignment: Alignment.center,
                              child: Container(
                                constraints: const BoxConstraints(
                                    maxWidth: maxViewWidth),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: largePadding,
                                    vertical: smallPadding),
                                child: SizedBox(
                                  height: 40,
                                  child: FilledButton(
                                    style: ButtonStyle(
                                        shape: WidgetStatePropertyAll(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        16)))),
                                    onPressed: (state.imagesAnnonceUpload
                                            .where((element) =>
                                                element.status ==
                                                ImageUploadStatus.uploading)
                                            .isNotEmpty)
                                        ? null
                                        : () {
                                            if (_formKey.currentState!
                                                .validate()) {
                                              if (context
                                                  .read<AppBloc>()
                                                  .state
                                                  .isLogged) {
                                                context
                                                    .read<DemandePubBloc>()
                                                    .add(SubmitFormEvent(
                                                      idAnnonce: "0",
                                                      idMenu: idMenu,
                                                      titleMenu: title,
                                                      title:
                                                          titleController.text,
                                                      descriptionCourte: ".",
                                                      descriptionDetaillee:
                                                          descriptionDetailleeController
                                                              .text,
                                                      emplacement: ".",
                                                      parrain: "",
                                                      contact: ".",
                                                    ));
                                              } else {
                                                MessageDisplayerUtils
                                                    .showAuthRequiredDialog(
                                                        context,
                                                        GoRouterState.of(
                                                                context)
                                                            .uri
                                                            .toString()
                                                            .startsWith(
                                                                RoutesNames
                                                                    .login));
                                              }
                                            } else {
                                              MessageDisplayerUtils
                                                  .showInvalidInputSendAnnonceDialog(
                                                      context);
                                            }
                                          },
                                    child: Center(
                                      child: Text(
                                        context.appLoc.send,
                                        // style: const TextStyle(fontSize: 16.0),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              if (state.status == Status.demandeSubmiting ||
                  state.status == Status.loading)
                Container(
                  height: double.maxFinite,
                  width: double.maxFinite,
                  color: Colors.black26,
                  child: const AppLoadingWidget(),
                ),
            ],
          );
        }),
      ),
    );
  }
}
