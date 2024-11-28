import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sentuhtaru/plugin.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Pejabat extends StatelessWidget {
  const Pejabat({super.key});

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
  String kabidNama = '';
  String kabidNip = '';
  String kabidGambar = '';
  List<String> kasiNama = <String>[];
  List<String> kasiNip = <String>[];
  List<String> kasiGambar = <String>[];
  List<String> stafNama = <String>[];
  List<String> stafNip = <String>[];
  List<String> stafGambar = <String>[];

  @override
  void initState() {
    super.initState();

    loadData();
  }

  void loadData() async {
    String kabid = 'https://simtaru.kaltimprov.go.id/api/pegawai-kabid';
    String kasi = 'https://simtaru.kaltimprov.go.id/api/pegawai-kasi';
    String staf = 'https://simtaru.kaltimprov.go.id/api/pegawai-staf';

    String webKabib = await http.read(Uri.parse(kabid));
    List<dynamic> dataKabid = jsonDecode(webKabib).toList();
    String webKasi = await http.read(Uri.parse(kasi));
    List<dynamic> dataKasi = jsonDecode(webKasi).toList();
    String webStaf = await http.read(Uri.parse(staf));
    List<dynamic> dataStaf = jsonDecode(webStaf).toList();

    setState(() {
      kabidNama = dataKabid[0]['nama']??'';
      kabidNip = dataKabid[0]['jabatan']??'';
      kabidGambar = dataKabid[0]['gambar']??'';

      for (var r in dataKasi) {
        kasiNama.add(r['nama']??'');
        kasiNip.add(r['jabatan']??'');
        kasiGambar.add(r['gambar']??'');
      }

      for (var r in dataStaf) {
        stafNama.add(r['nama']??'');
        stafNip.add(r['jabatan']??'');
        stafGambar.add(r['gambar']??'');
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
                        'Pegawai',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFFEC32F),
                        ),
                        textScaler: TextScaler.linear(1.0),
                      ),
                      Container(
                        height: 4,
                      ),
                      const Divider(height: 1, thickness: 1),
                      Container(
                        height: 8,
                      ),
                      Center(
                        child: Wrap(
                          children: [
                            ClipRRect(
                              clipBehavior: Clip.antiAlias,
                              borderRadius: BorderRadius.circular(4),
                              child: Container(
                                color: Colors.white,
                                child: Padding(
                                  padding: EdgeInsets.all(3),
                                  child: Column(
                                    children: [
                                      Container(
                                        width: 170,
                                        height: 220,
                                        color: Colors.white,
                                        child: Image.network(
                                          kabidGambar.toString()==''?'https://sukaphp.com/assets/noimage.png':'https://simtaru.kaltimprov.go.id/storage/${kabidGambar.toString()}',
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                      Container(
                                        color: Colors.white,
                                        width: 170,
                                        child: Center(
                                          child: Text(
                                            kabidNama.toString(),
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            textScaler: const TextScaler.linear(1.0),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        color: Colors.white,
                                        width: 170,
                                        child: Center(
                                          child: Text(
                                            kabidNip.toString(),
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                              fontSize: 10,
                                            ),
                                            textScaler: const TextScaler.linear(1.0),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        height: 4,
                      ),
                      Center(
                        child: Wrap(
                          children: [
                            ...List.generate(
                              kasiNama.isEmpty ? 0 : kasiNama.length,
                                  (index) => Padding(
                                padding: const EdgeInsets.all(4),
                                child: ClipRRect(
                                  clipBehavior: Clip.antiAlias,
                                  borderRadius: BorderRadius.circular(4),
                                  child: Container(
                                    color: Colors.white,
                                    child: Padding(
                                      padding: EdgeInsets.all(3),
                                      child: Column(
                                        children: [
                                          Container(
                                            width: 170,
                                            height: 220,
                                            color: Colors.white,
                                            child: Image.network(
                                              kasiGambar[index].toString()==''?'https://sukaphp.com/assets/noimage.png':'https://simtaru.kaltimprov.go.id/storage/${kasiGambar[index].toString()}',
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                          Container(
                                            color: Colors.white,
                                            width: 170,
                                            height: 50,
                                            child: Center(
                                              child: Text(
                                                kasiNama[index].toString(),
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                textScaler: const TextScaler.linear(1.0),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            color: Colors.white,
                                            width: 170,
                                            height: 50,
                                            child: Center(
                                              child: Text(
                                                kasiNip[index].toString(),
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                  fontSize: 10,
                                                ),
                                                textScaler: const TextScaler.linear(1.0),
                                              ),
                                            ),
                                          ),
                                        ],
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
                        height: 4,
                      ),
                      Center(
                        child: Wrap(
                          children: [
                            ...List.generate(
                              stafNama.isEmpty ? 0 : stafNama.length,
                                  (index) => Padding(
                                padding: const EdgeInsets.all(4),
                                child: ClipRRect(
                                  clipBehavior: Clip.antiAlias,
                                  borderRadius: BorderRadius.circular(4),
                                  child: Container(
                                    color: Colors.white,
                                    child: Padding(
                                      padding: EdgeInsets.all(3),
                                      child: Column(
                                        children: [
                                          Container(
                                            width: 170,
                                            height: 220,
                                            color: Colors.white,
                                            child: Image.network(
                                              stafGambar[index].toString()==''?'https://sukaphp.com/assets/noimage.png':'https://simtaru.kaltimprov.go.id/storage/${stafGambar[index].toString()}',
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                          Container(
                                            color: Colors.white,
                                            width: 170,
                                            height: 50,
                                            child: Center(
                                              child: Text(
                                                stafNama[index].toString(),
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                textScaler: const TextScaler.linear(1.0),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            color: Colors.white,
                                            width: 170,
                                            height: 50,
                                            child: Center(
                                              child: Text(
                                                stafNip[index].toString(),
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                  fontSize: 10,
                                                ),
                                                textScaler: const TextScaler.linear(1.0),
                                              ),
                                            ),
                                          ),
                                        ],
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
              bottomNavigationBar: const Buildbottommenu(),
              drawer: BuildDrawer(ctx: context),
            ),
          ),
        );
      },
    );
  }
}