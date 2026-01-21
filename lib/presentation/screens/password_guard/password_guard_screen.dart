import 'package:MIPS/presentation/configurations/extension_for_localization.dart';
import 'package:MIPS/presentation/routes/router.dart';
import 'package:MIPS/presentation/screens/base/base_screen.dart';
import 'package:MIPS/presentation/screens/password_guard/bloc/password_guard_bloc.dart';
import 'package:MIPS/presentation/widgets/message_displayer_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:ionicons/ionicons.dart';

import '../../../common/constants/constant.dart';
import '../../configurations/colors_list.dart';

class PasswordGuardScreen extends StatelessWidget {
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final String nextRoute;

  PasswordGuardScreen({super.key, required this.nextRoute});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      useDefaultAnnonceSponsPart: true,
      content: BlocProvider(
        create: (context) => GetIt.instance<PasswordGuardBloc>(),
        child: BlocConsumer<PasswordGuardBloc, PasswordGuardState>(
          listener: (context, state) {
            if (state.status == Status.checking) {
              MessageDisplayerUtils.showLoadingDialog(context);
            } else if (state.status == Status.error) {
              context.pop();
              MessageDisplayerUtils.showErrorDialog(
                  context, state.errorMessage);
            } else if (state.status == Status.passed) {
              context.pop();
              AppRouter.goReplace(context, nextRoute);
            }
          },
          listenWhen: (previous, current) => previous.status != current.status,
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(mediumPadding),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      context.appLoc.auth_guard_screen_prompt,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(
                      height: largePadding,
                    ),
                    Container(
                      // padding: const EdgeInsets.symmetric(
                      //     horizontal: largePadding, vertical: smallPadding),
                      // decoration: BoxDecoration(
                      //     color: Colors.black12,
                      //     borderRadius: BorderRadius.circular(mediumPadding)),
                      child: TextFormField(
                        autovalidateMode: AutovalidateMode.onUnfocus,
                        obscureText: !state.showPassword,
                        controller: _passwordController,
                        decoration: InputDecoration(
                          errorStyle:
                              const TextStyle(fontWeight: FontWeight.bold),
                          errorMaxLines: 3,
                          label: Text(context.appLoc.login_password_hint),
                          labelStyle: TextStyle(color: Colors.grey.shade700),
                          floatingLabelStyle:
                              const TextStyle(color: tertiaryColor),
                          hintStyle: TextStyle(color: Colors.grey.shade700),
                          // icon: const Icon(Icons.lock),
                          suffixIcon: IconButton(
                              onPressed: () {
                                context.read<PasswordGuardBloc>().add(
                                    ShowPasswordChangeEvent(
                                        show: !state.showPassword));
                              },
                              icon: state.showPassword
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
                      height: largePadding,
                    ),
                    SizedBox(
                      height: 40,
                      child: FilledButton(
                        style: ButtonStyle(
                            shape: WidgetStatePropertyAll(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16)))),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            context.read<PasswordGuardBloc>().add(
                                CheckPasswordEvent(
                                    password: _passwordController.text));
                          }
                        },
                        child: Center(child: Text(context.appLoc.continuer)),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      title: Text(
        context.appLoc.auth_guard_screen_title,
        style: Theme.of(context).textTheme.titleLarge,
      ),
      leading: IconButton(
        onPressed: () {
          context.pop();
        },
        icon: const Icon(
          Ionicons.chevron_back,
          color: Colors.black,
        ),
      ),
    );
  }
}
