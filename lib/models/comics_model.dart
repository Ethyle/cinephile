class CharacterCredit {
  final String name;
  final String role;
  final String imageUrl;

  CharacterCredit({
    required this.name,
    required this.role,
    required this.imageUrl,
  });
}

class PersonCredit {
  final String name;
  final String role;
  final String imageUrl;

  PersonCredit({
    required this.name,
    required this.role,
    required this.imageUrl,
  });
}

class Comic {
  final String name;
  final String imageUrl;
  final String description;
  final String releaseDate;
  final String numberOfVolume;
  final List<CharacterCredit> characterCredits;
  final List<PersonCredit> personCredits;

  Comic({
    required this.name,
    required this.imageUrl,
    this.description = 'Information inconnue',
    this.releaseDate = 'Information inconnue',
    this.numberOfVolume = 'Information inconnue',
    required this.characterCredits,
    required this.personCredits,
  });

  factory Comic.fromJson(Map<String, dynamic> json) {
    // Assuming 'character_credits' and 'person_credits' are lists of maps
    List<CharacterCredit> parsedCharacterCredits = (json['character_credits'] as List).map((characterJson) {
      // Assuming 'characterJson' is a Map with 'name', 'role', and 'image' keys
      return CharacterCredit(
        name: characterJson['name']?? 'Information inconnue',
        role: characterJson['role']?? 'Information inconnue',
        imageUrl: characterJson['image']['icon_url']?? 'Information inconnue',
      );
    }).toList();

    List<PersonCredit> parsedPersonCredits = (json['person_credits'] as List).map((personJson) {
      // Assuming 'personJson' is a Map with 'name', 'role', and 'image' keys
      return PersonCredit(
        name: personJson['name']?? 'Information inconnue',
        role: personJson['role']?? 'Information inconnue',
        imageUrl: personJson['image']['icon_url']?? 'Information inconnue',
      );
    }).toList();

    return Comic(
      name: json['name'] ?? 'Information inconnue',
      imageUrl: json['image']['medium_url'] ?? 'Information inconnue',
      description: json['description'] ?? 'Information inconnue',
      releaseDate: json['cover_date'] ?? 'Information inconnue',
      numberOfVolume: json['issue_number'] ?? 'Information inconnue',
      characterCredits: parsedCharacterCredits?? [],
      personCredits: parsedPersonCredits ?? [],
    );
  }
}

