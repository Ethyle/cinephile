class Comic {
  final String name;
  final String imageUrl;
  final String description;
  final String releaseDate;
  final String numberOfVolume;

  Comic({
    required this.name,
    required this.imageUrl,
    this.description = 'Information inconnue',
    this.releaseDate = 'Information inconnue',
    this.numberOfVolume = 'Information inconnue',
  });

  factory Comic.fromJson(Map<String, dynamic> json) {
    return Comic(
      name: json['name'] ?? 'Information inconnue',
      imageUrl: json['image']['medium_url'] ?? 'Information inconnue', 
      description: json['description'] ?? 'Information inconnue',
      releaseDate: json['cover_date'] ?? 'Information inconnue',
      numberOfVolume: json['issue_number'] ?? 'Information inconnue', 
    );
  }
}
