import 'package:mips/presentation/configurations/colors_list.dart';
import 'package:mips/presentation/configurations/extension_for_localization.dart';
import 'package:mips/presentation/routes/route.dart';
import 'package:mips/presentation/routes/router.dart';
import 'package:mips/presentation/widgets/loading_image_cache_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../common/common.dart';
import '../../bloc/app_bloc.dart';
import '../../widgets/message_displayer_utils.dart';
import '../base/base_screen.dart';

class ModifyUserInfoScreen extends StatefulWidget {
  const ModifyUserInfoScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return ModifyUserInfoScreenState();
  }
}

class ModifyUserInfoScreenState extends State<ModifyUserInfoScreen> {
  final _formKey = GlobalKey<FormState>();
  final _pseudoController = TextEditingController();
  final _mailController = TextEditingController();
  final _contactController = TextEditingController();
  final _lieu_de_residenceController = TextEditingController();
  // String? _selectedProvince;
  bool? _userInfoModified = false;

  @override
  void initState() {
    _pseudoController.text = context.read<AppBloc>().state.user?.pseudo ?? "";
    _mailController.text = context.read<AppBloc>().state.user?.mail ?? "";
    _lieu_de_residenceController.text =
        context.read<AppBloc>().state.user?.lieuResidence ?? "";
    _contactController.text =
        context.read<AppBloc>().state.user?.contactFormatted ?? "";
    // _selectedProvince = provinces.contains(
    //         context.read<AppBloc>().state.user?.lieuResidence ?? "Nowhere")
    //     ? context.read<AppBloc>().state.user?.lieuResidence ?? "Nowhere"
    //     : null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      useDefaultAnnonceSponsPart: true,
      content: SingleChildScrollView(
        padding: EdgeInsets.all(8),
        child: _buildScreenContent(context, context.read<AppBloc>().state),
      ),
      title: Text(
        context.appLoc.profil,
        // context.appLoc.modify_profil_title,
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

  Widget _buildScreenContent(BuildContext context, AppState state) {
    return BlocListener<AppBloc, AppState>(
      listenWhen: (previous, current) {
        print("USER PREVIOUS STATUS : ${previous.userStatus}");
        print("USER CURRENT STATUS : ${current.userStatus}");
        print("USER PSEUDO : ${state.user?.pseudo}");

        return (previous.userStatus != current.userStatus) &&
            (_pseudoController.text != state.user?.pseudo ||
                _mailController.text != state.user?.mail ||
                _lieu_de_residenceController.text !=
                    state.user?.lieuResidence) &&
            (_userInfoModified ?? false);
      },
      listener: (context, state) {
        print("USER STATUS : ${state.userStatus}");
        if (state.userStatus == UserStatus.error) {
          // the login screen listen too, so a double dialog appear
          // Navigator.pop(context);
          context.pop();
          MessageDisplayerUtils.showErrorDialog(context, state.errorMessage);
        } else if (state.userStatus == UserStatus.loading) {
          MessageDisplayerUtils.showLoadingDialog(context);
        } else if (state.userStatus == UserStatus.userConnected) {
          context.pop(); // ferme le dialog
          context.pop(); // quite page
        }
      },
      child: Align(
        alignment: Alignment.topCenter,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: largePadding),
              ClipRRect(
                borderRadius: BorderRadius.circular(48),
                child: Container(
                  width: 96, // diameter = radius * 2
                  height: 96,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.amber,
                  ),
                  child: CachedNetworkImage(
                    imageUrl:
                        context.read<AppBloc>().state.user?.avatarUrl ?? " ",
                    fit: BoxFit.cover,
                    progressIndicatorBuilder: (context, url, progress) =>
                        const LoadingImageCacheWidget(),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error, size: 96),
                  ),
                ),
              ),
              const SizedBox(height: smallPadding),
              Text(
                context.appLoc.menu_profil_avatar_desc,
                style: Theme.of(
                  context,
                ).textTheme.titleSmall?.copyWith(color: Colors.grey.shade700),
              ),
              const SizedBox(height: smallPadding),
              SizedBox(
                height: 40,
                child: OutlinedButton(
                  style: ButtonStyle(
                    shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                  onPressed: () {
                    AppRouter.go(context, RoutesNames.achatAvatar);
                  },
                  child: Text(context.appLoc.avatar),
                ),
              ),
              const SizedBox(height: largePadding),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  // "Modifier votre profil",
                  context.appLoc.modify_profil_title,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              const SizedBox(height: largePadding),
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
                    suffixIcon: const Icon(Icons.person, color: Colors.grey),
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
              const SizedBox(height: largePadding),
              Container(
                // padding: const EdgeInsets.symmetric(
                //     horizontal: largePadding, vertical: smallPadding),
                // decoration: BoxDecoration(
                //     color: Colors.grey.shade100,
                //     borderRadius: BorderRadius.circular(mediumPadding)),
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.disabled,
                  readOnly: true,
                  enabled: false,
                  controller: _contactController,
                  decoration: InputDecoration(
                    errorStyle: const TextStyle(fontWeight: FontWeight.bold),
                    errorMaxLines: 3,
                    label: Text(context.appLoc.ann_contact_title),
                    labelStyle: TextStyle(color: Colors.grey.shade700),
                    floatingLabelStyle: const TextStyle(color: tertiaryColor),
                    hintStyle: TextStyle(color: Colors.grey.shade700),
                    hintText: "${context.appLoc.exemple_pref_hint}Andry",
                    suffixIcon: const Icon(Icons.phone, color: Colors.grey),
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
              // Container(
              //   padding: const EdgeInsets.symmetric(
              //       horizontal: largePadding, vertical: smallPadding),
              //   decoration: BoxDecoration(
              //       color: Colors.grey.shade100,
              //       borderRadius: BorderRadius.circular(mediumPadding)),
              //   child: TextFormField(
              //     autovalidateMode: AutovalidateMode.onUnfocus,
              //     controller: _pseudoController,
              //     decoration: InputDecoration(
              //         errorStyle: const TextStyle(fontWeight: FontWeight.bold),
              //         errorMaxLines: 3,
              //         label: Text(context.appLoc.register_pseudo_hint),
              //         labelStyle: TextStyle(color: Colors.grey.shade700),
              //         floatingLabelStyle: const TextStyle(color: tertiaryColor),
              //         hintStyle: TextStyle(color: Colors.grey.shade700),
              //         hintText: "${context.appLoc.exemple_pref_hint}Andry",
              //         icon: const Icon(Icons.account_circle),
              //         fillColor: Colors.grey.shade300,
              //         filled: false,
              //         border: InputBorder.none),
              //     validator: (value) {
              //       if ((value == null || value.isEmpty)) {
              //         return context.appLoc.register_pseudo_validation;
              //       }
              //       return null;
              //     },
              //   ),
              // ),
              const SizedBox(height: largePadding),
              TextFormField(
                readOnly: true,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: _lieu_de_residenceController,
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
                            overlayColor: WidgetStatePropertyAll(Colors.grey),
                            shape: WidgetStatePropertyAll(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                                // side: BorderSide(color: Colors.grey),
                              ),
                            ),
                            fixedSize: WidgetStatePropertyAll(
                              Size(MediaQuery.of(context).size.width, 40),
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              _lieu_de_residenceController.text =
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
                      },
                    ),
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
                    Icons.location_pin,
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
              //   padding: const EdgeInsets.symmetric(
              //       horizontal: largePadding, vertical: smallPadding),
              //   decoration: BoxDecoration(
              //       color: Colors.grey.shade100,
              //       borderRadius: BorderRadius.circular(mediumPadding)),
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
              //       _lieu_de_residenceController.text = value ?? '';
              //     },
              //     decoration: InputDecoration(
              //       label: Text(context.appLoc.register_address_hint),
              //       labelStyle: TextStyle(color: Colors.grey.shade700),
              //       floatingLabelStyle: const TextStyle(color: tertiaryColor),
              //       hintStyle: TextStyle(color: Colors.grey.shade700),
              //       hintText:
              //           context.read<AppBloc>().state.user?.lieuResidence ??
              //               "${context.appLoc.exemple_pref_hint}Antananarivo",
              //       icon: const Icon(Icons.location_on),
              //       fillColor: Colors.grey.shade300,
              //       filled: false,
              //       border: InputBorder.none,
              //     ),
              //     validator: (value) {
              //       if (value == null || value.isEmpty) {
              //         return context.appLoc.register_address_validation;
              //       }
              //       return null;
              //     },
              //   ),
              // ),
              const SizedBox(height: largePadding),
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
                    label: Text(context.appLoc.register_mail_hint),
                    labelStyle: TextStyle(color: Colors.grey.shade700),
                    floatingLabelStyle: const TextStyle(color: tertiaryColor),
                    hintStyle: TextStyle(color: Colors.grey.shade700),
                    hintText:
                        "${context.appLoc.exemple_pref_hint}adresse@gmail.com",
                    suffixIcon: const Icon(Icons.mail, color: Colors.grey),
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
              // Container(
              //   padding: const EdgeInsets.symmetric(
              //       horizontal: largePadding, vertical: smallPadding),
              //   decoration: BoxDecoration(
              //       color: Colors.grey.shade100,
              //       borderRadius: BorderRadius.circular(mediumPadding)),
              //   child: TextFormField(
              //     autovalidateMode: AutovalidateMode.onUnfocus,
              //     controller: _mailController,
              //     decoration: InputDecoration(
              //         errorStyle: const TextStyle(fontWeight: FontWeight.bold),
              //         errorMaxLines: 3,
              //         label: Text(context.appLoc.register_mail_hint),
              //         labelStyle: TextStyle(color: Colors.grey.shade700),
              //         floatingLabelStyle: const TextStyle(color: tertiaryColor),
              //         hintStyle: TextStyle(color: Colors.grey.shade700),
              //         hintText:
              //             "${context.appLoc.exemple_pref_hint}adresse@gmail.com",
              //         icon: const Icon(Icons.mail),
              //         fillColor: Colors.grey.shade300,
              //         filled: false,
              //         border: InputBorder.none),
              //     validator: (value) {
              //       if ((value == null || value.isEmpty) ||
              //           !InputValidator.isValidEmail(value)) {
              //         return context.appLoc.register_mail_validation;
              //       }
              //       return null;
              //     },
              //   ),
              // ),
              const SizedBox(height: smallPadding),
              const SizedBox(height: largePadding),
              SizedBox(
                height: 40,
                child: FilledButton(
                  style: ButtonStyle(
                    shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      _userInfoModified = true;
                    });
                    if (_formKey.currentState!.validate()) {
                      context.read<AppBloc>().add(
                        UpdateUserInfoEvent(
                          pseudo: _pseudoController.text,
                          province: _lieu_de_residenceController.text,
                          mail: _mailController.text,
                        ),
                      );
                    }
                  },
                  child: Center(
                    child: Text(
                      context.appLoc.changer,
                      style: TextStyle(fontFamily: "Pretendard"),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
