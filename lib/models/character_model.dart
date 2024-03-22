class Character {
  final String name;
  final String? imageUrl; // imageUrl peut être null
  final String description;
  final String realName;
  final int gender;
  final String? birth;

  Character({
    required this.name,
    this.imageUrl, // Pas de valeur par défaut ici, permettant à imageUrl d'être null
    this.description = 'Information inconnue',
    this.realName = 'Information inconnue',
    this.gender = 0,
    this.birth,
  });

  factory Character.fromJson(Map<String, dynamic> json) {
    return Character(
      name: json['name'] ?? 'Information inconnue',
      imageUrl: json['image']?['medium_url'], // Aucune valeur par défaut assignée
      description: json['description'] ?? 'Information inconnue',
      realName: json['real_name'] ?? 'Information inconnue',
      gender: json['gender'] ?? 0,
      birth: json['birth'],
    );
  }
}
