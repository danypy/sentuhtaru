import 'package:flutter/material.dart';
import 'package:sentuhtaru/plugin.dart';

import 'package:sentuhtaru/pages/detailinfotaru_satu.dart';
import 'package:sentuhtaru/pages/detailinfotaru_dua.dart';
import 'package:sentuhtaru/pages/detailinfotaru_tiga.dart';

class Infotaru extends StatefulWidget {
  const Infotaru({super.key});

  @override
  State<Infotaru> createState() => _Infotaru();
}

class _Infotaru extends State<Infotaru> {
  @override
  void initState() {
    super.initState();

    loadData();
  }

  void loadData() async {
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const DetailInfoTaruSatu()),
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const DetailInfoTaruDua()),
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const DetailInfoTaruTiga()),
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
    );
  }
}