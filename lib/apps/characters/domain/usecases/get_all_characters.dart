import 'package:dartz/dartz.dart';
import 'package:ricky_and_morty/apps/characters/data/repositories/characters_repository.dart';
import 'package:ricky_and_morty/apps/characters/domain/models/get_all_characters_response.dart';
import 'package:ricky_and_morty/apps/characters/domain/models/request/all_request.dart';
import 'package:ricky_and_morty/common/exceptions/failure.dart';

abstract class GetAllCharacters {
  Future<Either<Failure, GetAllCharactersResponse>> call(AllRequest request);
}

class GetAllCharactersImp implements GetAllCharacters {
  late CharactersRepository _repository;

  GetAllCharactersImp([CharactersRepository? repository]) {
    _repository = repository ?? CharactersRepositoryImp();
  }

  @override
  Future<Either<Failure, GetAllCharactersResponse>> call(
      AllRequest req) async {
    try {
      return await _repository.getAll(req);
    } catch (e) {
      throw Exception();
    }
  }
}
