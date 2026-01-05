import 'package:MIPS/common/common.dart';
import 'package:MIPS/presentation/configurations/extension_for_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ErrorPageWidget extends StatelessWidget {
  final String errorDesc;

  const ErrorPageWidget({super.key, this.errorDesc = ""});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(largePadding * 2),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
              width: 250,
              height: 250,
              child: SvgPicture.asset("assets/imgs/illu_internal_error.svg")),
          Text(
            context.appLoc.error_operation,
            style: Theme.of(context).textTheme.titleMedium,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
