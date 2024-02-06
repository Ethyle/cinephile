class News {
  final String title;
  final String imageUrl;

  News({
    required this.title,
    required this.imageUrl,
  });

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      title: json['title'] ?? 'Titre inconnu',
      imageUrl: json['imageUrl'] ?? 'Pas image'
    );
  }
}
 