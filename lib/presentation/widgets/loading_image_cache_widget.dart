import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../configurations/colors_list.dart';

class LoadingImageCacheWidget extends StatelessWidget {
  const LoadingImageCacheWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: LoadingAnimationWidget.twoRotatingArc(
            color: tertiaryColor.withOpacity(0.5), size: 24));
  }
}
