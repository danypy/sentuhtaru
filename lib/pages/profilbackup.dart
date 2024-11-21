import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sentuhtaru/plugin.dart';
import 'package:sentuhtaru/pages/halaman.dart';
import 'package:accordion/accordion.dart';

class Profil extends StatelessWidget {
  const Profil({super.key});

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
  List<int> listId = <int>[];
  List<String> listJudul = <String>['Link 1', 'Link 2', 'Link 3'];

  @override
  void initState() {
    super.initState();

    loadData();
  }

  void loadData() async {
    setState(() {
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
                      Wrap(
                        children: [
                          ...List.generate(
                            listJudul.isEmpty ? 0 : listJudul.length,
                                (index) => Container(
                              margin: const EdgeInsets.fromLTRB(0, 0, 0, 4),
                              decoration: BoxDecoration(
                                color: Colors.white.withAlpha(255),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(8),
                                ),
                              ),
                              child: ListTile(
                                title: Text(
                                  listJudul[index],
                                  style: const TextStyle(
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
                                      builder: (BuildContext context) => const Halaman(),
                                    ),
                                  );
                                },
                              ),
                            ),
                          )
                        ],
                      ),
                      Container(
                        height: 16,
                      ),
                      Accordion(
                        children: [
                          AccordionSection(
                            header: const Text('data'),
                            content: const Text('aaaa'),
                          ),
                          AccordionSection(
                            header: const Text('data'),
                            content: const Text('aaaa'),
                          ),
                          AccordionSection(
                            header: const Text('data'),
                            content: const Text('aaaa'),
                          ),
                        ],
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