import 'package:flutter/material.dart';
import 'package:sentuhtaru/plugin.dart';
import 'package:sentuhtaru/pages/profil.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class DetailProfil extends StatefulWidget {
  final int myId;
  final String myTitle;
  final String myUrl;
  const DetailProfil({super.key, required this.myId, required this.myTitle, required this.myUrl});

  @override
  State<DetailProfil> createState() => _DetailProfil();
}

class _DetailProfil extends State<DetailProfil> {
  final GlobalKey webViewKey = GlobalKey();
  InAppWebViewController? webViewController;
  InAppWebViewSettings settings = InAppWebViewSettings(
      javaScriptEnabled: true,
      javaScriptCanOpenWindowsAutomatically: true,
      cacheEnabled: true,
      isInspectable: false,
      mediaPlaybackRequiresUserGesture: false,
      allowsInlineMediaPlayback: true,
      iframeAllow: "camera; microphone",
      iframeAllowFullscreen: true);

  PullToRefreshController? pullToRefreshController;
  String url = "";
  double progress = 0;
  final urlController = TextEditingController();

  @override
  void initState() {
    super.initState();

    loadData();

    pullToRefreshController = PullToRefreshController(
      settings: PullToRefreshSettings(
        color: Colors.blue,
      ),
      onRefresh: () async {
        webViewController?.reload();
      },
    );
  }

  void loadData() async {
  }

  @override
  void deactivate() {
    super.deactivate();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return halaman(
      context,
        Stack(
          children: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                minimumSize: const Size.fromHeight(30),
                backgroundColor: Colors.white,
                alignment: Alignment.centerLeft,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.zero),
                ),
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Profil()),
                );
              },
              child: const Text(
                '< Profil',
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xFF053400),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
              child: InAppWebView(
                key: webViewKey,
                initialUrlRequest:
                URLRequest(url: WebUri(widget.myUrl.toString())),
                initialSettings: settings,
                pullToRefreshController: pullToRefreshController,
                onWebViewCreated: (controller) {
                  webViewController = controller;
                },
                onLoadStart: (controller, url) {
                  setState(() {
                    this.url = url.toString();
                    urlController.text = this.url;
                  });
                },
                onPermissionRequest: (controller, request) async {
                  return PermissionResponse(
                      resources: request.resources,
                      action: PermissionResponseAction.GRANT);
                },
                shouldOverrideUrlLoading:
                    (controller, navigationAction) async {
                  return NavigationActionPolicy.ALLOW;
                },
                onLoadStop: (controller, url) async {
                  pullToRefreshController?.endRefreshing();
                  setState(() {
                    this.url = url.toString();
                    urlController.text = this.url;
                  });
                },
                onReceivedError: (controller, request, error) {
                  pullToRefreshController?.endRefreshing();
                },
                onProgressChanged: (controller, progress) {
                  if (progress == 100) {
                    pullToRefreshController?.endRefreshing();
                  }
                  setState(() {
                    this.progress = progress / 100;
                    urlController.text = url;
                  });
                },
                onUpdateVisitedHistory: (controller, url, androidIsReload) {
                  setState(() {
                    this.url = url.toString();
                    urlController.text = this.url;
                  });
                },
                onConsoleMessage: (controller, consoleMessage) {
                },
              ),
            ),
            progress < 1.0
                ? LinearProgressIndicator(value: progress)
                : Container(),
          ],
        ),
    );
  }
}