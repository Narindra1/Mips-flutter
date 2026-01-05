import 'package:MIPS/presentation/configurations/extension_for_localization.dart';
import 'package:MIPS/presentation/presentation.dart';
import 'package:MIPS/presentation/screens/base/base_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:MIPS/common/common.dart';
import 'package:go_router/go_router.dart';
import 'package:ionicons/ionicons.dart';

import '../../bloc/app_bloc.dart';
import '../../configurations/colors_list.dart';
import '../../routes/route.dart';
import '../../routes/router.dart';
import '../../widgets/message_displayer_utils.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();

  final _oldPasswordController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordConfirmationController = TextEditingController();
  bool _showPassword = false;

  @override
  void initState() {
    context.read<AppBloc>().add(ResetStatusResetPasswordScreenEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      content: SingleChildScrollView(
        padding: EdgeInsets.all(8),
        child: Align(
          alignment: Alignment.topCenter,
          child: BlocBuilder<AppBloc, AppState>(
            builder: (context, state) {
              return Container(
                  constraints: const BoxConstraints(maxWidth: 420),
                  child: _buildResetPassFormContent(context));
            },
          ),
        ),
      ),
      title: Text(
        context.appLoc.profil_change_pass_text,
        style: Theme.of(context).textTheme.titleLarge,
      ),
      leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: Icon(
            Ionicons.chevron_back,
            color: Colors.black,
          )),
      backgroundColor: Colors.white,
    );
  }

  Widget _buildResetPassFormContent(BuildContext context) {
    return BlocListener<AppBloc, AppState>(
      listenWhen: (previous, current) {
        return previous.statusResetPass != current.statusResetPass;
      },
      listener: (context, state) {
        if (state.statusResetPass == StatusResetPass.resetCodeSuccess) {
          context.pop(); // quite page
          AppRouter.goPushNamedAndRemoveUntil(
            context,
            RoutesNames.home,
          );
          MessageDisplayerUtils.showToastMessage(
              context.appLoc.password_reset_success_toast);
        } else if (state.statusResetPass == StatusResetPass.resetInprogress) {
          MessageDisplayerUtils.showLoadingDialog(context);
        } else if (state.statusResetPass == StatusResetPass.resetCodeError) {
          context.pop();
          MessageDisplayerUtils.showErrorDialog(context, state.errorMessage);
        }
      },
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              // "Créez un mot nouveau mot de passe plus sécurisé",
              context.appLoc.create_new_more_secure_password,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: largePadding),
            Text(context.appLoc.enter_old_pass,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: Colors.grey)),
            const SizedBox(height: mediumPadding),
            SizedBox(
              child: TextFormField(
                autovalidateMode: AutovalidateMode.onUnfocus,
                obscureText: !_showPassword,
                controller: _oldPasswordController,
                decoration: InputDecoration(
                  errorStyle: const TextStyle(fontWeight: FontWeight.bold),
                  errorMaxLines: 3,
                  label: Text(context.appLoc.old_password_hint),
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
            const SizedBox(height: largePadding * 2),
            Text(context.appLoc.create_new_strong_password,
                // "Créer maintenant le nouveau mot de passe",
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: Colors.grey)),
            const SizedBox(height: mediumPadding),
            SizedBox(
              child: TextFormField(
                autovalidateMode: AutovalidateMode.onUnfocus,
                obscureText: !_showPassword,
                controller: _passwordController,
                decoration: InputDecoration(
                  errorStyle: const TextStyle(fontWeight: FontWeight.bold),
                  errorMaxLines: 3,
                  label: Text(context.appLoc.register_new_password_hint),
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
            const SizedBox(height: largePadding),
            SizedBox(
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
                  if (value == null ||
                      value.isEmpty ||
                      (value != _passwordController.text)) {
                    return context.appLoc.register_password2_validation;
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(height: largePadding * 2),
            SizedBox(
              height: 40,
              child: FilledButton(
                style: ButtonStyle(
                    shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)))),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    context.read<AppBloc>().add(ChangePasswordEvent(
                          oldPassword: _oldPasswordController.text,
                          newPassword: _passwordController.text,
                        ));
                  }
                },
                child: Center(
                    child: Text(
                  context.appLoc.changer,
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(color: Colors.white),
                )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
