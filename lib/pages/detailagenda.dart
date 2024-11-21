import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sentuhtaru/plugin.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DetailAgenda extends StatelessWidget {
  final int myId;
  const DetailAgenda({super.key, required this.myId});

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
  String xjudul = '';
  String xdata = '';
  String xwaktu = '';
  String xlokasi = '';
  String xdeskripsi = '';

  @override
  void initState() {
    super.initState();

    loadData();
  }

  void loadData() async {
    String tmp = await http.read(Uri.parse(
        'https://simtaru.kaltimprov.go.id/api/events/${widget.myId}'));
    Map<String, dynamic> tmpData = jsonDecode(tmp);

    setState(() {
      xjudul = tmpData['tema'] ?? '';
      xdata = tmpData['gambar'] ?? '';
      xwaktu = tmpData['tgl_mulai'] ?? '';
      xlokasi = tmpData['tempat'] ?? '';
      xdeskripsi = tmpData['deskripsi'] ?? '';
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
                        'Agenda $xjudul',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.yellow.shade400,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        height: 8,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 2,
                        color: Colors.white.withAlpha(255),
                      ),
                      Container(
                        height: 8,
                      ),
                      if (xdata != '')
                        Container(
                          width: (MediaQuery.of(context).size.width) - 32,
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
                      Container(
                        height: 16,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 100,
                            child: Text(
                              'Waktu',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white.withAlpha(255),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width - 100 - 32,
                            child: Text(
                              ': $xwaktu',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white.withAlpha(255),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 100,
                            child: Text(
                              'Lokasi',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white.withAlpha(255),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width - 100 - 32,
                            child: Text(
                              ': $xlokasi',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white.withAlpha(255),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        'Deskripsi',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white.withAlpha(255),
                          fontWeight: FontWeight.bold,
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