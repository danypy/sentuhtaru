import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';
import 'package:sentuhtaru/pages/infotaru.dart';
import 'package:sentuhtaru/pages/webgis.dart';
import 'package:sentuhtaru/pages/homepage.dart';
import 'package:sentuhtaru/pages/layanan.dart';

Widget halaman(ctz, Widget halamannya) {
  return ScreenUtilInit(
    designSize: const Size(360, 690),
    minTextAdapt: true,
    splitScreenMode: true,
    builder: (_, child) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
        ),
        home: SafeArea(child: Scaffold(
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
                bottom: BorderSide(color: Colors.white30, width: 1)),
            elevation: 4,
          ),
          bottomNavigationBar: navigasiBawah(ctz),
          drawer: BuildDrawer(ctx: ctz),
          body: halamannya,
        ),
        ),
      );
    },
  );
}

navigasiBawah(BuildContext context) {
  return StylishBottomBar(
    option: AnimatedBarOptions(),
    items: [
      BottomBarItem(
        icon: const Icon(
          Icons.info,
        ),
        title: const Text('Info Taru'),
        selectedColor: const Color(0xFF053400),
        unSelectedColor: const Color(0xFF053400),
      ),
      BottomBarItem(
        icon: const Icon(
          Icons.map,
        ),
        title: const Text('Webgis'),
        selectedColor: const Color(0xFF053400),
        unSelectedColor: const Color(0xFF053400),
      ),
      BottomBarItem(
        icon: const Icon(
          Icons.home,
        ),
        title: const Text('Home'),
        selectedColor: const Color(0xFF053400),
        unSelectedColor: const Color(0xFF053400),
      ),
      BottomBarItem(
        icon: const Icon(
          Icons.dashboard,
        ),
        title: const Text('Layanan'),
        selectedColor: const Color(0xFF053400),
        unSelectedColor: const Color(0xFF053400),
      ),
      BottomBarItem(
        icon: const Icon(
          Icons.person,
        ),
        title: const Text('Profil'),
        selectedColor: const Color(0xFF053400),
        unSelectedColor: const Color(0xFF053400),
      ),
    ],
    onTap: (index) {
      if(index==0){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Infotaru()),
        );
      }
      if(index==1){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Webgis()),
        );
      }
      if(index==2){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Homepage()),
        );
      }
      if(index==3){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Homepage()),
        );
      }
    },
  );
}

class BuildDrawer extends StatelessWidget {
  const BuildDrawer({super.key, required BuildContext ctx});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const Divider(height: 16, thickness: 16),
          ListTile(
            title: const Text(
              'Menu Aplikasi',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
              textScaler: TextScaler.linear(1.0),
            ),
            onTap: () {

            },
          ),
          const Divider(height: 1, thickness: 1),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text(
              'Home',
              style: TextStyle(
                fontSize: 12,
              ),
              textScaler: TextScaler.linear(1.0),
            ),
            onTap: () {
            },
          ),
          const Divider(height: 1, thickness: 1),
          ListTile(
            leading: const Icon(Icons.apartment),
            title: const Text(
              'Profil',
              style: TextStyle(
                fontSize: 12,
              ),
              textScaler: TextScaler.linear(1.0),
            ),
            onTap: () {
            },
          ),
          const Divider(height: 1, thickness: 1),
          ListTile(
            leading: const Icon(Icons.people),
            title: const Text(
              'Pegawai',
              style: TextStyle(
                fontSize: 12,
              ),
              textScaler: TextScaler.linear(1.0),
            ),
            onTap: () {
            },
          ),
          const Divider(height: 1, thickness: 1),
          ListTile(
            leading: const Icon(Icons.apps),
            title: const Text(
              'Aplikasi',
              style: TextStyle(
                fontSize: 12,
              ),
              textScaler: TextScaler.linear(1.0),
            ),
            onTap: () {
            },
          ),
          const Divider(height: 1, thickness: 1),
          ListTile(
            leading: const Icon(Icons.calendar_month),
            title: const Text(
              'Agenda',
              style: TextStyle(
                fontSize: 12,
              ),
              textScaler: TextScaler.linear(1.0),
            ),
            onTap: () {
            },
          ),
          const Divider(height: 1, thickness: 1),
          ListTile(
            leading: const Icon(Icons.list),
            title: const Text(
              'Berita',
              style: TextStyle(
                fontSize: 12,
              ),
              textScaler: TextScaler.linear(1.0),
            ),
            onTap: () {
            },
          ),
          const Divider(height: 1, thickness: 1),
          ListTile(
            leading: const Icon(Icons.videocam_outlined),
            title: const Text(
              'Video',
              style: TextStyle(
                fontSize: 12,
              ),
              textScaler: TextScaler.linear(1.0),
            ),
            onTap: () {
            },
          ),
          const Divider(height: 1, thickness: 1),
          ListTile(
            leading: const Icon(Icons.image),
            title: const Text(
              'Galeri',
              style: TextStyle(
                fontSize: 12,
              ),
              textScaler: TextScaler.linear(1.0),
            ),
            onTap: () {
            },
          ),
          const Divider(height: 1, thickness: 1),
          ListTile(
            leading: const Icon(Icons.dashboard),
            title: const Text(
              'Layanan',
              style: TextStyle(
                fontSize: 12,
              ),
              textScaler: TextScaler.linear(1.0),
            ),
            onTap: () {
            },
          ),
          const Divider(height: 1, thickness: 1),
          ListTile(
            leading: const Icon(Icons.mail),
            title: const Text(
              'Kontak',
              style: TextStyle(
                fontSize: 12,
              ),
              textScaler: TextScaler.linear(1.0),
            ),
            onTap: () {
            },
          ),
          const Divider(height: 1, thickness: 1),
        ],
      ),
    );
  }
}