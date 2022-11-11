class Character {
  final int id;
  final String name;
  final CharacterStatus status;
  final String species;
  final String type;
  final CharacterGender gender;
  final CharacterOrigin origin;
  final CharacterLocation location;
  final String image;
  final List<String> episode;
  final String url;
  final DateTime created;

  Character({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.type,
    required this.gender,
    required this.origin,
    required this.location,
    required this.image,
    required this.episode,
    required this.url,
    required this.created,
  });

  factory Character.fromMap(Map<String, dynamic> map) {
    return Character(
      id: map['id'],
      name: map['name'],
      status: CharacterStatus.fromString(map['status']),
      species: map['species'],
      type: map['type'],
      gender: CharacterGender.fromString(map['gender']),
      origin: CharacterOrigin.fromMap(map['origin']),
      location: CharacterLocation.fromMap(map['location']),
      image: map['image'],
      episode: List<String>.from(map['episode'].map((x) => x)),
      url: map['url'],
      created: DateTime.parse(map['created']),
    );
  }

  @override
  String toString() {
    return 'Character(id: $id, name: $name, status: $status, species: $species, type: $type, gender: $gender, origin: $origin, location: $location, image: $image, episode: $episode, url: $url, created: $created)';
  }
}

class CharacterLocation {
  CharacterLocation({
    required this.name,
    required this.url,
  });

  String name;
  String url;

  factory CharacterLocation.fromMap(Map<String, dynamic> map) {
    return CharacterLocation(
      name: map['name'],
      url: map['url'],
    );
  }
}

class CharacterOrigin {
  CharacterOrigin({
    required this.name,
    required this.url,
  });

  String name;
  String url;

  factory CharacterOrigin.fromMap(Map<String, dynamic> map) {
    return CharacterOrigin(
      name: map['name'],
      url: map['url'],
    );
  }
}

enum CharacterStatus {
  alive(translation: 'Vivo'),
  dead(translation: 'Morto'),
  unknown(translation: 'Desconhecido');

  const CharacterStatus({required this.translation});

  final String translation;

  static fromString(String str) {
    switch (str) {
      case 'Alive':
        return alive;
      case 'Dead':
        return dead;
      case 'unknown':
        return unknown;
      default:
        throw UnimplementedError('Case $str not implemented');
    }
  }
}

enum CharacterGender {
  female(translation: 'Feminino'),
  male(translation: 'Masculino'),
  genderless(translation: 'Sem gênero'),
  unknown(translation: 'Desconhecido');

  const CharacterGender({required this.translation});

  final String translation;

  static fromString(String str) {
    switch (str) {
      case 'Female':
        return female;
      case 'Male':
        return male;
      case 'Genderless':
        return genderless;
      case 'unknown':
        return unknown;
      default:
        throw UnimplementedError('Case $str not implemented');
    }
  }
}
