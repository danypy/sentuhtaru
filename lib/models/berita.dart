class Berita {
  String? id, title, tgl, excerpt;

  Berita({this.id, this.title, this.tgl, this.excerpt});

  factory Berita.fromJson(Map<String, dynamic> json) {
    return Berita(
        id: json['id'],
        title: json['title'],
        tgl: json['tgl'],
        excerpt: json['excerpt']);
  }
}