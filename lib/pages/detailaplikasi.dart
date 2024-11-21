import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sentuhtaru/plugin.dart';
import 'bukalayanan.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class DetailAplikasi extends StatelessWidget {
  final int myId;
  const DetailAplikasi({super.key, required this.myId});

  @override
  Widget build(BuildContext context) {
    return MyHomePage(myId: myId,);
  }
}

class MyHomePage extends StatefulWidget {
  final int myId;
  const MyHomePage({super.key, required this.myId});

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
      textZoom: 270,
      transparentBackground: true,
      iframeAllowFullscreen: true);

  PullToRefreshController? pullToRefreshController;
  String url = "";
  double progress = 0;
  final urlController = TextEditingController();

  String xjudul = '';
  String xjudulkecil = '';
  String xdata = '';
  String xdeskripsi = '';
  String xurl = '';

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
    String tmp = await http.read(Uri.parse('https://simtaru.kaltimprov.go.id/api/aplikasi/${widget.myId}'));
    Map<String, dynamic> tmpData = jsonDecode(tmp);

    setState(() {
      xjudul = tmpData['judul'] ?? '';
      xjudulkecil = tmpData['judul'] ?? '';
      xdata = tmpData['image'] ?? '';
      xdeskripsi = tmpData['deskripsi'] ?? '';
      xurl = tmpData['url'] ?? '';
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
                      const Text(
                        'Detail Aplikasi',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFFEC32F),
                        ),
                        textScaler: TextScaler.linear(1.0),
                      ),
                      Container(
                        height: 16,
                      ),
                      if (xdata != '')
                        Center(
                          child: Container(
                            height: (MediaQuery.of(context).size.width - 32) / 4,
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.white.withAlpha(255),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(3),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(4),
                              child: xdata != ''
                                  ? Image.network(
                                'https://simtaru.kaltimprov.go.id/storage/$xdata',
                                fit: BoxFit.fill,
                              )
                                  : const Text(''),
                            ),
                          ),
                        ),
                      Container(
                        height: 16,
                      ),
                      Center(
                        child: Text(
                          xjudul,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.yellow.shade400,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        height: 8,
                      ),
                      Center(
                        child: TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute<void>(
                                builder: (BuildContext context) => BukaAplikasi(myId: 1, myTitle: xjudul, myUrl: xurl,),
                              ),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white.withAlpha(255),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(8),
                              ),
                            ),
                            padding: const EdgeInsets.fromLTRB(32, 8, 32, 8),
                            child: Text(
                              'Buka Aplikasi',
                              style: TextStyle(
                                color: Colors.blue.shade700,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 8,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height - 250,
                        child: Stack(
                          children: <Widget>[
                            InAppWebView(
                              key: webViewKey,
                              initialData: InAppWebViewInitialData(
                                data: '$xdeskripsi<style>* {  color: #FFFFFF; }</style>',
                              ),
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