import 'package:MIPS/common/common.dart';
import 'package:MIPS/presentation/configurations/extension_for_localization.dart';
import 'package:MIPS/presentation/widgets/message_displayer_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:ionicons/ionicons.dart';
import '../../bloc/app_bloc.dart';
import '../../configurations/colors_list.dart';
import '../../widgets/app_panel_widget.dart';
import '../base/base_screen.dart';

class TransfertFakaScreen extends StatefulWidget {
  const TransfertFakaScreen({super.key});

  @override
  State<TransfertFakaScreen> createState() => _TransfertFakaScreenState();
}

class _TransfertFakaScreenState extends State<TransfertFakaScreen> {
  final TextEditingController idTextController = TextEditingController();
  final TextEditingController amountTextController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool vertical = false;
  int? _value = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> motifs = <Widget>[
      Text(
        "Ami(e)",
        style: Theme.of(context).textTheme.titleSmall,
      ),
      Text(
        "Kara Partenaire",
        style: Theme.of(context).textTheme.titleSmall,
      ),
      Text(
        "MIPS SHOP",
        style: Theme.of(context).textTheme.titleSmall,
      ),
    ];
    List<String> motifValues = ["Ami(e)", "Kara Partenaire", "MIPS SHOP"];

    return BlocProvider.value(
      /// Réinitialise la statue du transfert en NONE
      value: context.read<AppBloc>()..add(InitTranfertScreen()),
      child: BlocListener<AppBloc, AppState>(
        listener: (context, state) {
          if (state.statusTranfertFaka == StatusTranfertFaka.transfertError) {
            context.pop();
            MessageDisplayerUtils.showErrorDialog(context, state.errorMessage);
          } else if (state.statusTranfertFaka ==
              StatusTranfertFaka.transfertInProgress) {
            MessageDisplayerUtils.showLoadingDialog(context);
          } else if (state.statusTranfertFaka ==
              StatusTranfertFaka.transfertDone) {
            context.pop();
          }
        },
        listenWhen: (previous, current) =>
            previous.statusTranfertFaka != current.statusTranfertFaka,
        child: BlocBuilder<AppBloc, AppState>(
          builder: (context, state) {
            Widget content = const SizedBox();
            if (state.statusTranfertFaka == StatusTranfertFaka.transfertDone) {
              content = Center(
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
                          context.appLoc.transfer_faka_send_title,
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
                          height: largePadding * 2,
                        ),
                        FilledButton(
                          onPressed: () {
                            context.pop();
                          },
                          child: Text(context.appLoc.fermer),
                        )
                      ],
                    ),
                  ),
                ),
              );
            } else {
              content = SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(largePadding),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        height: 150,
                        "assets/imgs/illu_transfer_kara.png",
                      ),
                      // const Padding(
                      //   padding: EdgeInsets.all(largePadding),
                      //   child: Row(
                      //     mainAxisSize: MainAxisSize.min,
                      //     children: [
                      //       Icon(
                      //         size: 64,
                      //         Icons.person,
                      //         color: Colors.black54,
                      //       ),
                      //       Icon(
                      //         size: 34,
                      //         Icons.forward,
                      //         color: Colors.black54,
                      //       ),
                      //       Icon(
                      //         Icons.person,
                      //         size: 64,
                      //       )
                      //     ],
                      //   ),
                      // ),
                      Text(
                        context.appLoc.transfer_available_amount,
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(color: Colors.grey),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(
                            width: 32,
                            height: 32,
                            "assets/imgs/mips_coin.png",
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(width: smallPadding),
                          Text(
                            AppUtils.formatNumberWithSpaces(
                                state.user?.soldeFAKA ?? 0),
                            style: Theme.of(context).textTheme.displaySmall,
                          ),
                          // const SizedBox(
                          //   width: smallPadding,
                          // ),
                          // Text(context.appLoc.mips_unit,
                          //     style: Theme.of(context).textTheme.bodyLarge)
                        ],
                      ),
                      const SizedBox(
                        height: largePadding,
                      ),
                      Form(
                        key: _formKey,
                        child:
                            // AppPanelWidget(
                            //   child:
                            Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              context.appLoc.transfer_section_title,
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            const SizedBox(
                              height: mediumPadding,
                            ),
                            if (state.user!.soldeFAKA <= 0)
                              Text(
                                context.appLoc.transfer_insufficient,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall
                                    ?.copyWith(color: Colors.red),
                              ),
                            if (state.user!.soldeFAKA <= 0)
                              const SizedBox(
                                height: largePadding,
                              ),
                            Container(
                              //   padding: const EdgeInsets.symmetric(
                              //       horizontal: largePadding,
                              //       vertical: smallPadding),
                              //   decoration: BoxDecoration(
                              //       color: Colors.grey.shade100,
                              //       borderRadius:
                              //           BorderRadius.circular(mediumPadding)),
                              child: TextFormField(
                                readOnly: state.user!.soldeFAKA <= 0,
                                autovalidateMode: state.user!.soldeFAKA <= 0
                                    ? null
                                    : AutovalidateMode.onUnfocus,
                                inputFormatters: [PhoneNumberFormatter()],
                                keyboardType: TextInputType.phone,
                                controller: idTextController,
                                decoration: InputDecoration(
                                  errorStyle: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                  errorMaxLines: 3,
                                  label: Text(
                                      context.appLoc.transfer_id_receiver_hint),
                                  labelStyle:
                                      TextStyle(color: Colors.grey.shade700),
                                  floatingLabelStyle:
                                      const TextStyle(color: tertiaryColor),
                                  hintStyle:
                                      TextStyle(color: Colors.grey.shade700),
                                  hintText: context.appLoc.ann_contact_hint,
                                  // icon: const Icon(Icons.person),
                                  suffixIcon: Icon(
                                    Ionicons.call,
                                    color: Colors.grey,
                                  ),
                                  fillColor: Colors.grey.shade300,
                                  filled: false,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    borderSide:
                                        BorderSide(color: tertiaryColor),
                                  ),
                                  // border: InputBorder.none,
                                ),
                                validator: (value) {
                                  if (value == null ||
                                      value.isEmpty ||
                                      !InputValidator.isValidPhoneNumber(
                                          value)) {
                                    return context
                                        .appLoc.register_tel_validation;
                                  } else if (value.replaceAll(" ", "") ==
                                      context
                                          .read<AppBloc>()
                                          .state
                                          .user!
                                          .phoneNumber
                                          .replaceAll(" ", "")) {
                                    return context.appLoc.selftransfert_error;
                                  }

                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(
                              height: largePadding,
                            ),
                            Container(
                              // padding: const EdgeInsets.symmetric(
                              //     horizontal: largePadding,
                              //     vertical: smallPadding),
                              // decoration: BoxDecoration(
                              //     color: Colors.grey.shade100,
                              //     borderRadius:
                              //         BorderRadius.circular(mediumPadding)),
                              child: TextFormField(
                                readOnly: state.user!.soldeFAKA <= 0,
                                keyboardType: TextInputType.number,
                                controller: amountTextController,
                                autovalidateMode: state.user!.soldeFAKA <= 0
                                    ? null
                                    : AutovalidateMode.onUnfocus,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                  // Allow only digits
                                  AmountFormatter()
                                  // Custom formatter for thousand separators
                                ],
                                decoration: InputDecoration(
                                  errorStyle: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                  errorMaxLines: 3,
                                  label: Text(
                                      context.appLoc.transfer_amount_send_hint),
                                  labelStyle:
                                      TextStyle(color: Colors.grey.shade700),
                                  floatingLabelStyle:
                                      const TextStyle(color: tertiaryColor),
                                  hintStyle:
                                      TextStyle(color: Colors.grey.shade700),
                                  suffixIcon: Image.asset(
                                    width: 24,
                                    height: 24,
                                    "assets/imgs/mips_coin.png",
                                    fit: BoxFit.cover,
                                  ),
                                  // suffix: state.user!.soldeFAKA <= 0
                                  //     ? null
                                  //     : const Text(
                                  //         "KARA",
                                  //         style: TextStyle(
                                  //           color: Colors.black,
                                  //           fontSize: 16,
                                  //         ),
                                  //       ),
                                  fillColor: Colors.grey.shade300,
                                  filled: false,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    borderSide:
                                        BorderSide(color: tertiaryColor),
                                  ),
                                  // border: InputBorder.none,
                                ),
                                validator: (value) {
                                  try {
                                    if (value == null ||
                                        value.isEmpty ||
                                        int.parse(value.replaceAll(" ", "")) <
                                            1 ||
                                        int.parse(value.replaceAll(" ", "")) >
                                            context
                                                .read<AppBloc>()
                                                .state
                                                .user!
                                                .soldeFAKA) {
                                      return context.appLoc
                                          .transfer_amount_send_error_validation(
                                              AppUtils.formatNumberWithSpaces(
                                                  state.user!.soldeFAKA));
                                    }
                                  } catch (e) {
                                    AppUtils.showDebugLog(
                                        runtimeType, e.toString());
                                  }

                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(
                              height: largePadding,
                            ),
                            Text(
                              "Motif",
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            const SizedBox(
                              height: mediumPadding,
                            ),
                            Wrap(
                              spacing: 5,
                              runSpacing: 5,
                              children: List.generate(
                                motifs.length,
                                (index) => ChoiceChip(
                                  label: motifs[index],
                                  showCheckmark: false,
                                  selected: _value == index,
                                  onSelected: (selected) {
                                    setState(() {
                                      _value = selected ? index : _value;
                                    });
                                  },
                                  color: WidgetStateProperty.resolveWith(
                                    (states) =>
                                        states.contains(WidgetState.selected)
                                            ? secondaryColor
                                            : Colors.white,
                                  ),
                                  labelPadding: EdgeInsets.zero,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: largePadding,
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: SizedBox(
                                height: 40,
                                child: FilledButton(
                                    style: ButtonStyle(
                                        shape: WidgetStatePropertyAll(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        16)))),
                                    onPressed: state.user!.soldeFAKA <= 0
                                        ? null
                                        : () {
                                            if (_formKey.currentState != null &&
                                                _formKey.currentState!
                                                    .validate()) {
                                              MessageDisplayerUtils
                                                  .showConfirmSendFakaDialog(
                                                context,
                                                amountTextController.text,
                                                (idTextController.text),
                                                () {
                                                  context.read<AppBloc>().add(
                                                      TransfertFakaEvent(
                                                          phoneReceiver:
                                                              idTextController
                                                                  .text,
                                                          amount: int.parse(
                                                              amountTextController
                                                                  .text
                                                                  .replaceAll(
                                                                      " ", "")),
                                                          motif: motifValues[
                                                              _value!]));
                                                },
                                              );
                                            }
                                          },
                                    child: Center(
                                        child: Text(
                                            context.appLoc.transferer_faka))),
                              ),
                            ),
                          ],
                        ),
                        // ),
                      ),
                    ],
                  ),
                ),
              );
            }
            return BaseScreen(
              useDefaultAnnonceSponsPart: true,
              title: Text(
                context.appLoc.transfer_screen_title,
                style: TextStyle(
                  fontFamily: "Pretendard",
                  color: Colors.black,
                ),
              ),
              content: RefreshIndicator(
                  onRefresh: () async {
                    context.read<AppBloc>().add(GetUserInfoEvent());
                  },
                  child: content),
              leading: IconButton(
                  onPressed: () {
                    context.pop();
                  },
                  icon: Icon(
                    Ionicons.chevron_back,
                    color: Colors.black,
                  )),
              backgroundColor: Colors.white,
              // appBarAction: [
              //   Row(children: [
              //     Directionality(
              //       textDirection: TextDirection.rtl,
              //       child: OutlinedButton(
              //           onPressed: () {
              //             context.read<AppBloc>().add(LogoutUserEvent());
              //           },
              //           child: Text(context.appLoc.logout)),
              //     ),
              //     const SizedBox(
              //       width: smallPadding,
              //     )
              //   ])
              // ],
            );
          },
        ),
      ),
    );
  }
}
