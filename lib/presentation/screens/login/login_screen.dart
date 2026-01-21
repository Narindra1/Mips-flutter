import 'package:MIPS/common/common.dart';
import 'package:MIPS/presentation/bloc/app_bloc.dart';
import 'package:MIPS/presentation/configurations/extension_for_localization.dart';
import 'package:MIPS/presentation/presentation.dart';
import 'package:MIPS/presentation/screens/base/base_screen.dart';
import 'package:MIPS/presentation/widgets/message_displayer_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ionicons/ionicons.dart';

import '../../configurations/colors_list.dart';
import '../../routes/route.dart';
import '../../routes/router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return LoginScreenState();
  }
}

class LoginScreenState extends State<LoginScreen> {
  late GlobalKey<FormState> _formKey;
  late TextEditingController _usernameController;

  late TextEditingController _passwordController;
  bool _showPassword = false;
  bool _stayLogged = true;
  String username = "";
  String password = "";

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
    _showPassword = false;
    _stayLogged = true;

    super.initState();
  }

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
            context.appLoc.connexion,
            style: TextStyle(
              fontFamily: "Pretendard",
              color: Colors.black,
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 8),
            child: SizedBox(
              height: 35,
              child: FilledButton(
                style: ButtonStyle(
                    shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)))),
                onPressed: () {
                  AppRouter.go(context, RoutesNames.register);
                },
                child: Center(
                  child: Text(context.appLoc.login_signup),
                ),
              ),
            ),
          ),
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
          MessageDisplayerUtils.showAuthCredentialErrorDialog(context);
        } else if (state.userStatus == UserStatus.loading) {
          MessageDisplayerUtils.showAuthLoadingDialog(context);
        } else if (state.userStatus == UserStatus.userConnected) {
          AppRouter.goPushNamedAndRemoveUntil(
            context,
            RoutesNames.home,
          );
          MessageDisplayerUtils.showToastMessage(
              context.appLoc.welcome_user(state.user!.pseudo));
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Align(
          alignment: Alignment.topCenter,
          // child: AppPanelWidget(
          //   constraints: BoxConstraints(
          //     maxWidth: MediaQuery.of(context).size.width,
          //   ),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  // context.appLoc.connexion,
                  context.appLoc.login_intro,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(
                  height: smallPadding,
                ),
                Text(
                  context.appLoc.login_text_intro,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: Colors.grey),
                ),
                const SizedBox(
                  height: largePadding * 2,
                ),
                SizedBox(
                  // padding: const EdgeInsets.symmetric(
                  //     horizontal: largePadding, vertical: smallPadding),
                  // decoration: BoxDecoration(
                  //     color: Colors.grey.shade100,
                  //     borderRadius: BorderRadius.circular(mediumPadding)),
                  child: TextFormField(
                    autovalidateMode: AutovalidateMode.onUnfocus,
                    keyboardType: TextInputType.phone,
                    inputFormatters: [PhoneNumberFormatter()],
                    controller: _usernameController,
                    decoration: InputDecoration(
                      errorStyle: const TextStyle(fontWeight: FontWeight.bold),
                      errorMaxLines: 3,
                      label: Text(context.appLoc.register_tel_hint),
                      labelStyle: TextStyle(color: Colors.grey.shade700),
                      floatingLabelStyle: const TextStyle(color: tertiaryColor),
                      hintStyle: TextStyle(color: Colors.grey.shade700),
                      hintText:
                          "${context.appLoc.exemple_pref_hint}034 00 000 00",
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
                      if ((value == null || value.isEmpty) ||
                          !InputValidator.isValidPhoneNumber(value)) {
                        return context.appLoc.register_tel_validation;
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(
                  height: largePadding,
                ),
                SizedBox(
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
                      label: Text(context.appLoc.login_password_hint),
                      labelStyle: TextStyle(color: Colors.grey.shade700),
                      floatingLabelStyle: const TextStyle(color: tertiaryColor),
                      // icon: const Icon(Icons.lock),
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _showPassword = !_showPassword;
                            });
                          },
                          icon: _showPassword
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
                      if (value == null || value.isEmpty) {
                        return context.appLoc.login_password_validation_error;
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(
                  height: mediumPadding,
                ),
                CheckboxListTile(
                  contentPadding: EdgeInsets.zero,
                  controlAffinity: ListTileControlAffinity.leading,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  value: _stayLogged,
                  onChanged: (value) {
                    setState(() {
                      if (value != null) {
                        setState(() {
                          _stayLogged = value;
                        });
                      }
                    });
                  },
                  title: Text(
                    context.appLoc.login_stayconnected,
                  ),
                ),
                const SizedBox(
                  height: largePadding,
                  // height: largePadding * 2,
                ),
                SizedBox(
                  height: 40,
                  child: FilledButton(
                    style: ButtonStyle(
                        shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)))),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Implement login logic
                        setState(() {
                          username = _usernameController.text;
                          password = _passwordController.text;
                        });
                        context.read<AppBloc>().add(LoginEvent(
                            login: _usernameController.text,
                            password: _passwordController.text,
                            stayLogged: _stayLogged));
                      }
                    },
                    child: Center(child: Text(context.appLoc.connexion)),
                  ),
                ),
                const SizedBox(
                  height: largePadding,
                ),
                TextButton(
                  onPressed: () {
                    AppRouter.go(context, RoutesNames.resetPassword);
                  },
                  style: ButtonStyle(
                    overlayColor: WidgetStatePropertyAll(Colors.grey.shade300),
                  ),
                  child: Text(
                    context.appLoc.login_forgot_password,
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  height: mediumPadding,
                ),
                // const Divider(),
                const SizedBox(height: largePadding),
                // Align(
                //   alignment: Alignment.center,
                //   child: Text(
                //     context.appLoc.login_not_member,
                //     style: Theme.of(context).textTheme.titleMedium,
                //   ),
                // ),
                const SizedBox(
                  height: largePadding,
                ),
              ],
            ),
          ),
          // ),
        ),
      ),
    );
  }
}
