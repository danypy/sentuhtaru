import 'package:flutter/material.dart';
import 'package:sentuhtaru/plugin.dart';
import 'package:sentuhtaru/pages/agenda.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class DetailAgenda extends StatefulWidget {
  final int myId;
  const DetailAgenda({super.key, required this.myId});

  @override
  State<DetailAgenda> createState() => _DetailAgenda();
}

class _DetailAgenda extends State<DetailAgenda> {
  String xjudul = '';
  String xdata = '';
  String xwaktum = '';
  String xwaktus = '';
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
      xwaktum = tmpData['tgl_mulai'] ?? '';
      xwaktus = tmpData['tgl_selesai'] ?? '';
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
    return halaman(
      context,
      SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextButton(
              style: TextButton.styleFrom(
                minimumSize: const Size.fromHeight(30),
                backgroundColor: Colors.white,
                alignment: Alignment.centerLeft,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.zero),
                ),
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Agenda()),
                );
              },
              child: const Text(
                '< Agenda',
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xFF053400),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                  if (xdata != '')
                    Container(
                      height: 16,
                    ),
                  Text(
                    xjudul,
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
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(
                              Icons.calendar_month
                          ),
                          Text(
                            tglIndo(xwaktum),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.black.withAlpha(255),
                            ),
                          ),
                          Text(
                            ' - ',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.black.withAlpha(255),
                            ),
                          ),
                          Text(
                            tglIndo(xwaktus==''?xwaktum:xwaktus),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.black.withAlpha(255),
                            ),
                          ),
                        ],
                      ),
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
                  HtmlWidget(
                    xdeskripsi,
                    textStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                  Container(
                    height: 21,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String tglIndo(String str) {
    try{
        var tmp = str.substring(0,10).split("-");
        List<String> bulan = ['Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni', 'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember'];
        return '${tmp[2]} ${bulan[int.parse(tmp[1])]} ${tmp[0]}';
    }catch(e){
    }
    return '';
  }

}