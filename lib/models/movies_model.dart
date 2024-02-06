class Movie {
  final String name;
  final String imageUrl;
  final String duration;
  final String releaseDate;
  final String synopsis;
 // final List<String> characters;
  final String classification;
 // final List<String> directors; // A supposer que cela peut être déduit de 'producers' ou d'un autre champ
 // final List<String> screenwriters;
 // final List<String> producers;
  final String studio; // A supposer que cela peut être déduit de 'studios' ou d'un autre champ
  final String budget;
  final String boxOfficeRevenue;
  final String totalRevenue;

  Movie({
    required this.name,
    required this.imageUrl,
    this.duration = 'Information inconnue',
    this.releaseDate = 'Information inconnue',
    this.synopsis = 'Information inconnue',
   // this.characters = const [],
    this.classification = 'Information inconnue',
   // this.directors = const [],
   // this.screenwriters = const [],
   // this.producers = const [],
    this.studio = 'Information inconnue',
    this.budget = 'Information inconnue',
    this.boxOfficeRevenue = 'Information inconnue',
    this.totalRevenue = 'Information inconnue',
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      name: json['name'] ?? 'Information inconnue',
      imageUrl: json['image']?['medium_url'] ?? 'Information inconnue',
      duration: json['runtime'] ?? 'Information inconnue',
      releaseDate: json['release_date'] ?? 'Information inconnue',
      synopsis: json['description'] ?? 'Information inconnue',
    //  characters: (json['characters'] as List?)?.map((character) => character.toString()).toList() ?? [],
      classification: json['rating'] ?? 'Information inconnue',
    //  directors: _extractDirectors(json), // Implémenter selon la logique nécessaire
    //  screenwriters: (json['writers'] as List?)?.map((writer) => writer.toString()).toList() ?? [],
    //  producers: (json['producers'] as List?)?.map((producer) => producer.toString()).toList() ?? [],
      studio: _extractStudio(json), // Implémenter selon la logique nécessaire
      budget: json['budget'] ?? 'Information inconnue',
      boxOfficeRevenue: json['box_office_revenue'] ?? 'Information inconnue',
      totalRevenue: json['total_revenue'] ?? 'Information inconnue',
    );
  }

  static List<String> _extractDirectors(Map<String, dynamic> json) {
    // Implémenter la logique pour extraire les réalisateurs
    // Cela dépend de la structure des données de l'API
    return [];
  }

  static String _extractStudio(Map<String, dynamic> json) {
    // Implémenter la logique pour extraire le studio
    // Cela dépend de la structure des données de l'API
    return 'Information inconnue';
  }
}
