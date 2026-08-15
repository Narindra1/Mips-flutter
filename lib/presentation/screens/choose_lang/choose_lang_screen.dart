import 'package:mips/common/di/injections.dart';
import 'package:mips/presentation/bloc/app_bloc.dart';
import 'package:mips/presentation/configurations/extension_for_localization.dart';
import 'package:mips/presentation/routes/route.dart';
import 'package:mips/presentation/routes/router.dart';
import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:mips/presentation/l10n/app_localizations.dart';
import '../../../common/constants/constant.dart';
import '../../../data/repositories/userpref_repository_impl.dart';

class ChooseLangScreen extends StatefulWidget {
  const ChooseLangScreen({super.key});

  @override
  State<StatefulWidget> createState() => ChooseLangScreenState();
}

class ChooseLangScreenState extends State<ChooseLangScreen> {
  String selectedLang = "";

  @override
  void initState() {
    selectedLang = GetIt.instance<UserPrefRepositoryImpl>().getLang();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(mediumPadding),
            child: Image.asset("assets/imgs/ic_mahafaka.png"),
          ),
        ),
        title: Text(
          context.appLoc.choose_langue,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(largePadding),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 200,
                  height: 200,
                  child: SvgPicture.asset("assets/imgs/illu_select_lang.svg"),
                ),
                // AppPanelWidget(
                //   child:
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    RadioListTile(
                      value: "af",
                      groupValue: selectedLang,
                      radioScaleFactor: 0.75,
                      onChanged: (value) {
                        if (value != null) {
                          context.read<AppBloc>().add(
                            LanguageChangeEvent(langCode: value),
                          );
                          setState(() {
                            selectedLang = value;
                          });
                        }
                      },
                      title: Row(
                        spacing: 10.0,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade200),
                            ),
                            child: CountryFlag.fromLanguageCode(
                              "mg",
                              theme: ImageTheme(
                                height: 24,
                                width: 32,
                                // shape: RoundedRectangle(8),
                              ),
                            ),
                          ),
                          Text(context.appLoc.setting_langue_mg),
                        ],
                      ),
                      controlAffinity: ListTileControlAffinity.trailing,
                    ),
                    RadioListTile(
                      value: "fr",
                      groupValue: selectedLang,
                      radioScaleFactor: 0.75,
                      onChanged: (value) {
                        if (value != null) {
                          context.read<AppBloc>().add(
                            LanguageChangeEvent(langCode: value),
                          );
                          setState(() {
                            selectedLang = value;
                          });
                        }
                      },
                      title: Row(
                        spacing: 10.0,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade200),
                            ),
                            child: CountryFlag.fromLanguageCode(
                              "fr",
                              theme: ImageTheme(
                                height: 24,
                                width: 32,
                                // shape: RoundedRectangle(8),
                              ),
                            ),
                          ),
                          Text(context.appLoc.setting_langue_fr),
                        ],
                      ),
                      controlAffinity: ListTileControlAffinity.trailing,
                    ),
                    RadioListTile(
                      value: "en",
                      groupValue: selectedLang,
                      radioScaleFactor: 0.75,
                      onChanged: (value) {
                        if (value != null) {
                          context.read<AppBloc>().add(
                            LanguageChangeEvent(langCode: value),
                          );
                          setState(() {
                            selectedLang = value;
                          });
                        }
                      },
                      title: Row(
                        spacing: 10.0,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade200),
                            ),
                            child: CountryFlag.fromLanguageCode(
                              "en",
                              theme: ImageTheme(
                                height: 24,
                                width: 32,
                                // shape: RoundedRectangle(8),
                              ),
                            ),
                          ),
                          Text(context.appLoc.setting_langue_en),
                        ],
                      ),
                      controlAffinity: ListTileControlAffinity.trailing,
                    ),
                    RadioListTile(
                      value: "ko",
                      groupValue: selectedLang,
                      radioScaleFactor: 0.75,
                      onChanged: (value) {
                        if (value != null) {
                          context.read<AppBloc>().add(
                            LanguageChangeEvent(langCode: value),
                          );
                          setState(() {
                            selectedLang = value;
                          });
                        }
                      },
                      title: Row(
                        spacing: 10.0,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade200),
                            ),
                            child: CountryFlag.fromLanguageCode(
                              "ko",
                              theme: ImageTheme(
                                height: 24,
                                width: 32,
                                // shape: RoundedRectangle(8),
                              ),
                            ),
                          ),
                          Text(context.appLoc.setting_langue_ko),
                        ],
                      ),
                      controlAffinity: ListTileControlAffinity.trailing,
                    ),
                    RadioListTile(
                      value: "zh",
                      groupValue: selectedLang,
                      radioScaleFactor: 0.75,
                      onChanged: (value) {
                        if (value != null) {
                          context.read<AppBloc>().add(
                            LanguageChangeEvent(langCode: value),
                          );
                          setState(() {
                            selectedLang = value;
                          });
                        }
                      },
                      title: Row(
                        spacing: 10.0,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade200),
                            ),
                            child: CountryFlag.fromLanguageCode(
                              "zh",
                              theme: ImageTheme(height: 24, width: 32),
                            ),
                          ),
                          Text(context.appLoc.setting_langue_zh),
                        ],
                      ),
                      controlAffinity: ListTileControlAffinity.trailing,
                    ),
                  ],
                ),
                // ),
                const SizedBox(height: largePadding),
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: SizedBox(
                    height: 40,
                    child: FilledButton.icon(
                      style: ButtonStyle(
                        shape: WidgetStatePropertyAll(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                      ),
                      icon: const Icon(Icons.keyboard_arrow_right),
                      onPressed: () {
                        getIt<UserPrefRepositoryImpl>().setIsFirstTime(false);
                        context.read<AppBloc>().add(LoadAnnoncePopupEvent());
                        AppRouter.goPushNamedAndRemoveUntil(
                          context,
                          RoutesNames.home,
                        );
                      },
                      label: Center(
                        child: Text(AppLocalizations.of(context)!.continuer),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: largePadding + 64),
                const SizedBox(height: largePadding + 64),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
