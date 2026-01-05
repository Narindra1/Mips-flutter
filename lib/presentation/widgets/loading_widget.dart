import 'package:flutter/material.dart';

import '../configurations/colors_list.dart';

class AppLoadingWidget extends StatelessWidget {
  final double? size;
  final Color? color;
  const AppLoadingWidget({
    super.key,
    this.size,
    this.color = tertiaryColor,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: size,
        height: size,
        child: CircularProgressIndicator(
          color: color,
        ),
      ),
    );
  }
}
