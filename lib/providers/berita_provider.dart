import 'package:flutter/foundation.dart';
import 'package:sentuhtaru/models/berita.dart';
import 'package:sentuhtaru/repositories/berita_repositories.dart';

class BeritaProvider extends ChangeNotifier {
  final BeritaRepository _beritaRepository = BeritaRepository();
  final int _limit = 20;
  int _page = 1;
  bool hasMore = true;
  List<Berita> beritas = [];

  Future fetchBerita() async {
    try {
      List<Berita> response = await _beritaRepository.getBerita(_page);

      if (response.length < _limit) {
        hasMore = false;
      }

      beritas.addAll(response);

      _page++;
      notifyListeners();
    } catch (e) {
      if (kDebugMode) print(e.toString());
    }
  }

  Future refresh() async {
    _page = 1;
    beritas = [];
    hasMore = true;
    await fetchBerita();
    notifyListeners();
  }
}