import 'package:ricky_and_morty/apps/characters/domain/models/character_filters.dart';

class AllRequest {
  CharacterFilters? filters;
  String? url;
  
  AllRequest({
    this.filters,
    this.url,
  });
}
