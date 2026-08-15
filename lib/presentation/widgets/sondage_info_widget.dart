import 'package:mips/common/common.dart';
import 'package:mips/presentation/configurations/colors_list.dart';
import 'package:flutter/material.dart';

class SondageInfoWidget extends StatelessWidget {
  const SondageInfoWidget({super.key, required this.title});
  final String title;

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
        dense: true,
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }
}
