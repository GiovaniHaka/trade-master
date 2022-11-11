import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:ricky_and_morty/apps/characters/domain/models/character.dart';
import 'package:ricky_and_morty/apps/characters/domain/models/request/multiple_request.dart';
import 'package:ricky_and_morty/apps/characters/domain/usecases/get_multiple_characters.dart';
import 'package:ricky_and_morty/apps/favorites/domain/get_all_favorites.dart';
import 'package:ricky_and_morty/apps/favorites/domain/on_change_favorites.dart';
import 'package:ricky_and_morty/common/controller/states_controller.dart';
import 'package:ricky_and_morty/common/exceptions/failure.dart';
import 'package:ricky_and_morty/common/states/states.dart';
import 'package:rx_notifier/rx_notifier.dart';

class FavoriteCharactersController extends StatesController {
  late GetAllFavorites _getAllFavorites;
  late GetMultipleCharacters _getMultipleCharacters;
  late OnChangeFavorites _onChangeFavorites;

  FavoriteCharactersController([
    GetAllFavorites? getAllFavorites,
    GetMultipleCharacters? getMultipleCharacters,
    OnChangeFavorites? onChangeFavorites,
  ]) {
    _getAllFavorites = getAllFavorites ?? GetAllFavoritesImp();
    _getMultipleCharacters =
        getMultipleCharacters ?? GetMultipleCharactersImp();
    _onChangeFavorites = onChangeFavorites ?? OnChangeFavoritesImp();
  }

  final _favorites =
      RxNotifier<Either<Failure, List<Character>>>(const Right([]));
  Either<Failure, List<Character>> get favorites => _favorites.value;

  late StreamSubscription _subscription;

  initializeFavoritesListen() {
    _subscription = _onChangeFavorites.call().listen((event) async {
      await getFavorites();
    });
  }

  getFavorites() async {
    try {
      setState(States.loading);
      final idsRes = await _getAllFavorites.call();
      idsRes.fold(
        (failure) => _favorites.value = Left(failure),
        (ids) async {
          if (ids.isEmpty) {
            setState(States.empty);
            _favorites.value = const Right([]);
            return;
          }
          final req = MultipleRequest(ids: ids);
          final charactersRes = await _getMultipleCharacters.call(req);
          charactersRes.fold(
            (failure) => _favorites.value = Left(failure),
            (characters) {
              _favorites.value = Right(characters);
              setState(States.loaded);
            },
          );
        },
      );
    } catch (e) {
      setState(States.error);
    }
  }

  dispose() {
    _subscription.cancel();
    _favorites.dispose();
  }
}
