import 'package:flutter/material.dart';
import 'package:sentuhtaru/plugin.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:sentuhtaru/pages/detailaplikasi.dart';

class Aplikasi extends StatefulWidget {
  const Aplikasi({super.key});

  @override
  State<Aplikasi> createState() => _Aplikasi();
}

class _Aplikasi extends State<Aplikasi> {
  List<int> listIdApps = <int>[];
  List<String> listApps = <String>[];

  @override
  void initState() {
    super.initState();

    loadData();
  }

  void loadData() async {
    String tmpapp = await http.read(Uri.parse('https://simtaru.kaltimprov.go.id/api/aplikasi'));
    List<dynamic> tmpDataapp = jsonDecode(tmpapp).toList();
    setState(() {
      for (var element in tmpDataapp) {
        listIdApps.add(element['id']);
        listApps.add(element['image']);
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
                'Aplikasi',
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
                      listApps.isEmpty ? 0 : listApps.length,
                          (index) => Padding(
                        padding: const EdgeInsets.all(4),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => DetailAplikasi(myId: listIdApps[index],)),
                            );
                          },
                          child: Container(
                            width: (MediaQuery.of(context).size.width - 60) / 2,
                            height: ((MediaQuery.of(context).size.width - 60) * (9 / 16)) / 3,
                            decoration: BoxDecoration(
                              color: Colors.white.withAlpha(255),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(4),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(4),
                              child: Image.network(
                                'https://simtaru.kaltimprov.go.id/storage/${listApps[index].toString()}',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
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
      ),
    );
  }
}