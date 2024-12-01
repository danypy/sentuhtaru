import 'package:flutter/material.dart';
import 'package:sentuhtaru/plugin.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:sentuhtaru/pages/detailgaleri.dart';

class Galeri extends StatefulWidget {
  const Galeri({super.key});

  @override
  State<Galeri> createState() => _Galeri();
}

class _Galeri extends State<Galeri> {
  String urix = 'https://simtaru.kaltimprov.go.id/api/galeri/5?page=1';
  String nextPage = '';
  bool lastPage = false;
  int jmlData = 0;
  List _data = [];
  final ScrollController _scrollController = ScrollController();

  Future loadData(uriy) async {
    try {
      if(lastPage==false){
        final response = await http.get(Uri.parse(uriy));

        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          setState(() {
            if(data['next_page_url'] == null){
              lastPage = true;
            }
            nextPage = data['next_page_url'];
            if(jmlData==0){
              _data = data['data'];
            }else{
              _data.addAll(data['data']);
            }
            jmlData = _data.length;
          });
        }
      }
    } catch (e) {
      //print(e);
    }
  }

  void onScroll() {
    double maxScroll = _scrollController.position.maxScrollExtent;
    double currentScroll = _scrollController.position.pixels;

    if (currentScroll == maxScroll) {
      loadData(nextPage);
    }
  }

  @override
  void initState() {
    super.initState();
    loadData(urix);
    _scrollController.addListener(onScroll);
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
      Stack(
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 8, 16, 16),
            child: Text(
              'Galeri Photo',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFFFEC32F),
              ),
              textScaler: TextScaler.linear(1.0),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 45, 0, 0),
            child: ListView.builder(
              controller: _scrollController,
              itemCount: jmlData,
              itemBuilder: (context, index) {
                return ListTile(
                  title: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => DetailGaleri(
                          myId: _data[index]['id'],
                          myTitle: _data[index]['judul'].toString(),
                          myTgl: tglIndo(_data[index]['created_at'].toString()),
                        )),
                      );
                    },
                    child: ClipRRect(
                      clipBehavior: Clip.antiAlias,
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        color: Colors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              width: (MediaQuery.of(context).size.width) / 1,
                              decoration: BoxDecoration(
                                color: Colors.white.withAlpha(255),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(4),
                                child: Image.network(
                                  _data[index]['gambar'].toString()=='null'?'https://sukaphp.com/assets/noimage.png':'https://simtaru.kaltimprov.go.id/storage/${_data[index]['gambar'].toString()}',
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            Container(
                              width: ((MediaQuery.of(context).size.width)) / 1,
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: Colors.white.withAlpha(200),
                              ),
                              child: Center(
                                child: Text(
                                  _data[index]['judul'].toString(),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black.withAlpha(255),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            const Divider(
                              height: 2,
                            ),
                            Container(
                              width: ((MediaQuery.of(context).size.width)) / 1,
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: Colors.white.withAlpha(200),
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
                                      tglIndo(_data[index]['created_at'].toString()),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.black.withAlpha(255),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
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