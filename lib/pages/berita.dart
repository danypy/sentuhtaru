import 'package:flutter/material.dart';
import 'package:sentuhtaru/plugin.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Berita extends StatefulWidget {
  const Berita({super.key});

  @override
  State<Berita> createState() => _Berita();
}

class _Berita extends State<Berita> {
  String urix = 'https://simtaru.kaltimprov.go.id/api/berita/20?page=1';
  String nextPage = '';
  bool lastPage = false;
  int jmlData = 0;
  List _data = [];
  final ScrollController _scrollController = ScrollController();

  void onScroll() {
    double maxScroll = _scrollController.position.maxScrollExtent;
    double currentScroll = _scrollController.position.pixels;

    if (currentScroll == maxScroll) {
      loadData(nextPage);
      print("============ load maneh");
    }
  }

  Future loadData(uriy) async {
    try {
      if(lastPage==false){
        final response = await http.get(Uri.parse(uriy));

        if (response.statusCode == 200) {
          print(response.body);
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
      print(e);
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
      ListView.builder(
        controller: _scrollController,
        itemCount: jmlData,
        itemBuilder: (context, index) {
          return ListTile(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  _data[index]['tgl'],
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                Text(
                  _data[index]['title'],
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                Divider(height: 2,)
              ],
            ),
          );
        },
      ),
    );
  }
}