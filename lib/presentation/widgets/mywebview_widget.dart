import 'package:MIPS/common/common.dart';
import 'package:MIPS/presentation/configurations/colors_list.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MyWebviewWidget extends StatefulWidget {
  final String htmlData;
  final bool isURLProvided;

  MyWebviewWidget({
    super.key,
    required this.htmlData,
  }) : isURLProvided = htmlData.startsWith("http");

  @override
  State<MyWebviewWidget> createState() => _MyWebviewWidgetState();
}

class _MyWebviewWidgetState extends State<MyWebviewWidget> {
  late final WebViewController _controller;
  int loadingProgress = 0;

  bool get isPdf => widget.htmlData.toLowerCase().endsWith('.pdf');

  @override
  void initState() {
    super.initState();

    if (!isPdf) {
      _controller = WebViewController()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..setNavigationDelegate(
          NavigationDelegate(
            onProgress: (progress) {
              setState(() => loadingProgress = progress);
            },
            onNavigationRequest: (request) {
              AppUtils.showDebugLog(runtimeType, "HTML URI : ${request.url}");
              return NavigationDecision.navigate;
            },
          ),
        );

      if (widget.isURLProvided) {
        _controller.loadRequest(Uri.parse(widget.htmlData));
      } else {
        _controller.loadHtmlString(widget.htmlData);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isPdf) {
      return SfPdfViewer.network(
        widget.htmlData,
        canShowScrollStatus: false,
      );
    }

    return Column(
      children: [
        if (loadingProgress < 100)
          LinearProgressIndicator(
            value: loadingProgress / 100,
            color: tertiaryColor,
          ),
        Expanded(
          child: WebViewWidget(controller: _controller),
        ),
      ],
    );
  }
}
// THE FIRST
// class MyWebviewWidget extends StatefulWidget {
//   late final String htmlData;
//   late final bool isURLProvided;

//   @override
//   State<MyWebviewWidget> createState() => _MyWebviewWidgetState();

//   MyWebviewWidget({
//     super.key,
//     required String htmlData,
//   }) {
//     this.htmlData = htmlData.replaceAll("mahafaka.com//", "mahafaka.com/");
//     isURLProvided = this.htmlData.startsWith("http");
//   }
// }

// class _MyWebviewWidgetState extends State<MyWebviewWidget> {
//   late WebViewController _controller;
//   int loadingProgress = 0;

//   @override
//   void initState() {
//     super.initState();
//     _controller = WebViewController();
//     _controller.setJavaScriptMode(JavaScriptMode.unrestricted);

//     _controller.setNavigationDelegate(
//       NavigationDelegate(
//         onProgress: (int progress) {
//           setState(() {
//             loadingProgress = progress;
//           });
//         },
//         onSslAuthError: (request) {
//           AppUtils.showDebugLog(runtimeType, "HTML onSslAuthError }");
//           request.proceed();
//         },
//         onHttpError: (HttpResponseError error) {
//           AppUtils.showDebugLog(
//               runtimeType, "HTML onHttpError : ${error.toString()}");
//         },
//         onWebResourceError: (WebResourceError error) {
//           AppUtils.showDebugLog(
//               runtimeType, "HTML onWebResourceError : ${error.toString()}");
//         },
//         onNavigationRequest: (NavigationRequest request) {
//           AppUtils.showDebugLog(runtimeType, "HTML URI : ${request.url}");
//           if (request.url.startsWith('https://www.youtube.com/')) {
//             return NavigationDecision.prevent;
//           }
//           return NavigationDecision.navigate;
//         },
//       ),
//     );
//     if (!widget.isURLProvided) {
//       _controller.loadHtmlString(widget.htmlData);
//     } else {
//       if (widget.htmlData.endsWith(".pdf")) {
//         _controller.loadRequest(Uri.parse(widget.htmlData));
//       } else {
//         _controller.loadRequest(Uri.parse(widget.htmlData));
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return widget.htmlData.endsWith(".pdf")
//         ? SfPdfViewer.network(widget.htmlData)
//         : Column(
//             children: [
//               if (loadingProgress != 100)
//                 LinearProgressIndicator(
//                   color: tertiaryColor,
//                   backgroundColor: Colors.grey,
//                   value: (loadingProgress / 100),
//                 ),
//               Expanded(child: WebViewWidget(controller: _controller)),
//             ],
//           );
//   }
// }
