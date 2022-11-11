class CharacterFilters {
  String? name;
  String? species;

  CharacterFilters({
    this.name,
    this.species,
  });

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {};

    if (name != null) {
      map['name'] = name;
    }

    if (species != null) {
      map['species'] = species;
    }

    return map;
  }

  @override
  String toString() => 'CharacterFilters(name: $name, species: $species)';
}
