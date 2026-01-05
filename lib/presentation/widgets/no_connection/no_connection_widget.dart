import 'package:MIPS/common/common.dart';
import 'package:MIPS/presentation/configurations/extension_for_localization.dart';
import 'package:flutter/material.dart';

class NoConnectionWidget extends StatelessWidget {
  final Function() refreshFunction;

  const NoConnectionWidget({super.key, required this.refreshFunction});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(
          Icons.signal_wifi_connected_no_internet_4_outlined,
          size: 32,
        ),
        Text(context.appLoc.connection_error),
        const SizedBox(
          height: mediumPadding,
        ),
        FilledButton(
            onPressed: refreshFunction, child: Text(context.appLoc.try_again))
      ],
    );
  }
}
