import 'package:MIPS/common/common.dart';
import 'package:MIPS/presentation/configurations/colors_list.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class PageCountIconIndicator extends StatefulWidget {
  final PageController pageController;
  final int count;

  const PageCountIconIndicator(
      {super.key, required this.pageController, required this.count});

  @override
  State<PageCountIconIndicator> createState() => _PageCountIconIndicatorState();
}

class _PageCountIconIndicatorState extends State<PageCountIconIndicator> {
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    widget.pageController.addListener(_pageListener);
  }

  void _pageListener() {
    final newPage = widget.pageController.page?.round() ?? 0;
    if (newPage != _currentPage) {
      setState(() {
        _currentPage = newPage;
      });
    }
  }

  @override
  void dispose() {
    widget.pageController.removeListener(_pageListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.count < 1) {
      return const SizedBox();
    }
    return Container(
      padding: EdgeInsets.symmetric(horizontal: smallPadding),
      decoration: BoxDecoration(
        color: tertiaryColor,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Row(
        spacing: 3.0,
        children: [
          const Icon(
            Ionicons.camera,
            color: Colors.white,
            size: 12,
          ),
          Text(
            '${_currentPage + 1}/${widget.count}',
            style: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
