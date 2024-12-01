import 'package:flutter/material.dart';
import 'package:sentuhtaru/plugin.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:sentuhtaru/pages/detailprofil.dart';

class Profil extends StatefulWidget {
  const Profil({super.key});

  @override
  State<Profil> createState() => _Profil();
}

class _Profil extends State<Profil> {
  List<int> listIdApps = <int>[];
  List<String> listJudulApps = <String>[];
  List<int> listApps = <int>[];

  @override
  void initState() {
    super.initState();

    loadData();
  }

  void loadData() async {
    String tmpapp = await http.read(Uri.parse('https://simtaru.kaltimprov.go.id/api/link-profil-android'));
    List<dynamic> tmpDataapp = jsonDecode(tmpapp).toList();
    setState(() {
      for (var element in tmpDataapp) {
        listIdApps.add(element['id']??'');
        listJudulApps.add(element['judul']??'');
        listApps.add(element['page_id']??'');
      }
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
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text(
                'Profil',
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
              Center(
                child: Wrap(
                  children: [
                    ...List.generate(
                        listIdApps.isEmpty ? 0 : listIdApps.length,
                            (index) => Container(
                          margin: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white.withAlpha(255),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(8),
                            ),
                          ),
                          child: ListTile(
                            title: Text(
                              listJudulApps[index].toString(),
                              style: const TextStyle(
                                fontSize: 12,
                              ),
                            ),
                            trailing: const Icon(
                              Icons.keyboard_arrow_right_sharp,
                              size: 12,
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => DetailProfil(
                                    myId: listIdApps[index].toInt(),
                                    myTitle: listJudulApps[index].toString(),
                                    myUrl: listApps[index].toString(),
                                  ),
                                ),
                              );
                            },
                          ),
                        )
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
    );
  }
}