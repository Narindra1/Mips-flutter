import 'package:MIPS/common/common.dart';
import 'package:MIPS/presentation/configurations/extension_for_localization.dart';
import 'package:MIPS/presentation/screens/base/base_screen.dart';
import 'package:MIPS/presentation/widgets/hero_photoview_route_wrapper.dart';
import 'package:MIPS/presentation/widgets/loading_image_cache_widget.dart';
import 'package:MIPS/presentation/widgets/message_displayer_utils.dart';
import 'package:animations/animations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:ionicons/ionicons.dart';

import '../../../domain/entities/sondage.dart';
import '../../bloc/app_bloc.dart';
import '../../routes/route.dart';
import '../../widgets/error_page_widget.dart';
import '../../widgets/loading_widget.dart';
import 'bloc/sondage_bloc.dart';

class SondageListScreen extends StatelessWidget {
  const SondageListScreen({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          GetIt.instance<SondageBloc>()..add(LoadSondagelistEvent()),
      child: BlocConsumer<SondageBloc, SondageState>(
        listener: (context, state) {
          if (state.statusSubmitting == StatusSubmitting.submitInProgress) {
            MessageDisplayerUtils.showLoadingDialog(context);
          } else if (state.statusSubmitting == StatusSubmitting.submitError) {
            context.pop();
            MessageDisplayerUtils.showErrorDialog(context, "");
          } else if (state.statusSubmitting == StatusSubmitting.submitSent) {
            context.pop();
            MessageDisplayerUtils.showToastMessage(
                context.appLoc.sondage_submit_success);
          }
        },
        listenWhen: (previous, current) =>
            previous.statusSubmitting != current.statusSubmitting,
        builder: (context, state) {
          Widget content = const SizedBox();
          if (state.status == Status.loading) {
            content = const Center(
              child: AppLoadingWidget(),
            );
          } else if (state.status == Status.loaded) {
            content = SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: state.sondagesList.length,
                itemBuilder: (context, index) {
                  return SondageEltWidget(
                    index: index,
                    sondage: state.sondagesList[index],
                  );
                },
              ),
            );
          } else {
            content = const CustomScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                slivers: [
                  SliverFillRemaining(
                    child: Center(
                      child: ErrorPageWidget(),
                    ),
                  ),
                ]);
          }
          return BaseScreen(
            content: RefreshIndicator(
              child: content,
              onRefresh: () async {
                context.read<SondageBloc>().add(LoadSondagelistEvent());
              },
            ),
            title: Text(
              title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            leading: IconButton(
                onPressed: () {
                  context.pop();
                },
                icon: const Icon(
                  Ionicons.chevron_back,
                  color: Colors.black,
                )),
            backgroundColor: Colors.white,
          );
        },
      ),
    );
  }
}

class SondageEltWidget extends StatefulWidget {
  final int index;
  final Sondage sondage;

  const SondageEltWidget(
      {super.key, required this.index, required this.sondage});

  @override
  State<SondageEltWidget> createState() => _SondageEltWidgetState();
}

class _SondageEltWidgetState extends State<SondageEltWidget> {
  int selectedOption = -1;

  @override
  void initState() {
    super.initState();
    selectedOption = widget.sondage.userSelectedOption;
  }

  @override
  Widget build(BuildContext context) {
    bool isResponded = widget.sondage.userSelectedOption > 0;
    TextTheme textTheme = Theme.of(context).textTheme;

    return Container(
      margin: const EdgeInsets.all(smallPadding),
      padding: const EdgeInsets.all(smallPadding),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(largePadding),
          border: Border.all(color: Colors.grey)),
      child: ListTile(
        title: Row(
          children: [
            Text(
              context.appLoc.sondage_theme_title(widget.index + 1),
              style: textTheme.titleSmall?.copyWith(color: Colors.grey),
            ),
            const Spacer(),
            Container(
              margin: const EdgeInsets.fromLTRB(0, 0, mediumPadding, 0),
              padding: const EdgeInsets.all(smallPadding),
              decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(mediumPadding)),
              child: Text(
                context.appLoc.sondage_fin(
                    AppUtils.formatDateMin(widget.sondage.dateLimite)),
                style: textTheme.titleSmall?.copyWith(fontSize: 12),
              ),
            ),
            !isResponded
                ? Icon(
                    Icons.check_circle,
                    color: Colors.grey.shade400,
                  )
                : const Icon(
                    Icons.check_circle,
                    color: Colors.green,
                  )
          ],
        ),
        subtitle: FormField(
          builder: (FormFieldState<int> stateForm) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Divider(
                  color: Colors.black26,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (widget.sondage.themeUrlImage != "")
                      Align(
                        alignment: Alignment.topCenter,
                        child: OpenContainer(
                          closedShape: RoundedRectangleBorder(),
                          openBuilder: (_, closeContainer) =>
                              HeroPhotoViewRouteWrapper(
                                  title: Text(
                                    "",
                                    style:
                                        Theme.of(context).textTheme.titleLarge,
                                    textAlign: TextAlign.left,
                                  ),
                                  urls: [widget.sondage.themeUrlImage],
                                  selectedImgIndex: 0),
                          closedBuilder: (_, closeContainer) =>
                              CachedNetworkImage(
                            height: 90,
                            width: 160,
                            imageUrl: widget.sondage.themeUrlImage,
                            fit: BoxFit.fitHeight,
                            progressIndicatorBuilder:
                                (context, url, progress) =>
                                    const LoadingImageCacheWidget(),
                            errorWidget: (context, url, error) => Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.error_outline),
                                Text(context.appLoc.error_loading_image)
                              ],
                            ),
                          ),
                        ),
                      ),
                    if (widget.sondage.themeUrlImage != "")
                      const SizedBox(
                        height: mediumPadding,
                      ),
                    Text(
                      widget.sondage.theme,
                      style: textTheme.titleSmall,
                      textAlign: TextAlign.justify,
                    ),
                  ],
                ),
                const SizedBox(
                  height: mediumPadding,
                ),
                Container(
                  padding: const EdgeInsets.all(largePadding),
                  decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(largePadding)),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: widget.sondage.sondageOption.isEmpty
                        ? []
                        : List.generate(
                            widget.sondage.sondageOption.length,
                            (index2) => RadioListTile(
                              radioScaleFactor: 0.75,
                              contentPadding: EdgeInsets.zero,
                              title: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    child: Text(
                                      widget.sondage.sondageOption[index2]
                                          .optionText,
                                      style: textTheme.bodySmall,
                                    ),
                                  ),
                                  if (widget.sondage.sondageOption[index2]
                                          .imageUrl !=
                                      "")
                                    Align(
                                      alignment: Alignment.topCenter,
                                      child: OpenContainer(
                                        closedShape: RoundedRectangleBorder(),
                                        openBuilder: (_, closeContainer) =>
                                            HeroPhotoViewRouteWrapper(
                                                title: Text(
                                                  "",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleLarge,
                                                  textAlign: TextAlign.left,
                                                ),
                                                urls: [
                                                  widget
                                                      .sondage
                                                      .sondageOption[index2]
                                                      .imageUrl
                                                ],
                                                selectedImgIndex: 0),
                                        closedBuilder: (_, closeContainer) =>
                                            CachedNetworkImage(
                                          height: 50,
                                          width: 50,
                                          imageUrl: widget.sondage
                                              .sondageOption[index2].imageUrl,
                                          fit: BoxFit.fitHeight,
                                          progressIndicatorBuilder: (context,
                                                  url, progress) =>
                                              const LoadingImageCacheWidget(),
                                          errorWidget: (context, url, error) =>
                                              Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              const Icon(Icons.error_outline),
                                              Text(context
                                                  .appLoc.error_loading_image)
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                              value: widget.sondage.sondageOption[index2].id,
                              groupValue: selectedOption,
                              onChanged: isResponded
                                  ? null
                                  : <int>(value) {
                                      setState(() {
                                        if (value != null) {
                                          selectedOption = value;
                                        }
                                      });
                                      stateForm.didChange(value);
                                    },
                            ),
                          ),
                  ),
                ),
                const SizedBox(
                  height: smallPadding,
                ),
                if (stateForm.errorText != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: mediumPadding),
                    child: Text(
                      stateForm.errorText!,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
                if (!isResponded)
                  Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.all(mediumPadding),
                        child: FilledButton(
                            style: ButtonStyle(
                                shape: WidgetStatePropertyAll(
                                    RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            largePadding)))),
                            onPressed: () {
                              if (stateForm.validate()) {
                                if (context.read<AppBloc>().state.isLogged) {
                                  context
                                      .read<SondageBloc>()
                                      .add(SubmitSondageEvent(
                                        sondageId: widget.sondage.id,
                                        optionSelected: selectedOption,
                                      ));
                                } else {
                                  MessageDisplayerUtils.showAuthRequiredDialog(
                                      context,
                                      GoRouterState.of(context)
                                          .uri
                                          .toString()
                                          .startsWith(RoutesNames.login));
                                }
                              }
                            },
                            child:
                                Text(context.appLoc.sondage_submit_response)),
                      )),
                Divider(
                  color: Colors.grey.shade400,
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(mediumPadding),
                    child: Text(
                      context.appLoc.respond_count(widget
                          .sondage.totalResponseCount
                          .toString()
                          .padLeft(3, '0')),
                      style: textTheme.bodyMedium,
                    ),
                  ),
                )
              ],
            );
          },
          validator: <int>(value) {
            if (value == null || value < 1) {
              return context.appLoc.sondage_validation_error;
            }
            return null;
          },
        ),
      ),
    );
  }
}
