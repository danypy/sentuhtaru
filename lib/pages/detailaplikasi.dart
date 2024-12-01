import 'package:flutter/material.dart';
import 'package:sentuhtaru/plugin.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:sentuhtaru/pages/aplikasi.dart';
import 'package:sentuhtaru/pages/bukaaplikasi.dart';

class DetailAplikasi extends StatefulWidget {
  final int myId;
  const DetailAplikasi({super.key, required this.myId});

  @override
  State<DetailAplikasi> createState() => _DetailAplikasi();
}

class _DetailAplikasi extends State<DetailAplikasi> {
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
    return halaman(
      context,
      SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
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
                  MaterialPageRoute(builder: (context) => const Aplikasi()),
                );
              },
              child: const Text(
                '< Aplikasi',
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xFF053400),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
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
                        height: (MediaQuery.of(context).size.width - 32) / 3,
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
                            fit: BoxFit.cover,
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => BukaAplikasi(myId: 1, myTitle: xjudul, myUrl: xurl,)),
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
                  HtmlWidget(
                    xdeskripsi,
                    textStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                  Container(
                    height: 32,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}