import 'package:MIPS/common/constants/constant.dart';
import 'package:MIPS/presentation/configurations/colors_list.dart';
import 'package:MIPS/presentation/configurations/extension_for_localization.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class MenuProfilButton extends StatelessWidget {
  const MenuProfilButton({
    super.key,
    this.icon,
    required this.title,
    required this.onPressed,
    this.menuRewards = false,
    this.isButton = true,
    this.style,
  });
  final void Function()? onPressed;
  final IconData? icon;
  final String title;
  final bool menuRewards;
  final bool isButton;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      child: TextButton(
        onPressed: onPressed,
        style: ButtonStyle(
            shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16))),
            overlayColor: WidgetStatePropertyAll(Colors.grey.shade300)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 24,
              color: Colors.grey,
            ),
            const SizedBox(width: largePadding),
            Expanded(
              child: Text(
                title,
                style: style ??
                    Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(fontWeight: FontWeight.bold),
                textAlign: TextAlign.start,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: largePadding),
            if (menuRewards)
              Container(
                padding: EdgeInsets.symmetric(
                  vertical: smallPadding,
                  horizontal: mediumPadding,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(largePadding),
                  color: tertiaryColor,
                ),
                child: Text(
                  context.appLoc.get_mips,
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: Colors.white,
                      ),
                ),
              ),
            // const Spacer(),
            isButton
                ? Icon(
                    Ionicons.chevron_forward,
                    color: Colors.grey,
                  )
                : const SizedBox()
          ],
        ),
      ),
    );
  }
}
