import 'package:MIPS/common/constants/constant.dart';
import 'package:MIPS/common/services/global_context_service.dart';
import 'package:MIPS/presentation/configurations/colors_list.dart';
import 'package:MIPS/presentation/configurations/extension_for_localization.dart';
import 'package:MIPS/presentation/screens/base/base_screen.dart';
import 'package:MIPS/presentation/screens/kara_partner/bloc/kara_partner_bloc.dart';
import 'package:MIPS/presentation/widgets/loading_widget.dart';
import 'package:MIPS/presentation/widgets/message_displayer_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:ionicons/ionicons.dart';

class KaraSubscriptionScreen extends StatefulWidget {
  const KaraSubscriptionScreen({super.key});

  @override
  State<KaraSubscriptionScreen> createState() => _KaraSubscriptionScreenState();
}

class _KaraSubscriptionScreenState extends State<KaraSubscriptionScreen> {
  final List<bool> _checkboxValues = [];
  final List<String> _allProvinces = [];
  final List<String> _selectedProvinces = [];
  final TextEditingController _slugController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _slugController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _slugController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      useDefaultAnnonceSponsPart: true,
      title: Text(
        context.appLoc.become_kara_partner,
        style: Theme.of(context).textTheme.titleLarge,
      ),
      content: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              // color: Colors.green,
              child: SvgPicture.asset("assets/imgs/illu_kara_partner.svg"),
            ),
            SizedBox(height: smallPadding),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: largePadding),
                child: Text(
                  context.appLoc.choose_province,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
            ),
            SizedBox(height: mediumPadding),
            BlocConsumer<KaraPartnerBloc, KaraPartnerState>(
              listener: (context, state) {
                if (state.karaProvinceStatus == KaraProvinceStatus.loaded &&
                    _checkboxValues.isEmpty) {
                  setState(() {
                    _checkboxValues
                      ..clear()
                      ..addAll(List.filled(state.provinces.length, false));
                    _allProvinces.clear();
                    for (int i = 0; i < state.provinces.length; i++) {
                      _allProvinces.add(state.provinces[i].nom);
                    }
                  });
                }
              },
              builder: (context, state) {
                if (state.karaProvinceStatus == KaraProvinceStatus.loaded) {
                  return ListView.separated(
                    padding: EdgeInsets.all(largePadding),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return CheckboxListTile(
                        contentPadding: EdgeInsets.all(0),
                        value: _checkboxValues[index],
                        onChanged: (bool? value) {
                          setState(() {
                            _checkboxValues[index] = value!;
                            _selectedProvinces.clear();
                            for (int i = 0; i < _allProvinces.length; i++) {
                              if (_checkboxValues[i]) {
                                _selectedProvinces.add(_allProvinces[i]);
                              }
                            }
                          });
                        },
                        title: Text(
                          state.provinces[index].nom,
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return Divider(
                        height: 0,
                        color: Colors.grey.shade300,
                      );
                    },
                    itemCount: state.provinces.length,
                  );
                }
                return Padding(
                  padding: const EdgeInsets.all(largePadding),
                  child: AppLoadingWidget(),
                );
              },
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: largePadding),
                child: Text(
                  context.appLoc.add_the_ad_id,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
            ),
            SizedBox(height: largePadding),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: largePadding),
              // decoration: BoxDecoration(
              //     color: Colors.grey.shade100,
              //     borderRadius: BorderRadius.circular(mediumPadding)),
              child: TextFormField(
                autovalidateMode: AutovalidateMode.onUnfocus,
                controller: _slugController,
                decoration: InputDecoration(
                  errorStyle: const TextStyle(fontWeight: FontWeight.bold),
                  errorMaxLines: 3,
                  labelText: context.appLoc.ad_id,
                  hintText: "Ex: QM00000000001",
                  // label: Text("Entrez l'identifiant de l'annonce (Slug)"),
                  labelStyle: TextStyle(color: Colors.grey.shade700),
                  floatingLabelStyle: const TextStyle(color: tertiaryColor),
                  fillColor: Colors.grey.shade300,
                  filled: false,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(color: tertiaryColor),
                  ),
                  // border: InputBorder.none,
                ),
                onChanged: (value) {
                  print(value);
                  print(_slugController.text);
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return context.appLoc.ad_id_is_required;
                  }
                  return null;
                },
              ),
            ),
            SizedBox(height: largePadding),
            Padding(
              padding:
                  const EdgeInsets.only(right: largePadding + smallPadding),
              child: Align(
                alignment: Alignment.bottomRight,
                child: SizedBox(
                  height: 40,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)))),
                    onPressed: (_checkboxValues.any((value) => value) &&
                            _slugController.text.isNotEmpty)
                        ? () {
                            context.read<KaraPartnerBloc>().add(
                                KaraSubscriptionLoaded(
                                    provinces: _selectedProvinces,
                                    slug: _slugController.text));
                          }
                        : null,
                    child: BlocConsumer<KaraPartnerBloc, KaraPartnerState>(
                      listener: (context, state) {
                        if (state.karaSubscriptionStatus ==
                            KaraSubscriptionStatus.sent) {
                          MessageDisplayerUtils.showToastMessage(
                              GlobalContextService.snackbarKey.currentContext!
                                  .appLoc.request_successfully_sent);
                          context.pop();
                        }
                        if (state.karaSubscriptionStatus ==
                            KaraSubscriptionStatus.notExist) {
                          MessageDisplayerUtils.showToastMessage(
                              GlobalContextService.snackbarKey.currentContext!
                                  .appLoc.ad_id_doesnt_exist);
                          context.pop();
                        }
                        if (state.karaSubscriptionStatus ==
                            KaraSubscriptionStatus.pendding) {
                          MessageDisplayerUtils.showToastMessage(
                              GlobalContextService.snackbarKey.currentContext!
                                  .appLoc.ad_is_already_pending);
                          context.pop();
                        }
                      },
                      builder: (context, state) {
                        print("STATE : ${state.karaSubscriptionStatus}");
                        if (state.karaSubscriptionStatus ==
                            KaraSubscriptionStatus.sending) {
                          return Row(
                            mainAxisSize: MainAxisSize.min,
                            spacing: 5,
                            children: [
                              AppLoadingWidget(
                                size: 12,
                                color: Colors.white,
                              ),
                              Text(
                                context.appLoc.submit_your_request,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(color: Colors.white),
                              )
                            ],
                          );
                        }
                        return Text(context.appLoc.submit_your_request);
                      },
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: largePadding),
          ],
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
      backgroundColor: Colors.white,
    );
  }
}
