import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sentuhtaru/plugin.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Playlist extends StatelessWidget {
  const Playlist({super.key});

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
  List<int> listIdApps = <int>[];
  List<String> listJudulApps = <String>[];
  List<String> listApps = <String>[];

  @override
  void initState() {
    super.initState();

    loadData();
  }

  void loadData() async {
    String tmpapp = await http.read(Uri.parse('https://simtaru.kaltimprov.go.id/api/videos'));
    List<dynamic> tmpDataapp = jsonDecode(tmpapp).toList();
    setState(() {
      for (var element in tmpDataapp) {
        listIdApps.add(element['id']);
        listJudulApps.add(element['judul']);
        listApps.add(element['youtube']);
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
                        'Playlist',
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
                                  (index) => Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 0, 16),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: (MediaQuery.of(context).size.width),
                                      height:
                                      ((MediaQuery.of(context).size.width)) *
                                          (3 / 4),
                                      decoration: BoxDecoration(
                                        color: Colors.white.withAlpha(255),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(4),
                                        child: GestureDetector(
                                          onTap: () {},
                                          child: Image.network(
                                            'https://img.youtube.com/vi/${listApps[index].toString()}/sddefault.jpg',
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext ctx) {
                                            return AlertDialog(
                                              content: SizedBox(
                                                height: 500,
                                                child: Container(
                                                  padding: const EdgeInsets.all(0),
                                                  child: Column(
                                                    children: [
                                                      Container(
                                                        width: (MediaQuery.of(ctx)
                                                            .size
                                                            .width) -
                                                            0,
                                                        height:
                                                        (MediaQuery.of(ctx).size.width -
                                                            0) *
                                                            (9 / 16),
                                                        decoration: BoxDecoration(
                                                          color:
                                                          Colors.white.withAlpha(255),
                                                          borderRadius:
                                                          const BorderRadius.all(
                                                            Radius.circular(3),
                                                          ),
                                                        ),
                                                        child: Padding(
                                                          padding: const EdgeInsets.all(4),
                                                          child: YoutubePlayer(
                                                            controller:
                                                            YoutubePlayerController(
                                                              initialVideoId:
                                                              listApps[index]
                                                                  .toString(),
                                                              flags:
                                                              const YoutubePlayerFlags(
                                                                autoPlay: true,
                                                                mute: false,
                                                                loop: true,
                                                              ),
                                                            ),
                                                            showVideoProgressIndicator:
                                                            true,
                                                            progressIndicatorColor:
                                                            Colors.blueAccent,
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        height: 8,
                                                      ),
                                                      Center(
                                                        child: Text(
                                                          listJudulApps[index].toString(),
                                                          textAlign: TextAlign.center,
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                            color:
                                                            Colors.black.withAlpha(255),
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        height: 8,
                                                      ),
                                                      TextButton(
                                                        onPressed: () {
                                                          Navigator.of(ctx).pop();
                                                        },
                                                        child: Container(
                                                          padding:
                                                          const EdgeInsets.fromLTRB(
                                                              32, 8, 32, 8),
                                                          decoration: BoxDecoration(
                                                            color: Colors.blue.shade400,
                                                            borderRadius:
                                                            const BorderRadius.all(
                                                              Radius.circular(8),
                                                            ),
                                                          ),
                                                          child: Text(
                                                            'Tutup Video',
                                                            style: TextStyle(
                                                              fontSize: 12,
                                                              color: Colors.white
                                                                  .withAlpha(255),
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      },
                                      child: Container(
                                        width: (MediaQuery.of(context).size.width),
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color: Colors.white.withAlpha(200),
                                        ),
                                        child: Center(
                                          child: Text(
                                            listJudulApps[index].toString(),
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.black.withAlpha(255),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
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