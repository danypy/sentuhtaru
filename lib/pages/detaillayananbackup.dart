import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sentuhtaru/plugin.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class DetailLayanan extends StatelessWidget {
  final int myId;
  final String myTitle;
  final String myUrl;
  const DetailLayanan({super.key, required this.myId, required this.myTitle, required this.myUrl});

  @override
  Widget build(BuildContext context) {
    return MyHomePage(myId: myId, myTitle: myTitle, myUrl: myUrl,);
  }
}

class MyHomePage extends StatefulWidget {
  final int myId;
  final String myTitle;
  final String myUrl;
  const MyHomePage({super.key, required this.myId, required this.myTitle, required this.myUrl});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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

    pullToRefreshController = PullToRefreshController(
      settings: PullToRefreshSettings(
        color: Colors.blue,
      ),
      onRefresh: () async {
        webViewController?.reload();
      },
    );

    loadData();
  }

  void loadData() async {
    setState(() {
    });
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
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: false,
      builder: (_ , child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
            fontFamily: 'FontPoppins',
          ),
          home: SafeArea(
            child: Scaffold(
              backgroundColor: const Color(0xFF053400),
              appBar: AppBar(
                title: const Text(
                  'SENTUH TARU',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  textScaler: TextScaler.linear(1.0),
                ),
                actions: const [
                  Padding(
                    padding: EdgeInsets.only(right: 16.0),
                    child: Image(
                      image: AssetImage('assets/images/kaltim.png'),
                      width: 32,
                    ),
                  ),
                ],
                backgroundColor: const Color(0xFF053400),
                leading: Builder(
                  builder: (context) {
                    return IconButton(
                      icon: const Icon(
                        Icons.menu,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Scaffold.of(context).openDrawer();
                      },
                    );
                  },
                ),
                shape: const Border(
                    bottom: BorderSide(
                        color: Colors.white30,
                        width: 1
                    )
                ),
                elevation: 4,
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        widget.myTitle,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFFEC32F),
                        ),
                        textScaler: const TextScaler.linear(1.0),
                      ),
                      Container(
                        height: 16,
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height - 250,
                        color: Colors.white,
                        child: Stack(
                          children: <Widget>[
                            InAppWebView(
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
                            progress < 1.0
                                ? LinearProgressIndicator(value: progress)
                                : Container(),
                          ],
                        ),
                      ),
                      Container(
                        height: 32,
                      ),
                    ],
                  ),
                ),
              ),
              bottomNavigationBar: const Buildbottommenu(),
              drawer: BuildDrawer(ctx: context),
            ),
          ),
        );
      },
    );
  }
}