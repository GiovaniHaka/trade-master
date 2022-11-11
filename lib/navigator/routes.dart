import 'package:flutter/material.dart';
import 'package:ricky_and_morty/apps/characters/domain/models/character.dart';
import 'package:ricky_and_morty/apps/characters/presentation/character_details/character_details_screen.dart';
import 'package:ricky_and_morty/apps/characters/presentation/characters_list/characters_list_screen.dart';
import 'package:ricky_and_morty/apps/characters/presentation/favorite_characters/favorite_characters_screen.dart';
import 'package:ricky_and_morty/navigator/transitions/cupertino_transition.dart';

class Routes {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static const String root = '/';

  // Authentication
  static const String characterDetails = '/character/details';
  static const String favorites = '/favorites';

  static onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case root:
        return CupertinoTransition(const CharactersListScreen());

      case characterDetails:
        final character = settings.arguments as Character;
        return CupertinoTransition(
          CharacterDetailsScreen(character: character),
        );

      case favorites:
        return CupertinoTransition(const FavoriteCharactersScreen());

      default:
        assert(false, 'Need to implement ${settings.name}');
        return null;
    }
  }
}
