import 'package:ricky_and_morty/apps/characters/domain/models/character.dart';
import 'package:ricky_and_morty/common/models/rick_and_morty_api/info.dart';

class GetAllCharactersResponse {
  Info info;
  List<Character> characters;

  GetAllCharactersResponse({
    required this.info,
    required this.characters,
  });
}
