import 'package:flutter/material.dart';
import 'package:sentuhtaru/plugin.dart';
import 'package:sentuhtaru/pages/infotaru.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class DetailInfoTaruSatu extends StatefulWidget {
  const DetailInfoTaruSatu({super.key});

  @override
  State<DetailInfoTaruSatu> createState() => _DetailInfoTaruSatu();
}

class _DetailInfoTaruSatu extends State<DetailInfoTaruSatu> {
  String zjudul = '';
  String zgambar = '';
  String zisi = '';

  @override
  void initState() {
    super.initState();

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
                  MaterialPageRoute(builder: (context) => const Infotaru()),
                );
              },
              child: const Text(
                '< Info Taru',
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xFF053400),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
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
                  if (zgambar != '')
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
                  HtmlWidget(
                    zisi,
                    textStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
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
    );
  }
}