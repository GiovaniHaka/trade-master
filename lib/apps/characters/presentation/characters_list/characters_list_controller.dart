import 'package:dartz/dartz.dart';
import 'package:ricky_and_morty/apps/characters/domain/models/character.dart';
import 'package:ricky_and_morty/apps/characters/domain/models/character_filters.dart';
import 'package:ricky_and_morty/apps/characters/domain/models/request/all_request.dart';
import 'package:ricky_and_morty/apps/characters/domain/usecases/get_all_characters.dart';
import 'package:ricky_and_morty/common/controller/states_controller.dart';
import 'package:ricky_and_morty/common/exceptions/failure.dart';
import 'package:ricky_and_morty/common/models/rick_and_morty_api/info.dart';
import 'package:ricky_and_morty/common/states/states.dart';
import 'package:rx_notifier/rx_notifier.dart';

class CharactersListController extends StatesController {
  late GetAllCharacters _getAllCharacters;

  CharactersListController([GetAllCharacters? getAllCharacters]) {
    _getAllCharacters = getAllCharacters ?? GetAllCharactersImp();
  }

  final _lastInfo = RxNotifier<Info?>(null);
  Info? get lastInfo => _lastInfo.value;

  final _characters =
      RxNotifier<Either<Failure, List<Character>>>(const Right([]));
  Either<Failure, List<Character>> get characters => _characters.value;

  final _filters = RxNotifier<CharacterFilters>(CharacterFilters());
  CharacterFilters get filters => _filters.value;

  final _moreState = RxNotifier<States>(States.initial);
  States get seeMoreState => _moreState.value;

  _getCharacters(AllRequest request) async {
    try {
      final result = await _getAllCharacters.call(request);

      List<Character> oldCharacters =
          characters.foldRight([], (r, previous) => r);

      result.fold(
        (failure) => _characters.value = Left(failure),
        (response) {
          _lastInfo.value = response.info;
          final newCharacters = response.characters;
          _characters.value = Right(oldCharacters + newCharacters);
        },
      );
    } catch (e) {
      throw Exception();
    }
  }

  searchWithoutFilters() async {
    try {
      setState(States.loading);
      _characters.value = const Right([]);
      _filters.value = CharacterFilters();
      await _getCharacters(AllRequest());
      setState(States.loaded);
    } catch (e) {
      setState(States.error);
    }
  }

  searchWithFilters(CharacterFilters filters) async {
    try {
      setState(States.loading);
      _characters.value = const Right([]);
      _filters.value = filters;
      final request = AllRequest(filters: filters);
      await _getCharacters(request);
      setState(States.loaded);
    } catch (e) {
      setState(States.error);
    }
  }

  seeMore() async {
    try {
      _moreState.value = States.loading;
      final nextPageUrl = lastInfo?.next;
      final request = AllRequest(url: nextPageUrl);
      await _getCharacters(request);
      _moreState.value = States.loaded;
    } catch (e) {
      _moreState.value = States.error;
    }
  }
}
