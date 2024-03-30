class Episode {
  final int seriesId; 
  final String name;
  final String description;
  final String imageUrl;
  final String airDate;
  final String episodeNumber; 

  Episode({
    required this.seriesId,
    required this.name,
    this.description = 'Information inconnue',
    required this.imageUrl,
    required this.airDate,
    required this.episodeNumber,
  });

  factory Episode.fromJson(Map<String, dynamic> json) {
    return Episode(
      seriesId: json['id'], 
      name: json['name'] ?? 'Épisode inconnu',
      description: json['description'] ?? 'Information inconnue',
      imageUrl: json['image']['icon_url'] ?? 'default_image_url', 
      airDate: json['air_date'] ?? 'Date inconnue',
      episodeNumber: json['episode_number'], 
    );
  }
}
