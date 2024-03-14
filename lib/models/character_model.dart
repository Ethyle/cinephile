class Character {
  final String name;
  final String imageUrl;
  final String description;
  final String realName;
  final int gender;
  final String? birth;

  Character({
    required this.name,
    required this.imageUrl,
    this.description = 'Information inconnue',
    this.realName = 'Information inconnue',
    this.gender = 0, // Assurez-vous que la valeur par défaut est un int
    this.birth,
  });

  factory Character.fromJson(Map<String, dynamic> json) {
    return Character(
      name: json['name'] ?? 'Information inconnue',
      imageUrl: json['image']['medium_url'] ?? 'Information inconnue',
      description: json['description'] ?? 'Information inconnue',
      realName: json['real_name'] ?? 'Information inconnue',
      gender: json['gender'] ?? 0, // Assurez-vous d'utiliser 0 ou un autre int comme valeur par défaut
      birth: json['birth'],
    );
  }
}
