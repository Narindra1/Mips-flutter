import 'package:mips/presentation/configurations/extension_for_localization.dart';
import 'package:mips/presentation/widgets/mywebview_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../common/constants/constant.dart';

class CguDialog extends StatefulWidget {
  final Function? onAccept;

  const CguDialog({super.key, this.onAccept});

  @override
  State<CguDialog> createState() => _CguDialogState();
}

class _CguDialogState extends State<CguDialog> {
  bool _isAccepted = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Conditions Générales d'Utilisation"),
      content: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: MyWebviewWidget(htmlData: urlCUG),
            ),
          ),
          CheckboxListTile(
            contentPadding: EdgeInsets.zero,
            controlAffinity: ListTileControlAffinity.leading,
            value: _isAccepted,
            onChanged: (value) {
              setState(() {
                _isAccepted = value ?? false;
              });
            },
            title: const Text(
              "J'accepte les Conditions Générales d'Utilisation.",
            ),
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            context.pop();
          },
          child: Text(context.appLoc.cancel),
        ),
        ElevatedButton(
          onPressed: _isAccepted
              ? () {
                  context.pop();
                  if (widget.onAccept != null) {
                    widget.onAccept!();
                  }
                }
              : null, // Button is disabled if _isAccepted is false
          child: Text(context.appLoc.btn_register),
        ),
      ],
    );
  }
}
