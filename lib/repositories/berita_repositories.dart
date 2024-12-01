import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sentuhtaru/models/berita.dart';

class BeritaRepository {
  final String _baseUrl = "https://simtaru.kaltimprov.go.id/";
  Future<List<Berita>> getBerita(int page) async {
    final response = await http
        .get(Uri.parse("$_baseUrl/api/berita/20?page=$page"));
    final data = json.decode(response.body)['data'];
    return List<Berita>.from(data.map((e) => Berita.fromJson(e)));
  }
}