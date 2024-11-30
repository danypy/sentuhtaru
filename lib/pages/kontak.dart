import 'package:flutter/material.dart';
import 'package:sentuhtaru/plugin.dart';

class Kontak extends StatefulWidget {
  const Kontak({super.key});

  @override
  State<Kontak> createState() => _Kontak();
}

class _Kontak extends State<Kontak> {
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
                'Kontak',
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
              Row(
                children: [
                  Icon(
                    Icons.pin_drop,
                    size: 20,
                    color: Colors.white.withAlpha(255),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    'ALAMAT',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white.withAlpha(255),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                'Jl. Tengkawang No.1 Samarinda Kalimantan Timur 75127, Kalimantan Timur',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white.withAlpha(255),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  Icon(
                    Icons.phone,
                    size: 20,
                    color: Colors.white.withAlpha(255),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    'TELEPON',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white.withAlpha(255),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                '082155532221',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white.withAlpha(255),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Row(
                children: [
                  Icon(
                    Icons.mail,
                    size: 20,
                    color: Colors.white.withAlpha(255),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    'EMAIL',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white.withAlpha(255),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                'tataruangkaltim@gmail.com',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white.withAlpha(255),
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