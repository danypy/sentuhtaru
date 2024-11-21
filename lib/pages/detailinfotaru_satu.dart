import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sentuhtaru/plugin.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DetailInfoTaruSatu extends StatelessWidget {
  const DetailInfoTaruSatu({super.key});

  @override
  Widget build(BuildContext context) {
    return const MyHomePage();
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

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

  String zjudul = '';
  String zgambar = '';
  String zisi = '';

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
    String tmp = await http.read(Uri.parse('https://simtaru.kaltimprov.go.id/api/pages/5'));
    Map<String, dynamic> tmpData = jsonDecode(tmp);

    setState(() {
      zjudul = tmpData['title'] ?? '';
      zgambar = tmpData['image'] ?? '';
      zisi = tmpData['body'] ?? '';
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
                      if (zgambar != '')
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
                              child: zgambar != ''
                                  ? Image.network(
                                'https://simtaru.kaltimprov.go.id/storage/$zgambar',
                                fit: BoxFit.fill,
                              )
                                  : const Text(''),
                            ),
                          ),
                        ),
                      Container(
                        height: 16,
                      ),
                      Text(
                        zjudul,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.yellow.shade400,
                          fontWeight: FontWeight.bold,
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
                              initialData: InAppWebViewInitialData(data: 'https://sukaphp.com'),
                              initialSettings: settings,
                            ),
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