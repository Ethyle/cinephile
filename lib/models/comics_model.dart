class Comic {
  final int id;
  final String name;
  final String imageUrl;
  final String description;
  final String releaseDate;
  final String numberOfVolume;
  final String apiDetailUrl;
  List<String> credits;

  Comic({
    required this.id,
    required this.name,
    required this.imageUrl,
    this.description = 'Information inconnue',
    required this.releaseDate,
    required this.numberOfVolume,
    required this.apiDetailUrl,
    required this.credits,
  });

  factory Comic.fromJson(Map<String, dynamic> json) {
    print(json);
    return Comic(
      id: json['id'] ?? 0,
      name: json['name'] ?? 'Information inconnue',
      imageUrl: json['image']['medium_url'] ?? 'Information inconnue',
      description: json['description'] ?? 'Information inconnue',
      releaseDate: json['cover_date'] ?? 'Information inconnue',
      numberOfVolume: json['issue_number'] ?? 'Information inconnue',
      apiDetailUrl: json['api_detail_url'] ?? '',
      credits: json['person_credits'] != null ? List.from(json['person_credits'].map((credits) => credits['name'])) : [],

    );
  }
}
