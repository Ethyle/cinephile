class Series {
  final String synopsis;
  final String imageUrl;
  final String title;
  final int numberOfEpisodes;
  final String releaseDate;

  Series({
    this.synopsis = 'Information inconnue',
    required this.imageUrl,
    required this.title,
    required this.numberOfEpisodes,
    this.releaseDate = 'Information inconnue',
  });

factory Series.fromJson(Map<String, dynamic> json) {
  return Series(
    synopsis: json['description'] ?? 'Information inconnue',
    imageUrl: json['image']['medium_url'] ?? 'Information inconnue',
    title: json['name'] ?? 'Information inconnue',
    numberOfEpisodes: json['count_of_episodes'] ?? 'Information inconnue',
    releaseDate: json['start_year	'] ?? 'Information inconnue',
  );
}

}


