class Episode {
  final String series;
  final String name;
  final String description;
  final String imageUrl;
  final String airDate;

  Episode({
    required this.series,
    required this.name,
    this.description = 'Information inconnue',
    required this.imageUrl,
    required this.airDate,
  });

  factory Episode.fromJson(Map<String, dynamic> json) {
    return Episode(
      series: json['series'] ?? '',
      name: json['name'] ?? 'Épisode inconnu',
      description: json['description'] ?? 'Information inconnue',
      imageUrl: json['image'] ?? 'default_image_url', // Remplacez 'default_image_url' par une URL d'image par défaut
      airDate: json['air_date'] ?? 'inconnue', // Utilisez une date par défaut si 'air_date' est null
    );
  }
}
