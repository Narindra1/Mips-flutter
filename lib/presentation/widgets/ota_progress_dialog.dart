import 'dart:async';
import 'package:MIPS/common/common.dart';
import 'package:MIPS/presentation/configurations/colors_list.dart';
import 'package:MIPS/presentation/configurations/extension_for_localization.dart';
import 'package:flutter/material.dart';
import 'package:ota_update/ota_update.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

class OtaProgressDialog extends StatefulWidget {
  const OtaProgressDialog({
    super.key,
  });

  @override
  State<OtaProgressDialog> createState() => _OtaProgressDialogState();
}

class _OtaProgressDialogState extends State<OtaProgressDialog> {
  StreamSubscription<OtaEvent>? _subscription;
  double _progress = 0.0;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _startOta();
  }

  void _startOta() async {
    try {
      _subscription = OtaUpdate()
          .execute(
        urlDownloadAppUpdate,
        destinationFilename: "mahafaka-update.apk",
      )
          .listen((event) {
        if (event.status == OtaStatus.DOWNLOADING) {
          setState(() {
            _progress =
                double.tryParse(event.value!.replaceAll('%', ''))! / 100;
          });
        } else if (event.status == OtaStatus.INSTALLING ||
            event.status == OtaStatus.PERMISSION_NOT_GRANTED_ERROR ||
            event.status == OtaStatus.INTERNAL_ERROR ||
            event.status == OtaStatus.ALREADY_RUNNING_ERROR ||
            event.status == OtaStatus.DOWNLOAD_ERROR) {
          Navigator.of(context, rootNavigator: true).maybePop();
        }
      });
    } catch (e) {
      setState(() => _hasError = true);
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.of(context, rootNavigator: true).maybePop();
      });
    }
  }

  void _cancelDownload() {
    _subscription?.cancel();
    _subscription = null;
    try {
      OtaUpdate().cancel();
    } catch (e) {
      AppUtils.showDebugLog(runtimeType, e.toString());
    }
    Navigator.of(context, rootNavigator: true).maybePop();
  }

  @override
  void dispose() {
    _subscription?.cancel();
    WakelockPlus.disable();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    WakelockPlus.enable();
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(mediumPadding)),
      title: Text(context.appLoc.download_dialog_title),
      content: _hasError
          ? Text(context.appLoc.download_dialog_error)
          : Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                LinearProgressIndicator(
                  value: _progress,
                  color: tertiaryColor,
                  backgroundColor: Colors.grey.shade300,
                ),
                const SizedBox(height: 16),
                Text('${(_progress * 100).toStringAsFixed(0)}%'),
                Text(context.appLoc.download_dialog_desc),
              ],
            ),
      actions: [
        if (!_hasError)
          TextButton(
            onPressed: _cancelDownload,
            child: Text(context.appLoc.cancel),
          ),
      ],
    );
  }
}
