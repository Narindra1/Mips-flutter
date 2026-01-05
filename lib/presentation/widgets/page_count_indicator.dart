import 'package:MIPS/common/common.dart';
import 'package:flutter/material.dart';

class PageCountIndicator extends StatefulWidget {
  final PageController pageController;
  final int count;

  const PageCountIndicator(
      {super.key, required this.pageController, required this.count});

  @override
  State<PageCountIndicator> createState() => _PageCountIndicatorState();
}

class _PageCountIndicatorState extends State<PageCountIndicator> {
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
      padding: const EdgeInsets.all(smallPadding),
      decoration: BoxDecoration(
          color: Colors.white54,
          borderRadius: BorderRadius.circular(smallPadding),
          border: Border.all(color: Colors.grey.shade300)),
      child: Text(
        '${_currentPage + 1} / ${widget.count}',
        style: Theme.of(context)
            .textTheme
            .bodySmall
            ?.copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }
}
