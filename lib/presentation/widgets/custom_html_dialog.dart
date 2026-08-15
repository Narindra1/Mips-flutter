import 'package:mips/common/common.dart';
import 'package:mips/presentation/configurations/extension_for_localization.dart';
import 'package:mips/presentation/widgets/mywebview_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomHtmlDialog extends StatelessWidget {
  final Function? onClick;
  final String urlHtml;

  const CustomHtmlDialog({super.key, this.onClick, required this.urlHtml});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: const BoxDecoration(color: Colors.white),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(child: MyWebviewWidget(htmlData: urlHtml)),
            Padding(
              padding: const EdgeInsets.all(mediumPadding),
              child: SizedBox(
                height: 40,
                child: ElevatedButton(
                  style: ButtonStyle(
                    shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(largePadding),
                      ),
                    ),
                  ),
                  onPressed: () {
                    context.pop();
                  },
                  child: Text(context.appLoc.fermer),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
