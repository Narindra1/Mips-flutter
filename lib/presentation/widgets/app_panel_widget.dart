import 'package:flutter/material.dart';

import '../../common/constants/constant.dart';

class AppPanelWidget extends StatelessWidget {
  final Widget child;
  final BoxConstraints? constraints;
  final EdgeInsetsGeometry? padding;

  const AppPanelWidget({
    super.key,
    required this.child,
    this.constraints,
    this.padding = const EdgeInsets.all(largePadding),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: constraints,
      width: double.maxFinite,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(largePadding),
          color: Colors.white,
          border: Border.all(color: Colors.grey.shade200, width: 1.5)),
      padding: padding,
      child: child,
    );
  }
}
