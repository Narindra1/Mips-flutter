import 'package:mips/common/common.dart';
import 'package:mips/presentation/configurations/colors_list.dart';
import 'package:mips/presentation/configurations/extension_for_localization.dart';
import 'package:flutter/material.dart';

class TipsConseilWidget extends StatefulWidget {
  const TipsConseilWidget({super.key});

  @override
  State<TipsConseilWidget> createState() => _TipsConseilWidgetState();
}

class _TipsConseilWidgetState extends State<TipsConseilWidget> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        border: Border.all(color: tertiaryColor),
        borderRadius: BorderRadius.circular(largePadding),
      ),
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(largePadding),
        ),
        isThreeLine: true,
        onTap: () {
          setState(() {
            _isExpanded = !_isExpanded;
          });
        },
        dense: true,
        title: Text(
          context.appLoc.tips_mahaol_title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: AnimatedSize(
          curve: Curves.easeInOutCirc,
          duration: const Duration(milliseconds: 100),
          child: Text(
            context.appLoc.conseil_tip,
            maxLines: _isExpanded ? null : 1,
            overflow: _isExpanded ? null : TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }
}
