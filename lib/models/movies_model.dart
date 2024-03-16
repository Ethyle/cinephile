class Movie {
  final int id;
  final String name;
  final String imageUrl;
  final String synopsis;
  final String releaseDate;
  final String duration; // Durée du film en minutes, représentée en tant que String dans le JSON
  final String budget;
  final String boxOfficeRevenue;
  final String totalRevenue;
  final String apiDetailUrl;
  List<String> producers;
  List<String> writers;
  List<String> studios;

  Movie({
    required this.id,
    required this.name,
    required this.imageUrl,
    this.synopsis = 'Information inconnue',
    required this.releaseDate,
    required this.duration,
    required this.budget,
    required this.boxOfficeRevenue,
    required this.totalRevenue,
    required this.apiDetailUrl,
    required this.producers, 
    required this.writers, 
    required this.studios
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'],
      name: json['name'] ?? 'Information inconnue',
      imageUrl: json['image']['original_url'] ?? 'Information inconnue', 
      synopsis: json['deck'] ?? 'Information inconnue', // Utilisation de 'deck' comme description
      releaseDate: json['release_date'] ?? 'Information inconnue',
      duration: json['runtime'] ?? 'Information inconnue',
      budget: json['budget'] ?? 'Information inconnue',
      boxOfficeRevenue: json['box_office_revenue'] ?? 'Information inconnue',
      totalRevenue: json['total_revenue'] ?? 'Information inconnue',
      apiDetailUrl: json['api_detail_url'] ?? '',
      producers: json['producers'] != null ? List.from(json['producers'].map((producer) => producer['name'])) : [],
      writers: json['writers'] != null ? List.from(json['writers'].map((writer) => writer['name'])) : [],
      studios: json['studios'] != null ? List.from(json['studios'].map((studio) => studio['name'])) : [],
    );
  }
}
