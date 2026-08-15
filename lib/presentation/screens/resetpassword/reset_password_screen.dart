import 'package:mips/presentation/configurations/extension_for_localization.dart';
import 'package:mips/presentation/presentation.dart';
import 'package:mips/presentation/screens/base/base_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mips/common/common.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../configurations/colors_list.dart';
import '../../routes/route.dart';
import '../../routes/router.dart';
import '../../widgets/message_displayer_utils.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPassScreenState();
}

class _ResetPassScreenState extends State<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _validationCodeController = TextEditingController();
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
      useDefaultAnnonceSponsPart: true,
      content: SingleChildScrollView(
        child: BlocBuilder<AppBloc, AppState>(
          builder: (context, state) {
            return Container(
              padding: EdgeInsets.all(mediumPadding),
              constraints: const BoxConstraints(maxWidth: 420),
              child:
                  context.read<AppBloc>().state.statusForgotPassword ==
                      StatusForgotPassword.validationCodeSentSuccessfully
                  ? _buildResetPassFormContent(context)
                  : _buildSendCodeContent(context),
            );
          },
        ),
      ),
      title: Text(
        context.appLoc.reset_password_title,
        style: Theme.of(context).textTheme.titleLarge,
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

  Widget _buildSendCodeContent(BuildContext context) {
    return BlocListener<AppBloc, AppState>(
      listenWhen: (previous, current) {
        return previous.statusForgotPassword != current.statusForgotPassword;
      },
      listener: (context, state) {
        if (state.statusForgotPassword ==
            StatusForgotPassword.validationCodeSentSuccessfully) {
          context.pop();
        } else if (state.statusForgotPassword ==
            StatusForgotPassword.validationCodeInprogress) {
          MessageDisplayerUtils.showLoadingDialog(context);
        } else if (state.statusForgotPassword ==
            StatusForgotPassword.validationCodeError) {
          context.pop();
          MessageDisplayerUtils.showErrorDialog(context, state.errorMessage);
        }
      },
      child:
          // Form(
          //   key: _formKey,
          //   child:
          Row(
            children: [
              Flexible(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.appLoc.forgot_password_title,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: mediumPadding),
                    Text(
                      context.appLoc.password_forget_title,
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium?.copyWith(color: Colors.grey),
                    ),
                    // Text(
                    //   context.appLoc.reset_password_email_prompt,
                    //   style: Theme.of(context)
                    //       .textTheme
                    //       .bodyMedium
                    //       ?.copyWith(color: Colors.grey),
                    // ),
                    const SizedBox(height: largePadding),
                    Text(
                      context.appLoc.password_forget_option1,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: mediumPadding),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: context.appLoc
                                .password_forget_text1("contact@mips.mg")
                                .split("contact@mips.mg")
                                .first,
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(color: Colors.grey),
                          ),
                          TextSpan(
                            text: "contact@mips.mg",
                            style: TextStyle(fontWeight: FontWeight.bold),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () async {
                                try {
                                  final Uri url = Uri(
                                    scheme: 'mailto',
                                    path: 'contact@mips.mg',
                                  );

                                  if (await canLaunchUrl(url)) {
                                    await launchUrl(
                                      url,
                                      mode: LaunchMode.externalApplication,
                                    );
                                  } else {
                                    throw 'Could not launch $url';
                                  }
                                } catch (e) {
                                  if (context.mounted) {
                                    MessageDisplayerUtils.showToastMessage(
                                      context.appLoc.not_supported,
                                    );
                                  }
                                }
                              },
                          ),
                          // const TextSpan(
                          //   text: "contact@mips.mg",
                          //   style: TextStyle(fontWeight: FontWeight.bold),
                          // ),
                          TextSpan(
                            text: context.appLoc
                                .password_forget_text1("contact@mips.mg")
                                .split("contact@mips.mg")
                                .last,
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: largePadding),
                    Text(
                      context.appLoc.password_forget_option2,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: mediumPadding),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: context.appLoc.password_forget_text2
                                .split("038 28 309 29")
                                .first,
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(color: Colors.grey),
                          ),
                          TextSpan(
                            text: "038 28 309 29",
                            style: TextStyle(fontWeight: FontWeight.bold),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () async {
                                try {
                                  final Uri url = Uri(
                                    scheme: 'tel',
                                    path: '0382830929',
                                  );

                                  if (await canLaunchUrl(url)) {
                                    await launchUrl(
                                      url,
                                      mode: LaunchMode.externalApplication,
                                    );
                                  } else {
                                    throw 'Could not launch $url';
                                  }
                                } catch (e) {
                                  if (context.mounted) {
                                    MessageDisplayerUtils.showToastMessage(
                                      context.appLoc.not_supported,
                                    );
                                  }
                                }
                              },
                          ),
                          TextSpan(
                            text: context.appLoc.password_forget_text2
                                .split("038 28 309 29")
                                .last,
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: largePadding * 2),
                    Text(
                      context.appLoc.what_next_title,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: mediumPadding),
                    Text(
                      context.appLoc.what_next_text,
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium?.copyWith(color: Colors.grey),
                    ),
                    const SizedBox(height: mediumPadding),
                    Text(
                      context.appLoc.connexion_temporary_title,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    const SizedBox(height: mediumPadding),
                    Text(
                      context.appLoc.connexion_temporary_text1,
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium?.copyWith(color: Colors.grey),
                    ),
                    const SizedBox(height: mediumPadding),
                    Text(
                      context.appLoc.connexion_temporary_text2,
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium?.copyWith(color: Colors.grey),
                    ),
                    const SizedBox(height: mediumPadding),
                    Text(
                      context.appLoc.connexion_temporary_text3,
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium?.copyWith(color: Colors.grey),
                    ),
                    const SizedBox(height: 50),
                    // Text(
                    //   context.appLoc.password_forget_text1("contact@mips.mg"),
                    //   style: Theme.of(context)
                    //       .textTheme
                    //       .bodyMedium
                    //       ?.copyWith(color: Colors.grey),
                    // ),
                    // SizedBox(
                    //   // padding: const EdgeInsets.symmetric(
                    //   //     horizontal: largePadding, vertical: smallPadding),
                    //   // decoration: BoxDecoration(
                    //   //     color: Colors.grey.shade100,
                    //   //     borderRadius: BorderRadius.circular(mediumPadding)),
                    //   child: TextFormField(
                    //     autovalidateMode: AutovalidateMode.onUnfocus,
                    //     readOnly: (context.read<AppBloc>().state.statusForgotPassword ==
                    //         StatusForgotPassword.validationCodeInprogress),
                    //     controller: _emailController,
                    //     decoration: InputDecoration(
                    //       errorStyle: const TextStyle(fontWeight: FontWeight.bold),
                    //       errorMaxLines: 3,
                    //       label: Text(context.appLoc.register_mail_hint),
                    //       labelStyle: TextStyle(color: Colors.grey.shade700),
                    //       floatingLabelStyle: const TextStyle(color: tertiaryColor),
                    //       hintStyle: TextStyle(color: Colors.grey.shade700),
                    //       hintText:
                    //           "${context.appLoc.exemple_pref_hint}adresse@gmail.com",
                    //       suffixIcon: const Icon(
                    //         Ionicons.mail,
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
                    //       if ((value == null || value.isEmpty) ||
                    //           !InputValidator.isValidEmail(value)) {
                    //         return context.appLoc.register_mail_validation;
                    //       }
                    //       return null;
                    //     },
                    //   ),
                    // ),
                    // const SizedBox(height: 20),
                    // SizedBox(
                    //   height: 40,
                    //   child: FilledButton(
                    //     style: ButtonStyle(
                    //         shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                    //             borderRadius: BorderRadius.circular(16.0)))),
                    //     onPressed: () async {
                    //       if (_formKey.currentState!.validate()) {
                    //         // Implement forgot password logic
                    //         context
                    //             .read<AppBloc>()
                    //             .add(ForgotPasswordEvent(email: _emailController.text));
                    //       }
                    //     },
                    //     child: (context.read<AppBloc>().state.statusForgotPassword ==
                    //             StatusForgotPassword.validationCodeInprogress)
                    //         ? const AppLoadingWidget(
                    //             size: 16,
                    //           )
                    //         : Center(
                    //             child: Text(
                    //             context.appLoc.reset_password_submit_button,
                    //             style: Theme.of(context)
                    //                 .textTheme
                    //                 .titleSmall
                    //                 ?.copyWith(color: Colors.white),
                    //           )),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ],
          ),
      // ),
    );
  }

  Widget _mailBoldText(BuildContext context, String mail) {
    final message = context.appLoc.validation_email_sent(mail);
    final parts = message.split(mail);
    return RichText(
      text: TextSpan(
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: Colors.grey,
        ), // Default text style
        children: [
          TextSpan(text: parts[0]), // Text before email
          TextSpan(
            text: mail,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ), // Bold email
          ),
          TextSpan(text: parts[1]), // Text after email
        ],
      ),
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
          AppRouter.goPushNamedAndRemoveUntil(context, RoutesNames.home);
          MessageDisplayerUtils.showToastMessage(
            context.appLoc.password_reset_success_toast,
          );
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
              context.appLoc.password_change_title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: mediumPadding),
            _mailBoldText(context, _emailController.text),
            const SizedBox(height: largePadding * 2),
            Text(
              "Entrez le code de validation",
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: Colors.grey),
            ),
            const SizedBox(height: mediumPadding),
            Container(
              // padding: const EdgeInsets.symmetric(
              //     horizontal: largePadding, vertical: smallPadding),
              // decoration: BoxDecoration(
              //     color: Colors.black12,
              //     borderRadius: BorderRadius.circular(mediumPadding)),
              child: TextFormField(
                autovalidateMode: AutovalidateMode.onUnfocus,
                controller: _validationCodeController,
                decoration: InputDecoration(
                  errorStyle: const TextStyle(fontWeight: FontWeight.bold),
                  errorMaxLines: 3,
                  label: Text(context.appLoc.validation_code_prompt),
                  labelStyle: TextStyle(color: Colors.grey.shade700),
                  floatingLabelStyle: const TextStyle(color: tertiaryColor),
                  hintStyle: TextStyle(color: Colors.grey.shade700),
                  // icon: const Icon(Icons.key_outlined),
                  suffixIcon: const Icon(Icons.key, color: Colors.grey),
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
                    return context.appLoc.incomplete_info_text;
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(height: largePadding * 2),
            Text(
              "Créez un nouveau mot de passe",
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: Colors.grey),
            ),
            const SizedBox(height: mediumPadding),
            Container(
              // padding: const EdgeInsets.symmetric(
              //     horizontal: largePadding, vertical: smallPadding),
              // decoration: BoxDecoration(
              //     color: Colors.black12,
              //     borderRadius: BorderRadius.circular(mediumPadding)),
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
                  hintStyle: TextStyle(color: Colors.grey.shade700),
                  // icon: const Icon(Icons.lock),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _showPassword = !_showPassword;
                      });
                    },
                    icon: _showPassword
                        ? const Icon(Icons.visibility, color: Colors.grey)
                        : const Icon(Icons.visibility_off, color: Colors.grey),
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
            Container(
              // padding: const EdgeInsets.symmetric(
              //     horizontal: largePadding, vertical: smallPadding),
              // decoration: BoxDecoration(
              //     color: Colors.black12,
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
                  hintStyle: TextStyle(color: Colors.grey.shade700),
                  // icon: const Icon(Icons.lock),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _showPassword = !_showPassword;
                      });
                    },
                    icon: _showPassword
                        ? const Icon(Icons.visibility, color: Colors.grey)
                        : const Icon(Icons.visibility_off, color: Colors.grey),
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
                  shape: WidgetStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                  ),
                ),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    context.read<AppBloc>().add(
                      ResetPasswordEvent(
                        validationCode: _validationCodeController.text,
                        newPassword: _passwordController.text,
                      ),
                    );
                  }
                },
                child: Center(
                  child: Text(
                    context.appLoc.reset_password_confirm_button,
                    style: Theme.of(
                      context,
                    ).textTheme.titleSmall?.copyWith(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
