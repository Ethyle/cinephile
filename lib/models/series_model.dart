class Series {
  final int id;
  final String synopsis;
  final String imageUrl;
  final String title;
  final int numberOfEpisodes;
  final String releaseDate; 
  final String apiDetailUrl;

  Series({
    required this.id,
    this.synopsis = 'Information inconnue',
    required this.imageUrl,
    required this.title,
    required this.numberOfEpisodes,
    this.releaseDate = 'Information inconnue',
    required this.apiDetailUrl,
  });

  factory Series.fromJson(Map<String, dynamic> json) {
    return Series(
      id: json['id'] ?? 0,
      synopsis: json['description'] ?? 'Information inconnue',
      imageUrl: json['image']['medium_url'] ?? 'information inconnue', 
      title: json['name'] ?? 'Information inconnue',
      numberOfEpisodes: json['count_of_episodes'] ?? 0,
      releaseDate: json['start_year']?.toString() ?? 'Information inconnue', 
      apiDetailUrl: json['api_detail_url'] ?? '',
    );
  }
}
