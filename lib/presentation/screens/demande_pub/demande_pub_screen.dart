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
import '../../widgets/app_panel_widget.dart';
import '../../widgets/error_page_widget.dart';
import 'widgets/add_image_section_widget.dart';
import 'bloc/demande_pub_bloc.dart';

class DemandePubScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final String idMenu;
  final String title;
  final String idAnnonce;
  final bool isFreeAnnonceMode;

  /// Si on cree une annonce gratuite
  final String menuParentRef;
  late final bool maskPersonalInfoMode;
  final bool isExtendValidityMode;

  /// Si on prolonge l'annonce
  final bool isTarifVIPOnlyMode;

  /// Si l'annonce est VIP seulement, donc On montre que les tarifs VIP
  final titleController = TextEditingController();
  final descriptionCourteController = TextEditingController();
  final descriptionDetailleeController = TextEditingController();
  final emplacementController = TextEditingController();
  final contactController = TextEditingController();
  final recommandController = TextEditingController();

  DemandePubScreen(
      {super.key,
      required this.idMenu,
      required this.title,
      required this.menuParentRef,
      required this.idAnnonce,
      required this.isFreeAnnonceMode,
      required this.isExtendValidityMode,
      required this.isTarifVIPOnlyMode}) {
    maskPersonalInfoMode = menuParentRef == blablaZoneMenuRef;
  }

  @override
  Widget build(BuildContext context) {
    // Si AnnonceBloc est présent, la navigation vient du détail d'annonce
    if (int.parse(idAnnonce) > 0) {
      if (isExtendValidityMode) {
        return _buildExtendValidityAnnoncePage(context);
      } else {
        return _buildEditAnnoncePage(context);
      }
    } else {
      return _buildNewAnnoncePage(context);
    }
  }

  Widget _buildNewAnnoncePage(BuildContext context) {
    return BaseScreen(
      useDefaultAnnonceSponsPart: context.read<AnnonceBloc>().annonceListID < 1,
      annoncePartner: context.read<AppBloc>().state.annoncePartenaireMenu,
      annonceSponsor: context.read<AppBloc>().state.annonceSponsorMenu,
      title: Text(
        context.appLoc.new_announce,
        style: TextStyle(
          fontFamily: "Pretendard",
          color: Colors.black,
        ),
      ),
      leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: const Icon(
            Ionicons.chevron_back,
            color: Colors.black,
          )),
      content: BlocProvider(
        create: (context) => GetIt.instance<DemandePubBloc>()
          ..add(InitBloc(idMenu: idMenu, modeVIPOnly: isTarifVIPOnlyMode)),
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
              onPopInvokedWithResult: (didPop, result) async {
                if (context.read<AnnonceBloc?>() != null) {
                  context.read<AnnonceBloc>().add(
                      LoadAnnonceList(id: int.parse(idMenu), pageIndex: 1));
                }
                Navigator.of(context).pop();
                if (didPop) {
                  return;
                }
              },
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(largePadding),
                  child: Container(
                    padding: const EdgeInsets.all(largePadding),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(mediumPadding),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          context.appLoc.announce_sent,
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
                          context.appLoc.announce_sent_extedendtext,
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
                context.read<DemandePubBloc>().add(InitBloc(
                      modeVIPOnly: isTarifVIPOnlyMode,
                      idMenu: idMenu,
                    ));
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
                            if (true)
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    context.appLoc.categoris,
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                  ),
                                  const SizedBox(
                                    height: smallPadding,
                                  ),
                                  AppPanelWidget(
                                    child: Text(
                                      context
                                          .read<DemandePubBloc>()
                                          .state
                                          .categoriesMenuParent
                                          .map((e) => (e.title.toString()))
                                          .toList()
                                          .join(" > "),
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium,
                                    ),
                                  )
                                ],
                              ),
                            const SizedBox(height: 30.0),
                            Text(
                              context.appLoc.announce_detail,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 10.0),
                            const SizedBox(
                              height: largePadding,
                            ),
                            DemandePubTextFieldWidget(
                              controller: titleController,
                              label: context.appLoc.title,
                              hintText: context.appLoc.ann_title_hint,
                              validator: (value) => value == null ||
                                      value.isEmpty
                                  ? context.appLoc.ann_title_validation_error
                                  : null,
                            ),
                            const SizedBox(height: 12.0),
                            if (menuParentRef != blablaZoneMenuRef)
                              DemandePubTextFieldWidget(
                                controller: descriptionCourteController,
                                label: context.appLoc.ann_desc_title,
                                hintText: context.appLoc.ann_desc_hint,
                                validator: (value) => value == null ||
                                        value.isEmpty
                                    ? context.appLoc.ann_desc_validation_error
                                    : null,
                              ),
                            const SizedBox(height: 12.0),
                            DemandePubTextFieldWidget(
                              controller: descriptionDetailleeController,
                              label: context.appLoc.ann_desc_long_title,
                              maxLines: 4,
                              hintText: context.appLoc.ann_desc_long_hint,
                              validator: (value) =>
                                  value == null || value.isEmpty
                                      ? context
                                          .appLoc.ann_desc_long_validation_error
                                      : null,
                            ),
                            if (!maskPersonalInfoMode)
                              const SizedBox(height: 12.0),
                            if (!maskPersonalInfoMode)
                              DemandePubTextFieldWidget(
                                controller: emplacementController,
                                label: context.appLoc.ann_emplacement_title,
                                hintText: context.appLoc.ann_emplacement_hint,
                                validator: (value) =>
                                    value == null || value.isEmpty
                                        ? context.appLoc
                                            .ann_emplacement_validation_error
                                        : null,
                              ),
                            if (!maskPersonalInfoMode)
                              const SizedBox(height: 12.0),
                            if (!maskPersonalInfoMode)
                              DemandePubTextFieldWidget(
                                controller: contactController,
                                label: context.appLoc.ann_contact_title,
                                keyboardType: TextInputType.phone,
                                hintText: context.appLoc.ann_contact_hint,
                                validator: (value) => (value == null ||
                                        value.isEmpty ||
                                        !InputValidator.isValidPhoneNumber(
                                            value))
                                    ? context.appLoc.register_tel_validation
                                    : null,
                              ),
                            const SizedBox(height: 20.0),
                            Text(
                              context.appLoc
                                  .add_images_titles(maxImageAnnonceNumber),
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            const SizedBox(height: 10.0),
                            AddImageSectionWidget(
                                menuParentRef: menuParentRef,
                                context: context,
                                state: state),
                            if (isTarifVIPOnlyMode)
                              const SizedBox(
                                height: largePadding,
                              ),
                            if (isTarifVIPOnlyMode)
                              DemandePubTextFieldWidget(
                                controller: recommandController,
                                label: context.appLoc.recommander_by,
                                keyboardType: TextInputType.phone,
                                hintText: context.appLoc.recommander_agent_hint,
                              ),
                            if (!isFreeAnnonceMode)
                              _buildOptionsDePublicationSection(context, state),
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
                                              if (!isFreeAnnonceMode) {
                                                MessageDisplayerUtils
                                                    .showConfirmSendAnnonceDialog(
                                                  context,
                                                  "${(state.annonceTarif[state.indexTarifSelected].tarifs[state.indexAnnonceTarifOptionSelected].priceInFakaFormatted())} KARA",
                                                  () {
                                                    if (_formKey.currentState!
                                                        .validate()) {
                                                      context.read<DemandePubBloc>().add(SubmitFormEvent(
                                                          idAnnonce: idAnnonce,
                                                          idMenu: idMenu,
                                                          titleMenu: title,
                                                          title: titleController
                                                              .text,
                                                          descriptionCourte:
                                                              descriptionCourteController
                                                                  .text,
                                                          descriptionDetaillee:
                                                              descriptionDetailleeController
                                                                  .text,
                                                          emplacement:
                                                              emplacementController
                                                                  .text,
                                                          contact:
                                                              contactController
                                                                  .text,
                                                          parrain:
                                                              recommandController
                                                                  .text));
                                                    }
                                                  },
                                                );
                                              } else {
                                                context
                                                    .read<DemandePubBloc>()
                                                    .add(SubmitFormEvent(
                                                        idAnnonce: idAnnonce,
                                                        idMenu: idMenu,
                                                        titleMenu: title,
                                                        title: titleController
                                                            .text,
                                                        descriptionCourte:
                                                            descriptionCourteController
                                                                .text,
                                                        descriptionDetaillee:
                                                            descriptionDetailleeController
                                                                .text,
                                                        emplacement:
                                                            emplacementController
                                                                .text,
                                                        contact:
                                                            contactController
                                                                .text,
                                                        parrain: ""));
                                              }
                                            } else {
                                              MessageDisplayerUtils
                                                  .showInvalidInputSendAnnonceDialog(
                                                      context);
                                            }
                                          },
                                    child: Center(
                                      child: Text(
                                        context.appLoc.publish_annoucement,
                                        // context.appLoc.send_announce,
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

  Widget _buildOptionsDePublicationSection(
      BuildContext context, DemandePubState state,
      {bool selectableNonDisponible = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(height: 30.0),
        Text(
          context.appLoc.ann_option_title,
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10.0),
        if (state.annonceTarif.isNotEmpty)
          AppPanelWidget(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 0),
                  child: Text(
                    context.appLoc.ann_option_choose_type,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
                const SizedBox(
                  height: smallPadding,
                ),
                Column(
                  children: List.generate(
                      state.annonceTarif.length,
                      (index) => RadioListTile(
                            value: index,
                            isThreeLine: (selectableNonDisponible ||
                                    state.annonceTarif[index].isAvailable)
                                ? false
                                : true,
                            groupValue: state.indexTarifSelected,
                            title: Text(state.annonceTarif[index].tarifTitle),
                            subtitle: (selectableNonDisponible ||
                                    state.annonceTarif[index].isAvailable)
                                ? null
                                : Text(
                                    state.annonceTarif[index]
                                        .getReadableAvailability(context),
                                    style: const TextStyle(color: Colors.red),
                                  ),
                            onChanged: (!selectableNonDisponible &&
                                    !state.annonceTarif[index].isAvailable)
                                ? null
                                : (value) {
                                    if (value != null) {
                                      context.read<DemandePubBloc>().add(
                                          AnnonceTarifSelectEvent(
                                              index: index));
                                    }
                                  },
                          )),
                ),
                const SizedBox(
                  height: mediumPadding,
                ),
                const Divider(
                  height: 2,
                  color: Colors.grey,
                ),
                const SizedBox(
                  height: largePadding,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 0),
                  child: Text(
                    context.appLoc.ann_option_choose_duration,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
                const SizedBox(
                  height: smallPadding,
                ),
                Column(
                  children: List.generate(
                      state
                          .annonceTarif[state.indexTarifSelected].tarifs.length,
                      (index) => RadioListTile(
                            value: index,
                            groupValue: state.indexAnnonceTarifOptionSelected,
                            title: Row(
                              children: [
                                Text(state
                                    .annonceTarif[state.indexTarifSelected]
                                    .tarifs[index]
                                    .getReadablePeriode()),
                                const Spacer(),
                                Image.asset(
                                  width: 24,
                                  height: 24,
                                  mipsCoin,
                                  fit: BoxFit.cover,
                                ),
                                const SizedBox(width: smallPadding),
                                Text((state
                                    .annonceTarif[state.indexTarifSelected]
                                    .tarifs[index]
                                    .priceInFakaFormatted())),
                              ],
                            ),
                            // subtitle:
                            onChanged: (value) {
                              if (value != null) {
                                context.read<DemandePubBloc>().add(
                                    AnnonceTarifOptionSelectEvent(
                                        index: index));
                              }
                            },
                          )),
                ),
              ],
            ),
          ),
        if (state.annonceTarif.isNotEmpty) const SizedBox(height: 30.0),
        if (state.annonceTarif.isNotEmpty)
          AppPanelWidget(
            child: Row(
              children: [
                Text(
                  context.appLoc.ann_total_amount,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                Image.asset(
                  width: 24,
                  height: 24,
                  mipsCoin,
                  fit: BoxFit.cover,
                ),
                const SizedBox(width: smallPadding),
                Text(
                  (state.annonceTarif[state.indexTarifSelected]
                      .tarifs[state.indexAnnonceTarifOptionSelected]
                      .priceInFakaFormatted()),
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        const SizedBox(
          height: largePadding * 2,
        ),
      ],
    );
  }

  Widget _buildEditAnnoncePage(BuildContext context) {
    Annonce annonce = context.read<AnnonceBloc>().state.selectedAnnonce!;

    return BaseScreen(
      useDefaultAnnonceSponsPart: context.read<AnnonceBloc>().annonceListID < 1,
      annoncePartner: context.read<AppBloc>().state.annoncePartenaireMenu,
      annonceSponsor: context.read<AppBloc>().state.annonceSponsorMenu,
      title: Text(
        context.appLoc.ann_mod_title,
        style: TextStyle(
          fontFamily: "Pretendard",
          color: Colors.black,
        ),
      ),
      leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: const Icon(
            Ionicons.chevron_back,
            color: Colors.black,
          )),
      content: BlocProvider(
        create: (context) => GetIt.instance<DemandePubBloc>()
          ..add(InitBloc(
            modeVIPOnly: isTarifVIPOnlyMode,
            idMenu: annonce.menuParentID.toString(),
            annonceBLoc: context.read<AnnonceBloc>(),
          )),
        child: BlocBuilder<DemandePubBloc, DemandePubState>(
            buildWhen: (previous, current) {
          if (current.status == Status.doneSubmiting) {
            Navigator.pop(context);
            MessageDisplayerUtils.showToastMessage(context.appLoc.ann_mod_done);
            return false;
          }
          if (current.status == Status.errorSubmiting &&
              previous.status != Status.errorSubmiting) {
            MessageDisplayerUtils.showErrorDialog(
                context, current.errorMessage);
          }
          return true;
        }, builder: (context, state) {
          if (state.status == Status.errorLoading) {
            return RefreshIndicator(
              onRefresh: () async {
                context.read<DemandePubBloc>().add(InitBloc(
                      modeVIPOnly: isTarifVIPOnlyMode,
                      idMenu: idMenu,
                      annonceBLoc: context.read<AnnonceBloc>(),
                    ));
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
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  context.appLoc.categoris,
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                                AppPanelWidget(
                                  child: Text(
                                    context
                                        .read<DemandePubBloc>()
                                        .state
                                        .categoriesMenuParent
                                        .map((e) => (e.title.toString()))
                                        .toList()
                                        .join(" > "),
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: largePadding,
                            ),
                            DemandePubTextFieldWidget(
                              controller: titleController..text = annonce.title,
                              label: context.appLoc.title,
                              hintText: context.appLoc.ann_title_hint,
                              validator: (value) => value == null ||
                                      value.isEmpty
                                  ? context.appLoc.ann_title_validation_error
                                  : null,
                            ),
                            const SizedBox(height: 12.0),
                            if (menuParentRef != blablaZoneMenuRef)
                              DemandePubTextFieldWidget(
                                controller: descriptionCourteController
                                  ..text = annonce.descriptionCourte,
                                label: context.appLoc.ann_desc_title,
                                hintText: context.appLoc.ann_desc_hint,
                                validator: (value) => value == null ||
                                        value.isEmpty
                                    ? context.appLoc.ann_desc_validation_error
                                    : null,
                              ),
                            const SizedBox(height: 12.0),
                            DemandePubTextFieldWidget(
                              controller: descriptionDetailleeController
                                ..text = annonce.descriptionDetaille,
                              label: context.appLoc.ann_desc_long_title,
                              maxLines: 4,
                              hintText: context.appLoc.ann_desc_long_hint,
                              validator: (value) =>
                                  value == null || value.isEmpty
                                      ? context
                                          .appLoc.ann_desc_long_validation_error
                                      : null,
                            ),
                            if (!maskPersonalInfoMode)
                              const SizedBox(height: 12.0),
                            if (!maskPersonalInfoMode)
                              DemandePubTextFieldWidget(
                                controller: emplacementController
                                  ..text = annonce.emplacement,
                                label: context.appLoc.ann_emplacement_title,
                                hintText: context.appLoc.ann_emplacement_hint,
                                validator: (value) =>
                                    value == null || value.isEmpty
                                        ? context.appLoc
                                            .ann_emplacement_validation_error
                                        : null,
                              ),
                            if (!maskPersonalInfoMode)
                              const SizedBox(height: 12.0),
                            if (!maskPersonalInfoMode)
                              DemandePubTextFieldWidget(
                                controller: contactController
                                  ..text = annonce.contactFormatted,
                                label: context.appLoc.ann_contact_title,
                                keyboardType: TextInputType.phone,
                                hintText: context.appLoc.ann_contact_hint,
                                validator: (value) => (value == null ||
                                        value.isEmpty ||
                                        !InputValidator.isValidPhoneNumber(
                                            value))
                                    ? context.appLoc.register_tel_validation
                                    : null,
                              ),
                            const SizedBox(height: 20.0),
                            Text(
                              context.appLoc
                                  .add_images_titles(maxImageAnnonceNumber),
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            const SizedBox(height: 10.0),
                            AddImageSectionWidget(
                                menuParentRef: menuParentRef,
                                context: context,
                                state: state),
                            const SizedBox(height: 30.0),
                            const SizedBox(
                              height: largePadding * 2,
                            ),
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
                                              context
                                                  .read<DemandePubBloc>()
                                                  .add(SubmitFormEvent(
                                                      idAnnonce: idAnnonce,
                                                      idMenu: idMenu,
                                                      titleMenu: title,
                                                      title:
                                                          titleController.text,
                                                      descriptionCourte:
                                                          descriptionCourteController
                                                              .text,
                                                      descriptionDetaillee:
                                                          descriptionDetailleeController
                                                              .text,
                                                      emplacement:
                                                          emplacementController
                                                              .text,
                                                      contact: contactController
                                                          .text,
                                                      parrain: ""));
                                            }
                                          },
                                    child: Center(
                                      child: Text(
                                        context.appLoc.modify_announce,
                                        // style: TextStyle(fontSize: 16.0),
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

  Widget _buildExtendValidityAnnoncePage(BuildContext context) {
    Annonce annonce = context.read<AnnonceBloc>().state.selectedAnnonce!;

    return BaseScreen(
      useDefaultAnnonceSponsPart: context.read<AnnonceBloc>().annonceListID < 1,
      annoncePartner: context.read<AppBloc>().state.annoncePartenaireMenu,
      annonceSponsor: context.read<AppBloc>().state.annonceSponsorMenu,
      title: Text(
        context.appLoc.ann_mod_title,
        style: TextStyle(
          fontFamily: "Pretendard",
          color: Colors.black,
        ),
      ),
      leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: const Icon(
            Ionicons.chevron_back,
            color: Colors.black,
          )),
      content: BlocProvider(
        create: (context) => GetIt.instance<DemandePubBloc>()
          ..add(InitBloc(
            modeExtendValidity: isExtendValidityMode,
            idMenu: annonce.menuParentID.toString(),
            annonceBLoc: context.read<AnnonceBloc>(),
          )),
        child: BlocBuilder<DemandePubBloc, DemandePubState>(
            buildWhen: (previous, current) {
          if (current.status == Status.doneSubmiting) {
            Navigator.pop(context);
            MessageDisplayerUtils.showToastMessage(context.appLoc.ann_mod_done);
            return false;
          }
          if (current.status == Status.errorSubmiting &&
              previous.status != Status.errorSubmiting) {
            MessageDisplayerUtils.showErrorDialog(
                context, current.errorMessage);
          }
          return true;
        }, builder: (context, state) {
          if (state.status == Status.errorLoading) {
            return RefreshIndicator(
              onRefresh: () async {
                context.read<DemandePubBloc>().add(InitBloc(
                      modeVIPOnly: isTarifVIPOnlyMode,
                      idMenu: idMenu,
                      annonceBLoc: context.read<AnnonceBloc>(),
                    ));
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
                              isReadOnly: true,
                              controller: titleController..text = annonce.title,
                              label: context.appLoc.title,
                              hintText: context.appLoc.ann_title_hint,
                              validator: (value) => value == null ||
                                      value.isEmpty
                                  ? context.appLoc.ann_title_validation_error
                                  : null,
                            ),
                            if (isExtendValidityMode)
                              _buildOptionsDePublicationSection(context, state,
                                  selectableNonDisponible: true),
                            const SizedBox(
                              height: largePadding * 2,
                            ),
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
                                              context
                                                  .read<DemandePubBloc>()
                                                  .add(ExtendValidityEvent());
                                            }
                                          },
                                    child: Center(
                                      child: Text(
                                        context.appLoc.extend_validity,
                                        // style: TextStyle(fontSize: 16.0),
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
