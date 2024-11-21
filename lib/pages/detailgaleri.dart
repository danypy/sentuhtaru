import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sentuhtaru/plugin.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DetailGaleri extends StatelessWidget {
  final int myId;
  final String myTitle;
  const DetailGaleri({super.key, required this.myId, required this.myTitle});

  @override
  Widget build(BuildContext context) {
    return MyHomePage(myId: myId, myTitle: myTitle,);
  }
}

class MyHomePage extends StatefulWidget {
  final int myId;
  final String myTitle;
  const MyHomePage({super.key, required this.myId, required this.myTitle});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<int> listIdApps = <int>[];
  List<String> listJudulApps = <String>[];
  List<String> listApps = <String>[];

  @override
  void initState() {
    super.initState();

    loadData();
  }

  void loadData() async {
    String tmpapp = await http.read(Uri.parse('https://simtaru.kaltimprov.go.id/api/album/${widget.myId}'));
    List<dynamic> tmpDataapp = [];

    if(jsonDecode(tmpapp) is List){
      tmpDataapp = jsonDecode(tmpapp).toList();
    }else{
      tmpDataapp = jsonDecode('[$tmpapp]').toList();
    }
    setState(() {
      for (var element in tmpDataapp) {
        listIdApps.add(element['id']??'');
        listJudulApps.add(element['judul']??'');
        listApps.add(element['gambar']??'');
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
                      Text(
                        'Galeri ${widget.myTitle}',
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
                      Center(
                        child: Wrap(
                          children: [
                            ...List.generate(
                              listIdApps.isEmpty ? 0 : listIdApps.length,
                                  (index) => Padding(
                                padding: const EdgeInsets.all(8),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: (MediaQuery.of(context).size.width) - 32,
                                      height:
                                      ((MediaQuery.of(context).size.width) - 32) *
                                          (3 / 4),
                                      decoration: BoxDecoration(
                                        color: Colors.white.withAlpha(255),
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(3),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(4),
                                        child: GestureDetector(
                                          onTap: () {

                                          },
                                          child: SizedBox(
                                            width: (MediaQuery.of(context).size.width) - 32,
                                            height: 100,
                                            child: Center(
                                              child: Image.network(
                                                listApps[index].toString()==''?'https://sukaphp.com/assets/noimage.png':'https://simtaru.kaltimprov.go.id/storage/${listApps[index].toString()}',
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
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