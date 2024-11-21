import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sentuhtaru/plugin.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:sentuhtaru/pages/aplikasi.dart';
import 'package:sentuhtaru/pages/detailaplikasi.dart';
import 'package:sentuhtaru/pages/detailagenda.dart';
import 'package:sentuhtaru/pages/detailberita.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

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
  int _currentPos1 = 0;
  int _currentPos2 = 0;
  int _currentPos3 = 0;

  List<String> listJudulVideo = <String>[];
  List<String> listVideo = <String>[];
  PageController pcVideo = PageController(viewportFraction: 0.4, initialPage: 0);

  List<int> listIdAgenda = <int>[];
  List<String> listJudulAgenda = <String>[];
  List<String> listAgenda = <String>[];
  PageController pcAgenda = PageController(viewportFraction: 1.0, initialPage: 0);

  List<int> listIdApps = <int>[];
  List<String> listApps = <String>[];

  List<int> listIdBerita = <int>[];
  List<String> listJudulBerita = <String>[];
  List<String> listIsiBerita = <String>[];
  PageController pcBerita = PageController(viewportFraction: 1.0, initialPage: 0);

  YoutubePlayerController videoControl = YoutubePlayerController(
    initialVideoId: '7dT7fkDMbdQ',
    flags: const YoutubePlayerFlags(
      showLiveFullscreenButton: false,
      autoPlay: true,
      mute: false,
      loop: true,
    ),
  );

  @override
  void initState() {
    super.initState();

    loadData();
  }

  void loadData() async {
    // videos
    String tmp = await http.read(Uri.parse('https://simtaru.kaltimprov.go.id/api/videos?limit=5'));
    List<dynamic> tmpData = jsonDecode(tmp).toList();
    setState(() {
      for (var element in tmpData) {
        listJudulVideo.add(element['judul']);
        listVideo.add(element['youtube']);
      }
      videoControl.load(listVideo[0]);
    });

    // aplikasi
    String tmpapp = await http.read(Uri.parse('https://simtaru.kaltimprov.go.id/api/aplikasi?limit=3'));
    List<dynamic> tmpDataapp = jsonDecode(tmpapp).toList();
    setState(() {
      for (var element in tmpDataapp) {
        listIdApps.add(element['id']);
        listApps.add(element['image']);
      }
    });

    // agendas
    String tmpa = await http.read(Uri.parse('https://simtaru.kaltimprov.go.id/api/events?limit=3'));
    List<dynamic> tmpDataa = jsonDecode(tmpa).toList();
    setState(() {
      for (var element in tmpDataa) {
        listIdAgenda.add(element['id']);
        listJudulAgenda.add(element['tema']);
        listAgenda.add(element['gambar'] ?? '');
      }
    });

    // beritas
    String tmpb = await http.read(Uri.parse('https://simtaru.kaltimprov.go.id/api/posts?limit=3'));
    List<dynamic> tmpDatab = jsonDecode(tmpb).toList();
    setState(() {
      for (var element in tmpDatab) {
        listIdBerita.add(element['id']);
        listJudulBerita.add(element['title']);
        listIsiBerita.add(element['image'] ?? '');
      }
    });
  }

  @override
  void deactivate() {
    videoControl.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    videoControl.dispose();
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
                        'Selamat Datang',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFFEC32F),
                        ),
                        textScaler: TextScaler.linear(1.0),
                      ),
                      YoutubePlayer(
                        controller: videoControl,
                        showVideoProgressIndicator: true,
                        progressIndicatorColor: Colors.blueAccent,
                        onEnded: (metaData) {
                          setState(() {
                            videoControl.load(listVideo[
                            (listVideo.indexOf(metaData.videoId) + 1) %
                                listVideo.length]);
                            _currentPos1 =
                                listVideo.indexOf(metaData.videoId) + 1;
                            pcVideo.animateToPage(
                              _currentPos1,
                              duration: const Duration(milliseconds: 400),
                              curve: Curves.easeIn,
                            );
                          });
                        },
                      ),
                      Container(
                        margin: const EdgeInsets.all(0),
                        padding: const EdgeInsets.all(0),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(200),
                        ),
                        child: Center(
                          child: Text(
                            listJudulVideo.isEmpty
                                ? ''
                                : (listJudulVideo[_currentPos1]),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.black.withAlpha(255),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 16,
                      ),
                      Container(
                        height: 95,
                        decoration: const BoxDecoration(),
                        child: PageView.builder(
                          controller: pcVideo,
                          itemCount: listVideo.isEmpty ? 0 : listVideo.length,
                          padEnds: false,
                          onPageChanged: (value) {
                            setState(() {
                              _currentPos1 = value;
                              videoControl.load(listVideo[_currentPos1]);
                            });
                          },
                          itemBuilder: (context, index) {
                            String tmpx = 'https://img.youtube.com/vi/${listVideo[index]}/sddefault.jpg';
                            return GestureDetector(
                              onTap: () {
                                videoControl.load(listVideo[index]);
                              },
                              child: Container(
                                margin: const EdgeInsets.symmetric(horizontal: 16.0),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                padding: const EdgeInsets.all(1),
                                child: ClipRRect(
                                  clipBehavior: Clip.antiAlias,
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(
                                    tmpx,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      Container(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          ...List.generate(
                            listVideo.isEmpty ? 0 : listVideo.length,
                                (index) => Indicator(
                              isActive: _currentPos1 == index ? true : false,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        height: 8,
                      ),
                      Row(
                        children: <Widget>[
                          const Text(
                            'Aplikasi Penataan Ruang',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            textScaler: TextScaler.linear(1.0),
                          ),
                          const Spacer(),
                          TextButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute<void>(
                                  builder: (BuildContext context) => const Aplikasi(),
                                ),
                              );
                            },
                            child: const Text(
                              'Lihat Semua',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFFEC32F),
                              ),
                              textScaler: TextScaler.linear(1.0),
                            ),
                          ),
                        ],
                      ),
                      Center(
                        child: Wrap(
                          children: <Widget>[
                            ...List.generate(
                              listApps.isEmpty ? 0 : listApps.length,
                                  (index) => Padding(
                                padding: const EdgeInsets.all(4),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute<void>(
                                        builder: (BuildContext context) => DetailAplikasi(myId: listIdApps[index],),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    width: (MediaQuery.of(context).size.width - 60) / 3,
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
                      Container(
                        height: 16,
                      ),
                      const Text(
                        'Agenda',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textScaler: TextScaler.linear(1.0),
                      ),
                      Container(
                        height: 16,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width - 32,
                        height: (MediaQuery.of(context).size.width - 32) * (9 / 16),
                        decoration: const BoxDecoration(
                        ),
                        child: PageView.builder(
                          controller: pcAgenda,
                          itemCount: listJudulAgenda.isEmpty ? 0 : listJudulAgenda.length,
                          onPageChanged: (value) {
                            setState(() {
                              _currentPos2 = value;
                            });
                          },
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute<void>(
                                    builder: (BuildContext context) => DetailAgenda(myId: listIdAgenda[index],),
                                  ),
                                );
                              },
                              child: Stack(
                                children: [
                                  Positioned(
                                    child: Container(
                                      width: MediaQuery.of(context).size.width - 32,
                                      height: (MediaQuery.of(context).size.width - 32) * (9 / 16),
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(8),
                                        ),
                                        color: Colors.white,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(1),
                                        child: ClipRRect(
                                          clipBehavior: Clip.antiAlias,
                                          borderRadius: BorderRadius.circular(8),
                                          child: Image.network(
                                            listAgenda[index].toString()==''?'https://sukaphp.com/assets/noimage.png':'https://simtaru.kaltimprov.go.id/storage/${listAgenda[index].toString()}',
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 4,
                                    child: Container(
                                      margin: const EdgeInsets.all(8),
                                      padding: const EdgeInsets.all(8),
                                      width: MediaQuery.of(context).size.width - 48,
                                      decoration: BoxDecoration(
                                        color: Colors.white.withAlpha(200),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Center(
                                        child: Text(
                                          listJudulAgenda.isEmpty
                                              ? ''
                                              : (listJudulAgenda[_currentPos2]),
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.black.withAlpha(255),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      Container(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          ...List.generate(
                            listJudulAgenda.isEmpty ? 0 : listJudulAgenda.length,
                                (index) => Indicator2(
                              isActive2: _currentPos2 == index ? true : false,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        height: 16,
                      ),
                      const Text(
                        'Berita',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textScaler: TextScaler.linear(1.0),
                      ),
                      Container(
                        height: 16,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width - 32,
                        height: (MediaQuery.of(context).size.width - 32) * (9 / 16),
                        decoration: const BoxDecoration(
                        ),
                        child: PageView.builder(
                          controller: pcBerita,
                          itemCount: listJudulBerita.isEmpty ? 0 : listJudulBerita.length,
                          onPageChanged: (value) {
                            setState(() {
                              _currentPos3 = value;
                            });
                          },
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute<void>(
                                    builder: (BuildContext context) => DetailBerita(myId: listIdBerita[index],),
                                  ),
                                );
                              },
                              child: Stack(
                                children: [
                                  Positioned(
                                    child: Container(
                                      width: MediaQuery.of(context).size.width - 32,
                                      height: (MediaQuery.of(context).size.width - 32) * (9 / 16),
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(8),
                                        ),
                                        color: Colors.white,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(1),
                                        child: ClipRRect(
                                          clipBehavior: Clip.antiAlias,
                                          borderRadius: BorderRadius.circular(8),
                                          child: Image.network(
                                            listIsiBerita[index].toString()==''?'https://sukaphp.com/assets/noimage.png':'https://simtaru.kaltimprov.go.id/storage/${listIsiBerita[index].toString()}',
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 4,
                                    child: Container(
                                      margin: const EdgeInsets.all(8),
                                      padding: const EdgeInsets.all(8),
                                      width: MediaQuery.of(context).size.width - 48,
                                      decoration: BoxDecoration(
                                        color: Colors.white.withAlpha(200),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Center(
                                        child: Text(
                                          listJudulBerita.isEmpty
                                              ? ''
                                              : (listJudulBerita[_currentPos3]),
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.black.withAlpha(255),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      Container(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          ...List.generate(
                            listJudulBerita.isEmpty ? 0 : listJudulBerita.length,
                                (index) => Indicator3(
                              isActive3: _currentPos3 == index ? true : false,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        height: 48,
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

class Indicator extends StatelessWidget {
  final bool isActive;
  const Indicator({super.key, required this.isActive});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 16,
      height: 8,
      margin: const EdgeInsets.symmetric(horizontal: 2),
      decoration: BoxDecoration(
        color: isActive ? Colors.orange.shade600 : Colors.grey,
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}

class Indicator2 extends StatelessWidget {
  final bool isActive2;
  const Indicator2({super.key, required this.isActive2});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 16,
      height: 8,
      margin: const EdgeInsets.symmetric(horizontal: 2),
      decoration: BoxDecoration(
        color: isActive2 ? Colors.orange.shade600 : Colors.grey,
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}

class Indicator3 extends StatelessWidget {
  final bool isActive3;
  const Indicator3({super.key, required this.isActive3});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 16,
      height: 8,
      margin: const EdgeInsets.symmetric(horizontal: 2),
      decoration: BoxDecoration(
        color: isActive3 ? Colors.orange.shade600 : Colors.grey,
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}
