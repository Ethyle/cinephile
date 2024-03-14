class Series {
  final int id;
  final String synopsis;
  final String imageUrl;
  final String title;
  final int numberOfEpisodes;
  final String releaseDate;
  final String characterCredits; // Supposed to be a List of character identifiers
  final String apiDetailUrl; // API detail URL for the series

  Series({
    required this.id,
    this.synopsis = 'Information inconnue',
    required this.imageUrl,
    required this.title,
    required this.numberOfEpisodes,
    this.releaseDate = 'Information inconnue',
    this.characterCredits = 'Information inconnue',
    this.apiDetailUrl = '',
  });

  factory Series.fromJson(Map<String, dynamic> json) {
    return Series(
      id: json['id'] ?? 0, // Assuming 'id' is a top-level field in the JSON
      synopsis: json['description'] ?? 'Information inconnue',
      imageUrl: json['image']?['medium_url'] ?? 'information inconnue',
      title: json['name'] ?? 'Information inconnue',
      numberOfEpisodes: json['count_of_episodes'] ?? 0,
      releaseDate: json['start_year'] ?? 'Information inconnue',
      characterCredits: json['character_credits'] ?? 'Information Inconnue',
      apiDetailUrl: json['api_detail_url'] ?? '',
    );
  }
}
