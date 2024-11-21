import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sentuhtaru/plugin.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:sentuhtaru/pages/detailinfotaru_satu.dart';
import 'package:sentuhtaru/pages/detailinfotaru_dua.dart';
import 'package:sentuhtaru/pages/detailinfotaru_tiga.dart';

class Infotaru extends StatelessWidget {
  const Infotaru({super.key});

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
  List<String> listJudulApps = <String>[];
  List<String> listApps = <String>[];

  @override
  void initState() {
    super.initState();

    loadData();
  }

  void loadData() async {
    String tmpapp = await http.read(Uri.parse('https://simtaru.kaltimprov.go.id/api/infotaru'));
    List<dynamic> tmpDataapp = jsonDecode(tmpapp).toList();
    setState(() {
      for (var element in tmpDataapp) {
        listJudulApps.add(element['nama']??'');
        listApps.add(element['url']??'');
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
                        'Info Taru',
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
                      Container(
                        margin: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(255),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(8),
                          ),
                        ),
                        child: ListTile(
                          title: const Text(
                            'Alur Permohonan Informasi Tata Ruang',
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                          trailing: const Icon(
                            Icons.keyboard_arrow_right_sharp,
                            size: 12,
                          ),
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute<void>(
                                builder: (BuildContext context) => const DetailInfoTaruSatu(),
                              ),
                            );
                          },
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(255),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(8),
                          ),
                        ),
                        child: ListTile(
                          title: const Text(
                            'Cek Status Permohonan',
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                          trailing: const Icon(
                            Icons.keyboard_arrow_right_sharp,
                            size: 12,
                          ),
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute<void>(
                                builder: (BuildContext context) => const DetailInfoTaruDua(myTitle: 'Cek Status Permohonan', myUrl: 'https://sniper-kaliber.kaltimprov.go.id/cek-status-permohonan'),
                              ),
                            );
                          },
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(255),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(8),
                          ),
                        ),
                        child: ListTile(
                          title: const Text(
                            'Cek Lokasi Permohonan',
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                          trailing: const Icon(
                            Icons.keyboard_arrow_right_sharp,
                            size: 12,
                          ),
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute<void>(
                                builder: (BuildContext context) => const DetailInfoTaruTiga(myTitle: 'Cek Lokasi Permohonan', myUrl: 'https://sniper-kaliber.kaltimprov.go.id/tinjau'),
                              ),
                            );
                          },
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