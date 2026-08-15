import 'package:mips/common/common.dart';
import 'package:mips/presentation/configurations/colors_list.dart';
import 'package:flutter/material.dart';

class MoreInfoWidget extends StatefulWidget {
  const MoreInfoWidget({super.key, required this.title, required this.content});
  final String title;
  final String content;

  @override
  State<MoreInfoWidget> createState() => _MoreInfoWidgetState();
}

class _MoreInfoWidgetState extends State<MoreInfoWidget> {
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
          widget.title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: AnimatedSize(
          curve: Curves.easeInOutCirc,
          duration: const Duration(milliseconds: 100),
          child: Text(
            widget.content,
            maxLines: _isExpanded ? null : 1,
            overflow: _isExpanded ? null : TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }
}
