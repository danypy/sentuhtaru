import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:sentuhtaru/pages/aplikasi.dart';
import 'package:sentuhtaru/pages/homepage.dart';
import 'package:sentuhtaru/pages/kontak.dart';
import 'package:sentuhtaru/pages/profil.dart';
import 'package:sentuhtaru/pages/pejabat.dart';
import 'package:sentuhtaru/pages/semuaagenda.dart';
import 'package:sentuhtaru/pages/semuaberita.dart';
import 'package:sentuhtaru/pages/playlist.dart';
import 'package:sentuhtaru/pages/galeri.dart';
import 'package:sentuhtaru/pages/layanan.dart';
import 'package:sentuhtaru/pages/webgis.dart';
import 'package:sentuhtaru/pages/infotaru.dart';

class Buildbottommenu extends StatelessWidget {
  const Buildbottommenu({super.key});

  @override
  Widget build(BuildContext context) {
    return ConvexAppBar(
      style: TabStyle.fixedCircle,
      initialActiveIndex: 2,
      backgroundColor: Colors.white,
      items: const [
        TabItem(icon: Icons.info, title: 'Info Taru'),
        TabItem(icon: Icons.map, title: 'Webgis'),
        TabItem(icon: Icons.home, title: 'Home'),
        TabItem(icon: Icons.dashboard, title: 'Layanan'),
        TabItem(icon: Icons.person, title: 'Profil'),
      ],
      color: const Color(0xFF053400),
      activeColor: const Color(0xFF053400),
      onTap: (index) {
        if(index==0){
          Navigator.pushReplacement(
            context,
            MaterialPageRoute<void>(
              builder: (BuildContext context) => const Infotaru(),
            ),
          );
        }
        if(index==1){
          Navigator.pushReplacement(
            context,
            MaterialPageRoute<void>(
              builder: (BuildContext context) => const Webgis(),
            ),
          );
        }
        if(index==2){
          Navigator.pushReplacement(
            context,
            MaterialPageRoute<void>(
              builder: (BuildContext context) => const Homepage(),
            ),
          );
        }
        if(index==3){
          Navigator.pushReplacement(
            context,
            MaterialPageRoute<void>(
              builder: (BuildContext context) => const Layanan(),
            ),
          );
        }
        if(index==4){
          Navigator.pushReplacement(
            context,
            MaterialPageRoute<void>(
              builder: (BuildContext context) => const Profil(),
            ),
          );
        }
      },
    );
  }
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
              Navigator.pushReplacement(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => const Homepage(),
                ),
              );
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
              Navigator.pushReplacement(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => const Profil(),
                ),
              );
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
              Navigator.pushReplacement(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => const Pejabat(),
                ),
              );
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
              Navigator.pushReplacement(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => const Aplikasi(),
                ),
              );
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
              Navigator.pushReplacement(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => const SemuaAgenda(),
                ),
              );
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
              Navigator.pushReplacement(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => const SemuaBerita(),
                ),
              );
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
              Navigator.pushReplacement(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => const Playlist(),
                ),
              );
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
              Navigator.pushReplacement(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => const Galeri(),
                ),
              );
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
              Navigator.pushReplacement(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => const Layanan(),
                ),
              );
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
              Navigator.pushReplacement(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => const Kontak(),
                ),
              );
            },
          ),
          const Divider(height: 1, thickness: 1),
        ],
      ),
    );
  }
}