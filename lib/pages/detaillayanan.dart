import 'package:flutter/material.dart';
import 'package:sentuhtaru/plugin.dart';

class DetailLayanan extends StatefulWidget {
  final int myId;
  final String myTitle;
  final String myUrl;
  const DetailLayanan({super.key, required this.myId, required this.myTitle, required this.myUrl});

  @override
  State<DetailLayanan> createState() => _DetailLayanan();
}

class _DetailLayanan extends State<DetailLayanan> {
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

            ],
          ),
        ),
      ),
    );
  }
}