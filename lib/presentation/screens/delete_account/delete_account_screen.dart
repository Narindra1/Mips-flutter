import 'package:MIPS/common/constants/constant.dart';
import 'package:MIPS/presentation/bloc/app_bloc.dart';
import 'package:MIPS/presentation/configurations/colors_list.dart';
import 'package:MIPS/presentation/configurations/extension_for_localization.dart';
import 'package:MIPS/presentation/screens/base/base_screen.dart';
import 'package:MIPS/presentation/widgets/message_displayer_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:ionicons/ionicons.dart';

class DeleteAccountScreen extends StatefulWidget {
  const DeleteAccountScreen({super.key});

  @override
  State<DeleteAccountScreen> createState() => _DeleteAccountScreenState();
}

class _DeleteAccountScreenState extends State<DeleteAccountScreen> {
  bool _confirmed = false;
  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      content: SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: largePadding),
            Align(
              alignment: Alignment.topCenter,
              child: Column(
                children: [
                  Text(
                    // context.appLoc.menu_profil_delete_data_texte,
                    context.appLoc.attention,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  Container(
                    // color: Colors.red,
                    height: 250,
                    width: 250,
                    child: SvgPicture.asset("assets/imgs/illu_warning.svg"),
                  ),
                ],
              ),
            ),
            const SizedBox(height: largePadding * 2),
            Text(
              context.appLoc.delete_title1,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: mediumPadding),
            Text(
              context.appLoc.delete_subtitle1,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: largePadding * 2),
            Text(
              context.appLoc.delete_title2,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: mediumPadding),
            Text(
              context.appLoc.delete_subtitle2,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Row(
                children: [
                  Checkbox(
                    // fillColor: WidgetStateProperty.resolveWith<Color>(
                    //   (states) {
                    //     if (states.contains(WidgetState.selected)) {
                    //       return tertiaryColor;
                    //     }
                    //     return Colors.grey;
                    //   },
                    // ),
                    side: BorderSide(color: Colors.grey, width: 2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(smallPadding),
                    ),
                    value: _confirmed,
                    onChanged: (value) {
                      setState(() {
                        _confirmed = value!;
                      });
                    },
                  ),
                  Text(
                    context.appLoc.confirm,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                  )
                ],
              ),
            ),
            const SizedBox(height: largePadding * 2),
            Align(
              alignment: Alignment.topRight,
              child: SizedBox(
                height: 40,
                child: ElevatedButton(
                    style: ButtonStyle(
                      shape: WidgetStatePropertyAll(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                      ),
                    ),
                    onPressed: _confirmed
                        ? () {
                            MessageDisplayerUtils
                                .showConfirmDeleteUserAccountDialog(
                              context,
                              () {
                                context.read<AppBloc>().add(DeleteUserEvent());
                              },
                            );
                          }
                        : null,
                    child: Text(
                      context.appLoc.delete,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                    )),
              ),
            ),
            const SizedBox(height: mediumPadding),
          ],
        ),
      ),
      title: Text(
        context.appLoc.delete_your_account,
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
}
