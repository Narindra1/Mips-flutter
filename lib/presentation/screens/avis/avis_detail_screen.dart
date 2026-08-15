import 'package:mips/presentation/widgets/mywebview_widget.dart';
import 'package:mips/presentation/screens/base/base_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AvisDetailScreen extends StatelessWidget {
  final String title;
  final String id;
  final String pageUrl;

  const AvisDetailScreen({
    super.key,
    required this.title,
    required this.id,
    required this.pageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      title: Text(title, style: Theme.of(context).textTheme.titleLarge),
      content: MyWebviewWidget(htmlData: pageUrl),
      leading: IconButton(
        onPressed: () {
          context.pop();
        },
        icon: const Icon(Icons.chevron_left_outlined, color: Colors.black),
      ),
      backgroundColor: Colors.white,
    );
  }
}
