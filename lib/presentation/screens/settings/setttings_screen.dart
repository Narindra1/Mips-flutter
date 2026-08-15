import 'package:mips/common/constants/constant.dart';
import 'package:mips/presentation/configurations/extension_for_localization.dart';
import 'package:mips/presentation/routes/route.dart';
import 'package:mips/presentation/routes/router.dart';
import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
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
      context.appLoc.setting_langue_zh,
    ];
    Map<String, String> langMap = {
      "af": languages.first,
      "fr": languages[1],
      "en": languages[2],
      "ko": languages[3],
      "zh": languages.last,
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
    Map<String, String> textScalersMap = Map.fromIterables(
      textScalers,
      textSizes,
    );
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
                  // const Icon(
                  //   Ionicons.globe,
                  //   size: 32,
                  //   color: Colors.black,
                  // ),
                  Expanded(
                    child: Text(
                      context.appLoc.setting_langue,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
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
                        LanguageChangeEvent(langCode: languagesCode[index]),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: largePadding * 2),
              Row(
                spacing: 10.0,
                children: [
                  Expanded(
                    child: Text(
                      context.appLoc.setting_font_size,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
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
                        Text(
                          textSizes[index],
                          textScaler: TextScaler.linear(
                            double.parse(textScalers[index]) /
                                context.read<AppBloc>().state.textScale,
                          ),
                        ),
                      ],
                    ),
                    value: textSizes[index],
                    groupValue: selectedSize,
                    onChanged: (value) {
                      selectedSize = value!;
                      BlocProvider.of<AppBloc>(context).add(
                        ScaleChangedEvent(double.parse(textScalers[index])),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: largePadding),
              Divider(color: Colors.grey.shade300),
              ListTile(
                contentPadding: EdgeInsets.zero,
                onTap: () {
                  AppRouter.go(context, RoutesNames.appAbout);
                },
                title: Row(
                  spacing: 10.0,
                  children: [
                    const Icon(Icons.info, size: 32, color: Colors.black),
                    Text(
                      context.appLoc.setting_about,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                ),
                trailing: const Icon(
                  Icons.chevron_right_outlined,
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
        style: TextStyle(fontFamily: "Pretendard", color: Colors.black),
      ),
      leading: IconButton(
        onPressed: () {
          context.pop();
        },
        icon: const Icon(Icons.chevron_left_outlined, color: Colors.black),
      ),
      backgroundColor: Colors.white,
    );
  }
}
