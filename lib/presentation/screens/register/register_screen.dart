import 'package:MIPS/presentation/configurations/colors_list.dart';
import 'package:MIPS/presentation/configurations/extension_for_localization.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import '../../../common/common.dart';
import '../../bloc/app_bloc.dart';
import '../../widgets/message_displayer_utils.dart';
import '../base/base_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return RegisterScreenState();
  }
}

class RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _pseudoController = TextEditingController();
  final _mailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordConfirmationController = TextEditingController();
  final _anneDeNaissanceController = TextEditingController();
  bool _isMaleGenre = true;
  final _lieuDeResidenceController = TextEditingController();

  bool _showPassword = false;

  // String? _selectedProvince;

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      useDefaultAnnonceSponsPart: true,
      content: SingleChildScrollView(
        child: _buildScreenContent(context, context.read<AppBloc>().state),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            context.appLoc.inscription,
            style: TextStyle(
              fontFamily: "Pretendard",
              color: Colors.black,
            ),
          ),
          // Container(
          //   margin: EdgeInsets.symmetric(horizontal: 8),
          //   child: SizedBox(
          //     height: 35,
          //     child: FilledButton(
          //       style: ButtonStyle(
          //           shape: WidgetStatePropertyAll(RoundedRectangleBorder(
          //               borderRadius: BorderRadius.circular(16)))),
          //       onPressed: () {
          //         AppRouter.goPushNamedAndRemoveUntil(
          //             context, RoutesNames.login);
          //       },
          //       child: Center(
          //         child: Text(context.appLoc.connexion),
          //       ),
          //     ),
          //   ),
          // ),
        ],
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

  Widget _buildScreenContent(BuildContext context, AppState state) {
    return BlocListener<AppBloc, AppState>(
      listenWhen: (previous, current) {
        return previous.userStatus != current.userStatus;
      },
      listener: (context, state) {
        if (state.userStatus == UserStatus.error) {
          context.pop();
          context.pop();
          MessageDisplayerUtils.showRegisterErrorDialog(
              context, state.errorMessage);
        } else if (state.userStatus == UserStatus.loading) {
          MessageDisplayerUtils.showRegisterLoadingDialog(context);
        } else if (state.userStatus == UserStatus.userConnected) {
          context.pop(); // quite page
          MessageDisplayerUtils.showToastMessage(
              context.appLoc.welcome_user(state.user?.pseudo ?? ""));
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Align(
          alignment: Alignment.topCenter,
          // child: AppPanelWidget(
          //   constraints: const BoxConstraints(maxWidth: 420),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  context.appLoc.register_intro,
                  // context.appLoc.register_title,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(
                  height: smallPadding,
                ),
                Text(
                  context.appLoc.register_text,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: Colors.grey),
                ),
                const SizedBox(
                  height: largePadding * 2,
                ),
                Container(
                  // padding: const EdgeInsets.symmetric(
                  //     horizontal: largePadding, vertical: smallPadding),
                  // decoration: BoxDecoration(
                  //     color: Colors.grey.shade100,
                  //     borderRadius: BorderRadius.circular(mediumPadding)),
                  child: TextFormField(
                    autovalidateMode: AutovalidateMode.onUnfocus,
                    keyboardType: TextInputType.phone,
                    controller: _phoneController,
                    inputFormatters: [PhoneNumberFormatter()],
                    decoration: InputDecoration(
                      errorStyle: const TextStyle(fontWeight: FontWeight.bold),
                      errorMaxLines: 3,
                      label: Text(context.appLoc.register_tel_hint),
                      labelStyle: TextStyle(color: Colors.grey.shade700),
                      floatingLabelStyle: const TextStyle(color: tertiaryColor),
                      hintStyle: TextStyle(color: Colors.grey.shade700),
                      hintText: context.appLoc.ann_contact_hint,
                      suffixIcon: const Icon(
                        Icons.phone,
                        color: Colors.grey,
                      ),
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
                    validator: (value) => (value == null ||
                            value.isEmpty ||
                            !InputValidator.isValidPhoneNumber(value))
                        ? context.appLoc.register_tel_validation
                        : null,
                  ),
                ),
                const SizedBox(
                  height: largePadding,
                ),
                Container(
                  // padding: const EdgeInsets.symmetric(
                  //     horizontal: largePadding, vertical: smallPadding),
                  // decoration: BoxDecoration(
                  //     color: Colors.grey.shade100,
                  //     borderRadius: BorderRadius.circular(mediumPadding)),
                  child: TextFormField(
                    autovalidateMode: AutovalidateMode.onUnfocus,
                    controller: _pseudoController,
                    decoration: InputDecoration(
                      errorStyle: const TextStyle(fontWeight: FontWeight.bold),
                      errorMaxLines: 3,
                      label: Text(context.appLoc.register_pseudo_hint),
                      labelStyle: TextStyle(color: Colors.grey.shade700),
                      floatingLabelStyle: const TextStyle(color: tertiaryColor),
                      hintStyle: TextStyle(color: Colors.grey.shade700),
                      hintText: "${context.appLoc.exemple_pref_hint}Andry",
                      suffixIcon: const Icon(
                        Ionicons.person,
                        color: Colors.grey,
                      ),
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
                    validator: (value) {
                      if ((value == null || value.isEmpty)) {
                        return context.appLoc.register_pseudo_validation;
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(
                  height: largePadding,
                ),
                Container(
                  child: TextFormField(
                    readOnly: true,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    keyboardType: TextInputType.datetime,
                    controller: _anneDeNaissanceController,
                    onTap: () {
                      _selectDate(context, _anneDeNaissanceController);
                    },
                    decoration: InputDecoration(
                      errorStyle: const TextStyle(fontWeight: FontWeight.bold),
                      errorMaxLines: 3,
                      label: Text(context.appLoc.register_yearofbirth_hint),
                      labelStyle: TextStyle(color: Colors.grey.shade700),
                      floatingLabelStyle: const TextStyle(color: tertiaryColor),
                      suffixIcon: const Icon(
                        Icons.calendar_today,
                        color: Colors.grey,
                      ),
                      fillColor: Colors.grey.shade300,
                      filled: false,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(color: tertiaryColor),
                      ),
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return context.appLoc.register_yearofbirth_validation;
                      }

                      try {
                        // Parse the date (now expecting dd/MM/yyyy format)
                        DateFormat format = DateFormat('dd/MM/yyyy');
                        DateTime birthDate = format.parse(value);

                        // Get today's date
                        DateTime today = DateTime.now();

                        // Calculate age
                        int age = today.year - birthDate.year;

                        // Adjust age if birthday hasn't occurred yet this year
                        if (today.month < birthDate.month ||
                            (today.month == birthDate.month &&
                                today.day < birthDate.day)) {
                          age--;
                        }

                        print("AGE: $age");
                        print(
                            "Birth date: ${birthDate.day}/${birthDate.month}/${birthDate.year}");
                        print(
                            "Today: ${today.day}/${today.month}/${today.year}");

                        if (age < 13) {
                          return context.appLoc.register_yearofbirth_validation;
                        }
                      } catch (e) {
                        print("Date parsing error: $e");
                        return context.appLoc.register_yearofbirth_validation;
                      }

                      return null;
                    },
                  ),
                ),
                // Container(
                //   // padding: const EdgeInsets.symmetric(
                //   //     horizontal: largePadding, vertical: smallPadding),
                //   // decoration: BoxDecoration(
                //   //     color: Colors.grey.shade100,
                //   //     borderRadius: BorderRadius.circular(mediumPadding)),
                //   child: TextFormField(
                //       readOnly: true,
                //       autovalidateMode: AutovalidateMode.onUserInteraction,
                //       keyboardType: TextInputType.datetime,
                //       controller: _anneDeNaissanceController,
                //       onTap: () {
                //         _selectDate(context, _anneDeNaissanceController);
                //       },
                //       decoration: InputDecoration(
                //         errorStyle:
                //             const TextStyle(fontWeight: FontWeight.bold),
                //         errorMaxLines: 3,
                //         label: Text(context.appLoc.register_yearofbirth_hint),
                //         labelStyle: TextStyle(color: Colors.grey.shade700),
                //         floatingLabelStyle:
                //             const TextStyle(color: tertiaryColor),
                //         suffixIcon: const Icon(
                //           Icons.calendar_today,
                //           color: Colors.grey,
                //         ),
                //         fillColor: Colors.grey.shade300,
                //         filled: false,
                //         border: OutlineInputBorder(
                //           borderRadius: BorderRadius.circular(16),
                //         ),
                //         focusedBorder: OutlineInputBorder(
                //           borderRadius: BorderRadius.circular(16),
                //           borderSide: BorderSide(color: tertiaryColor),
                //         ),
                //         // border: InputBorder.none,
                //       ),
                //       validator: (String? value) {
                //         if (value == null || value.isEmpty) {
                //           return context.appLoc.register_yearofbirth_validation;
                //         } else {
                //           try {
                //             DateFormat format = DateFormat('dd/MM/yyyy');
                //             DateTime birthDate = format.parse(value);

                //             // Get today's date
                //             DateTime today = DateTime.now();

                //             // Calculate age
                //             int age = today.year - birthDate.year;
                //             // Adjust age if the birthday hasn't occurred yet this year
                //             print("AGE : ${age}");
                //             print(
                //                 "TODAY MONTH ${today.month}, BIRTHDATE MONTH ${birthDate.month}");
                //             print(
                //                 "TODAY DAY ${today.day}, BIRTHDATE DAY ${birthDate.day}");

                //             if (today.month < birthDate.month ||
                //                 (today.month == birthDate.month &&
                //                     today.day < birthDate.day)) {
                //               age--;
                //             }
                //             if (age < 13) {
                //               return context
                //                   .appLoc.register_yearofbirth_validation;
                //             }
                //           } catch (e) {
                //             return context
                //                 .appLoc.register_yearofbirth_validation;
                //           }
                //         }
                //         return null;
                //       }),
                // ),
                const SizedBox(
                  height: largePadding,
                ),
                TextFormField(
                  readOnly: true,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: _lieuDeResidenceController,
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      constraints: BoxConstraints(
                        minWidth: MediaQuery.of(context).size.width,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16),
                        ),
                        side: BorderSide(color: Colors.grey),
                      ),
                      builder: (context) => ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: provinces.length,
                          separatorBuilder: (context, index) =>
                              Divider(height: 1, color: Colors.grey),
                          itemBuilder: (context, index) {
                            return TextButton(
                              style: ButtonStyle(
                                overlayColor:
                                    WidgetStatePropertyAll(Colors.grey),
                                shape: WidgetStatePropertyAll(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    // side: BorderSide(color: Colors.grey),
                                  ),
                                ),
                                fixedSize: WidgetStatePropertyAll(Size(
                                    MediaQuery.of(context).size.width, 40)),
                              ),
                              onPressed: () {
                                setState(() {
                                  _lieuDeResidenceController.text =
                                      provinces[index];
                                  context.pop();
                                });
                              },
                              child: Text(
                                provinces[index],
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: "Pretendard",
                                ),
                              ),
                            );
                          }),
                    );
                  },
                  decoration: InputDecoration(
                    errorStyle: const TextStyle(fontWeight: FontWeight.bold),
                    errorMaxLines: 3,
                    label: Text(context.appLoc.register_address_hint),
                    labelStyle: TextStyle(color: Colors.grey.shade700),
                    floatingLabelStyle: const TextStyle(color: tertiaryColor),
                    hintStyle: TextStyle(color: Colors.grey.shade700),
                    suffixIcon: const Icon(
                      Ionicons.location,
                      color: Colors.grey,
                    ),
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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return context.appLoc.register_address_validation;
                    }
                    return null;
                  },
                ),
                // Container(
                //   // padding: const EdgeInsets.symmetric(
                //   //     horizontal: largePadding, vertical: smallPadding),
                //   // decoration: BoxDecoration(
                //   //     color: Colors.grey.shade100,
                //   //     borderRadius: BorderRadius.circular(mediumPadding)),
                //   child: DropdownButtonFormField<String>(
                //     value: _selectedProvince,
                //     items: provinces.map((province) {
                //       return DropdownMenuItem<String>(
                //         value: province,
                //         child: Text(
                //           province,
                //           style: const TextStyle(fontWeight: FontWeight.normal),
                //         ),
                //       );
                //     }).toList(),
                //     onChanged: (value) {
                //       _selectedProvince = value;
                //       _lieuDeResidenceController.text = value ?? '';
                //     },
                //     decoration: InputDecoration(
                //       label: Text(context.appLoc.register_address_hint),
                //       labelStyle: TextStyle(color: Colors.grey.shade700),
                //       floatingLabelStyle: const TextStyle(color: tertiaryColor),
                //       hintStyle: TextStyle(color: Colors.grey.shade700),
                //       hintText: context.appLoc.choose_option,
                //       suffixIcon: const Icon(
                //         Icons.location_on,
                //         color: Colors.grey,
                //       ),
                //       fillColor: Colors.grey.shade300,
                //       filled: false,
                //       border: OutlineInputBorder(
                //         borderRadius: BorderRadius.circular(16),
                //       ),
                //       focusedBorder: OutlineInputBorder(
                //         borderRadius: BorderRadius.circular(16),
                //         borderSide: BorderSide(color: tertiaryColor),
                //       ),
                //       // border: InputBorder.none,
                //     ),
                //     validator: (value) {
                //       if (value == null || value.isEmpty) {
                //         return context.appLoc.register_address_validation;
                //       }
                //       return null;
                //     },
                //   ),
                // ),
                const SizedBox(
                  height: largePadding,
                ),
                Row(
                  children: [
                    Expanded(
                      child: RadioListTile(
                        // fillColor: WidgetStatePropertyAll(Colors.grey),
                        value: true,
                        groupValue: _isMaleGenre,
                        onChanged: (value) {
                          setState(() {
                            _isMaleGenre = value ?? true;
                          });
                        },
                        title: Text(context.appLoc.register_genre_masculin),
                      ),
                    ),
                    Expanded(
                      child: RadioListTile(
                        // fillColor: WidgetStatePropertyAll(Colors.grey),
                        value: false,
                        groupValue: _isMaleGenre,
                        onChanged: (value) {
                          setState(() {
                            _isMaleGenre = value ?? false;
                          });
                        },
                        title: Text(context.appLoc.register_genre_feminin),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: mediumPadding,
                ),
                Container(
                  // padding: const EdgeInsets.symmetric(
                  //     horizontal: largePadding, vertical: smallPadding),
                  // decoration: BoxDecoration(
                  //     color: Colors.grey.shade100,
                  //     borderRadius: BorderRadius.circular(mediumPadding)),
                  child: TextFormField(
                    autovalidateMode: AutovalidateMode.onUnfocus,
                    controller: _mailController,
                    decoration: InputDecoration(
                      errorStyle: const TextStyle(fontWeight: FontWeight.bold),
                      errorMaxLines: 3,
                      label: Text(
                          "${context.appLoc.register_mail_hint} (${context.appLoc.optional})"),
                      labelStyle: TextStyle(color: Colors.grey.shade700),
                      floatingLabelStyle: const TextStyle(color: tertiaryColor),
                      hintStyle: TextStyle(color: Colors.grey.shade700),
                      hintText:
                          "${context.appLoc.exemple_pref_hint}adresse@gmail.com",
                      suffixIcon: const Icon(
                        Icons.mail,
                        color: Colors.grey,
                      ),
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
                    validator: (value) {
                      if (!(value == null || value.isEmpty) &&
                          !InputValidator.isValidEmail(value)) {
                        return context.appLoc.register_mail_validation;
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(
                  height: largePadding * 2,
                ),
                Container(
                  // padding: const EdgeInsets.symmetric(
                  //     horizontal: largePadding, vertical: smallPadding),
                  // decoration: BoxDecoration(
                  //     color: Colors.grey.shade100,
                  //     borderRadius: BorderRadius.circular(mediumPadding)),
                  child: TextFormField(
                    autovalidateMode: AutovalidateMode.onUnfocus,
                    obscureText: !_showPassword,
                    controller: _passwordController,
                    decoration: InputDecoration(
                      errorStyle: const TextStyle(fontWeight: FontWeight.bold),
                      errorMaxLines: 3,
                      label: Text(context.appLoc.register_password_hint),
                      labelStyle: TextStyle(color: Colors.grey.shade700),
                      floatingLabelStyle: const TextStyle(color: tertiaryColor),
                      // icon: const Icon(Icons.lock),
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _showPassword = !_showPassword;
                            });
                          },
                          icon: !_showPassword
                              ? const Icon(
                                  Icons.visibility,
                                  color: Colors.grey,
                                )
                              : const Icon(
                                  Icons.visibility_off,
                                  color: Colors.grey,
                                )),
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
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          (value.length < minMdpLength ||
                              value.length > maxMdpLenght)) {
                        return context.appLoc.register_password_validation;
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(
                  height: mediumPadding,
                ),
                Container(
                  // padding: const EdgeInsets.symmetric(
                  //     horizontal: largePadding, vertical: smallPadding),
                  // decoration: BoxDecoration(
                  //     color: Colors.grey.shade100,
                  //     borderRadius: BorderRadius.circular(mediumPadding)),
                  child: TextFormField(
                    autovalidateMode: AutovalidateMode.onUnfocus,
                    obscureText: !_showPassword,
                    controller: _passwordConfirmationController,
                    decoration: InputDecoration(
                      errorStyle: const TextStyle(fontWeight: FontWeight.bold),
                      errorMaxLines: 3,
                      label: Text(context.appLoc.register_password2_hint),
                      labelStyle: TextStyle(color: Colors.grey.shade700),
                      floatingLabelStyle: const TextStyle(color: tertiaryColor),
                      // icon: const Icon(Icons.lock),
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _showPassword = !_showPassword;
                            });
                          },
                          icon: !_showPassword
                              ? const Icon(
                                  Icons.visibility,
                                  color: Colors.grey,
                                )
                              : const Icon(
                                  Icons.visibility_off,
                                  color: Colors.grey,
                                )),
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
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          (value != _passwordController.text)) {
                        return context.appLoc.register_password2_validation;
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(
                  height: largePadding,
                ),
                const SizedBox(height: largePadding * 2),
                SizedBox(
                  height: 40,
                  child: FilledButton(
                    style: ButtonStyle(
                        shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)))),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        MessageDisplayerUtils.showCGUDialog(context, () {
                          context.read<AppBloc>().add(RegisterEvent(
                                name: "",
                                pseudo: _pseudoController.text,
                                tokenORPassword: _passwordController.text,
                                isMasculin: _isMaleGenre,
                                lieuResidence: _lieuDeResidenceController.text,
                                anneeNaissance: _anneDeNaissanceController.text,
                                mail: _mailController.text,
                                phoneNumber: _phoneController.text,
                              ));
                        });
                      }
                    },
                    child: Center(child: Text(context.appLoc.btn_register)),
                  ),
                ),
              ],
            ),
          ),
          // ),
        ),
      ),
    );
  }

  Future<void> _selectDate(
      BuildContext context, TextEditingController textEditingController) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1920),
      lastDate: DateTime.now(),
      locale: Localizations.localeOf(context),
      confirmText: context.appLoc.confirm,
      cancelText: context.appLoc.cancel,
      helpText: Localizations.localeOf(context).languageCode == "af"
          ? 'Fidio daty'
          : null,
      fieldLabelText:
          Localizations.localeOf(context).languageCode == "af" ? 'Daty' : null,
    );

    if (picked != null && context.mounted) {
      // Format the date as dd/MM/yyyy to match the validator
      textEditingController.text = "${picked.day.toString().padLeft(2, '0')}/"
          "${picked.month.toString().padLeft(2, '0')}/"
          "${picked.year}";
    }
  }

  // Future<void> _selectDate(
  //     BuildContext context, TextEditingController textEditingController) async {
  //   final DateTime? picked = await showDatePicker(
  //     context: context,
  //     initialDate: DateTime.now(),
  //     firstDate: DateTime(1920),
  //     // Allow dates from 1900
  //     lastDate: DateTime.now(),
  //     // No future dates
  //     locale: Localizations.localeOf(context), // Localize the date picker
  //   );
  //   if (picked != null) {
  //     if (context.mounted) {
  //       textEditingController.text =
  //           DateFormat.yMd(Localizations.localeOf(context).languageCode)
  //               .format(picked);
  //     }
  //   }
  // }
}
