import 'package:MIPS/common/constants/constant.dart';
import 'package:MIPS/presentation/configurations/colors_list.dart';
import 'package:MIPS/presentation/configurations/extension_for_localization.dart';
import 'package:MIPS/presentation/routes/route.dart';
import 'package:MIPS/presentation/routes/router.dart';
import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ionicons/ionicons.dart';
import 'package:mocktail/mocktail.dart';
import 'package:terminate_restart/terminate_restart.dart';
import '../../bloc/app_bloc.dart';
import '../base/base_screen.dart';

class SettingsScreen extends StatelessWidget {
  final String langInitial;
  const SettingsScreen({super.key, required this.langInitial});

  @override
  Widget build(BuildContext context) {
    const List<String> languagesCode = ["af", "fr", "en", "ko", "zh"];
    List<String> languages = [
      context.appLoc.setting_langue_mg,
      context.appLoc.setting_langue_fr,
      context.appLoc.setting_langue_en,
      context.appLoc.setting_langue_ko,
      context.appLoc.setting_langue_zh
    ];
    Map<String, String> langMap = {
      "af": languages.first,
      "fr": languages[1],
      "en": languages[2],
      "ko": languages[3],
      "zh": languages.last
    };
    String selectedLangue =
        langMap[context.read<AppBloc>().userPrefRepositoryImpl.getLang()] ??
            "fr";

    const List<String> textScalers = ["0.75", "0.875", "1.0", "1.125", "1.25"];
    List<String> textSizes = [
      context.appLoc.text_very_small,
      context.appLoc.text_small,
      context.appLoc.text_medium,
      context.appLoc.text_large,
      context.appLoc.text_very_large,
    ];
    Map<String, String> textScalersMap =
        Map.fromIterables(textScalers, textSizes);
    String selectedSize =
        textScalersMap[context.read<AppBloc>().state.textScale.toString()] ??
            "1.0";

    return BaseScreen(
      useDefaultAnnonceSponsPart: true,
      content: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(largePadding),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                spacing: 10.0,
                children: [
                  // Icon(
                  //   Ionicons.globe,
                  //   size: 32,
                  //   color: Colors.black,
                  // ),
                  Expanded(
                      child: Text(
                    context.appLoc.setting_langue,
                    style: Theme.of(context).textTheme.titleLarge,
                  )),
                ],
              ),
              const SizedBox(height: mediumPadding),
              Divider(color: Colors.grey.shade300),
              Column(
                children: List.generate(
                  languages.length,
                  (index) => RadioListTile(
                    controlAffinity: ListTileControlAffinity.trailing,
                    radioScaleFactor: 0.75,
                    contentPadding: EdgeInsets.zero,
                    title: Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      spacing: 10.0,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade200),
                          ),
                          child: CountryFlag.fromLanguageCode(
                            (languagesCode[index] == "af")
                                ? "mg"
                                : languagesCode[index],
                            theme: ImageTheme(
                              height: 24,
                              width: 32,
                              // shape: RoundedRectangle(8),
                            ),
                          ),
                        ),
                        Text(
                          languages[index],
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ],
                    ),
                    value: languages[index],
                    groupValue: selectedLangue,
                    onChanged: (value) {
                      selectedLangue = value!;
                      context.read<AppBloc>().add(
                          LanguageChangeEvent(langCode: languagesCode[index]));
                    },
                  ),
                ),
              ),
              // DropdownButtonFormField(
              //   decoration: const InputDecoration(
              //       border: InputBorder.none,
              //       prefixIcon: Icon(Icons.language),
              //       fillColor: Colors.white,
              //       filled: true),
              //   value: context.read<AppBloc>().userPrefRepositoryImpl.getLang(),
              //   items: [
              //     DropdownMenuItem(
              //       value: "fr",
              //       child: Text(context.appLoc.setting_langue_fr),
              //     ),
              //     DropdownMenuItem(
              //       value: "en",
              //       child: Text(context.appLoc.setting_langue_en),
              //     ),
              //     DropdownMenuItem(
              //       value: "ko",
              //       child: Text(context.appLoc.setting_langue_ko),
              //     ),
              //     DropdownMenuItem(
              //       value: "zh",
              //       child: Text(context.appLoc.setting_langue_zh),
              //     ),
              //   ],
              //   onChanged: (value) {
              //     context
              //         .read<AppBloc>()
              //         .add(LanguageChangeEvent(langCode: value!));
              //   },
              // ),
              // Container(
              //   padding: const EdgeInsets.symmetric(horizontal: mediumPadding),
              //   decoration: BoxDecoration(color: Colors.white),
              //   child: TextFormField(
              //     readOnly: true,
              //     autovalidateMode: AutovalidateMode.onUserInteraction,
              //     // initialValue:
              //     //     context.read<AppBloc>().userPrefRepositoryImpl.getLang(),
              //     controller: languageController,
              //     onTap: () {
              //       showModalBottomSheet(
              //         context: context,
              //         constraints: BoxConstraints(
              //           minWidth: MediaQuery.of(context).size.width,
              //         ),
              //         shape: RoundedRectangleBorder(
              //           borderRadius: BorderRadius.only(
              //             topLeft: Radius.circular(16),
              //             topRight: Radius.circular(16),
              //           ),
              //           side: BorderSide(color: Colors.grey),
              //         ),
              //         builder: (context) => ListView.separated(
              //             shrinkWrap: true,
              //             physics: const NeverScrollableScrollPhysics(),
              //             itemCount: languages.length,
              //             separatorBuilder: (context, index) =>
              //                 Divider(height: 1, color: Colors.grey),
              //             itemBuilder: (context, index) {
              //               return TextButton(
              //                 style: ButtonStyle(
              //                   overlayColor:
              //                       WidgetStatePropertyAll(Colors.grey),
              //                   shape: WidgetStatePropertyAll(
              //                     RoundedRectangleBorder(
              //                       borderRadius: BorderRadius.circular(16),
              //                       // side: BorderSide(color: Colors.grey),
              //                     ),
              //                   ),
              //                   fixedSize: WidgetStatePropertyAll(Size(
              //                       MediaQuery.of(context).size.width, 40)),
              //                 ),
              //                 onPressed: () {
              //                   languageController.text = languages[index];
              //                   context.read<AppBloc>().add(LanguageChangeEvent(
              //                       langCode: languagesCode[index]));
              //                   context.pop();
              //                 },
              //                 child: Row(
              //                   children: [
              //                     CountryFlag.fromLanguageCode(
              //                       languagesCode[index],
              //                       theme: ImageTheme(
              //                         height: 24,
              //                         width: 32,
              //                         shape: RoundedRectangle(8),
              //                       ),
              //                     ),
              //                     const SizedBox(width: mediumPadding),
              //                     Text(
              //                       languages[index],
              //                       style: TextStyle(
              //                         color: Colors.black,
              //                         fontFamily: "Pretendard",
              //                       ),
              //                     ),
              //                   ],
              //                 ),
              //               );
              //             }),
              //       );
              //     },
              //     decoration: InputDecoration(
              //       // icon: const Icon(Ionicons.earth_outline),
              //       icon: CountryFlag.fromLanguageCode(
              //         context.read<AppBloc>().userPrefRepositoryImpl.getLang(),
              //         theme: ImageTheme(
              //           height: 24,
              //           width: 32,
              //           shape: RoundedRectangle(8),
              //         ),
              //       ),
              //       border: InputBorder.none,
              //     ),
              //   ),
              // ),
              const SizedBox(height: largePadding * 2),
              Row(
                spacing: 10.0,
                children: [
                  // Icon(
                  //   Ionicons.text_outline,
                  //   size: 32,
                  //   color: Colors.black,
                  // ),
                  Expanded(
                      child: Text(
                    context.appLoc.setting_font_size,
                    style: Theme.of(context).textTheme.titleLarge,
                  )),
                ],
              ),
              const SizedBox(height: mediumPadding),
              Divider(color: Colors.grey.shade300),
              Column(
                children: List.generate(
                  textSizes.length,
                  (index) => RadioListTile(
                    controlAffinity: ListTileControlAffinity.trailing,
                    radioScaleFactor: 0.75,
                    contentPadding: EdgeInsets.zero,
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(textSizes[index],
                            textScaler: TextScaler.linear(
                                double.parse(textScalers[index]) /
                                    context.read<AppBloc>().state.textScale)),
                      ],
                    ),
                    value: textSizes[index],
                    groupValue: selectedSize,
                    onChanged: (value) {
                      selectedSize = value!;
                      BlocProvider.of<AppBloc>(context).add(
                          ScaleChangedEvent(double.parse(textScalers[index])));
                    },
                  ),
                ),
              ),
              // DropdownButtonFormField(
              //   decoration: const InputDecoration(
              //       border: InputBorder.none,
              //       prefixIcon: Icon(Icons.format_size),
              //       fillColor: Colors.white,
              //       filled: true),
              //   value: context.read<AppBloc>().state.textScale,
              //   items: <DropdownMenuItem<double>>[
              //     DropdownMenuItem(
              //       value: 0.75,
              //       child: Text(context.appLoc.text_very_small,
              //           textScaler: TextScaler.linear(
              //               0.75 / context.read<AppBloc>().state.textScale)),
              //     ),
              //     DropdownMenuItem(
              //       value: 0.875,
              //       child: Text(context.appLoc.text_small,
              //           textScaler: TextScaler.linear(
              //               0.875 / context.read<AppBloc>().state.textScale)),
              //     ),
              //     DropdownMenuItem(
              //       value: 1,
              //       child: Text(context.appLoc.text_medium,
              //           textScaler: TextScaler.linear(
              //               1 / context.read<AppBloc>().state.textScale)),
              //     ),
              //     DropdownMenuItem(
              //       value: 1.125,
              //       child: Text(context.appLoc.text_large,
              //           textScaler: TextScaler.linear(
              //               1.125 / context.read<AppBloc>().state.textScale)),
              //     ),
              //     DropdownMenuItem(
              //       value: 1.25,
              //       child: Text(
              //         context.appLoc.text_very_large,
              //         textScaler: TextScaler.linear(
              //             1.25 / context.read<AppBloc>().state.textScale),
              //       ),
              //     ),
              //   ],
              //   onChanged: (value) {
              //     BlocProvider.of<AppBloc>(context)
              //         .add(ScaleChangedEvent(value!));
              //   },
              // ),
              // Container(
              //   padding: const EdgeInsets.symmetric(horizontal: largePadding),
              //   decoration: BoxDecoration(color: Colors.white),
              //   child: TextFormField(
              //     readOnly: true,
              //     autovalidateMode: AutovalidateMode.onUserInteraction,
              //     // initialValue:
              //     //     context.read<AppBloc>().userPrefRepositoryImpl.getLang(),
              //     controller: textScalerController,
              //     onTap: () {
              //       showModalBottomSheet(
              //         context: context,
              //         constraints: BoxConstraints(
              //           minWidth: MediaQuery.of(context).size.width,
              //         ),
              //         shape: RoundedRectangleBorder(
              //           borderRadius: BorderRadius.only(
              //             topLeft: Radius.circular(16),
              //             topRight: Radius.circular(16),
              //           ),
              //           side: BorderSide(color: Colors.grey),
              //         ),
              //         builder: (context) => ListView.separated(
              //             shrinkWrap: true,
              //             physics: const NeverScrollableScrollPhysics(),
              //             itemCount: textScalers.length,
              //             separatorBuilder: (context, index) =>
              //                 Divider(height: 1, color: Colors.grey),
              //             itemBuilder: (context, index) {
              //               return TextButton(
              //                 style: ButtonStyle(
              //                   overlayColor:
              //                       WidgetStatePropertyAll(Colors.grey),
              //                   shape: WidgetStatePropertyAll(
              //                     RoundedRectangleBorder(
              //                       borderRadius: BorderRadius.circular(16),
              //                     ),
              //                   ),
              //                   fixedSize: WidgetStatePropertyAll(Size(
              //                       MediaQuery.of(context).size.width, 40)),
              //                 ),
              //                 onPressed: () {
              //                   textScalerController.text = textSizes[index];
              //                   BlocProvider.of<AppBloc>(context).add(
              //                       ScaleChangedEvent(
              //                           double.parse(textScalers[index])));
              //                   context.pop();
              //                 },
              //                 child: Text(
              //                   textSizes[index],
              //                   style: TextStyle(
              //                     color: Colors.black,
              //                     fontFamily: "Pretendard",
              //                   ),
              //                   textScaler: TextScaler.linear(
              //                       double.parse(textScalers[index]) /
              //                           context
              //                               .read<AppBloc>()
              //                               .state
              //                               .textScale),
              //                 ),
              //               );
              //             }),
              //       );
              //     },
              //     decoration: InputDecoration(
              //       icon: const Icon(Ionicons.text_outline),
              //       border: InputBorder.none,
              //     ),
              //   ),
              // ),
              if (context.read<AppBloc>().state.user != null &&
                  [1, 2, 3, 4].contains(context.read<AppBloc>().state.user!.id))
                Column(
                  children: [
                    const SizedBox(height: largePadding * 2),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Server(Temporary option)",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                    DropdownButtonFormField(
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          prefixIcon: Icon(Icons.developer_mode),
                          fillColor: Colors.white,
                          filled: true),
                      value: context
                          .read<AppBloc>()
                          .userPrefRepositoryImpl
                          .isModPreProd(),
                      items: const [
                        DropdownMenuItem(
                          value: false,
                          child: Text("PROD"),
                        ),
                        DropdownMenuItem(
                          value: true,
                          child: Text("Preprod"),
                        ),
                      ],
                      onChanged: (value) async {
                        context
                            .read<AppBloc>()
                            .userPrefRepositoryImpl
                            .setModPreProd(value ?? false);
                        await TerminateRestart.instance
                            .restartAppWithConfirmation(
                          context,
                          title: 'Restart need',
                          message: 'Do you want to restart now?',
                          terminate: true,
                        );
                      },
                    ),
                  ],
                ),
              const SizedBox(
                height: largePadding,
              ),
              Divider(color: Colors.grey.shade300),
              ListTile(
                contentPadding: EdgeInsets.zero,
                onTap: () {
                  AppRouter.go(context, RoutesNames.appAbout);
                },
                title: Row(
                  spacing: 10.0,
                  children: [
                    Icon(
                      Ionicons.information_circle,
                      size: 32,
                      color: Colors.black,
                    ),
                    Text(
                      context.appLoc.setting_about,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                ),
                trailing: const Icon(
                  Ionicons.chevron_forward,
                  size: 16,
                  // color: tertiaryColor,
                ),
              ),
            ],
          ),
        ),
      ),
      title: Text(
        context.appLoc.setting_title,
        style: TextStyle(
          fontFamily: "Pretendard",
          color: Colors.black,
        ),
      ),
      leading: IconButton(
        onPressed: () {
          context.pop();
        },
        icon: Icon(
          Ionicons.chevron_back,
          color: Colors.black,
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}
