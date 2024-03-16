class Series {
  final int id;
  final String synopsis;
  final String imageUrl;
  final String title;
  final int numberOfEpisodes;
  final String releaseDate; // 'start_year' semble être l'année de début, donc il pourrait être traité différemment.
  // Suppression de characterCredits car il n'est pas présent dans le JSON fourni.
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
      imageUrl: json['image']['medium_url'] ?? 'information inconnue', // Assumant que 'medium_url' est approprié ici.
      title: json['name'] ?? 'Information inconnue',
      numberOfEpisodes: json['count_of_episodes'] ?? 0,
      releaseDate: json['start_year']?.toString() ?? 'Information inconnue', // Converti 'start_year' en String si nécessaire.
      apiDetailUrl: json['api_detail_url'] ?? '',
    );
  }
}
