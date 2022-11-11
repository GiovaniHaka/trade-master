import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:ricky_and_morty/apps/characters/data/repositories/characters_repository.dart';
import 'package:ricky_and_morty/apps/characters/domain/models/character.dart';
import 'package:ricky_and_morty/apps/characters/domain/models/request/multiple_request.dart';
import 'package:ricky_and_morty/common/exceptions/failure.dart';

abstract class GetMultipleCharacters {
  Future<Either<Failure, List<Character>>> call(MultipleRequest req);
}

class GetMultipleCharactersImp implements GetMultipleCharacters {
  late CharactersRepository _repository;

  GetMultipleCharactersImp([CharactersRepository? repository]) {
    _repository = repository ?? CharactersRepositoryImp();
  }

  @override
  Future<Either<Failure, List<Character>>> call(MultipleRequest req) async {
    try {
      return await _repository.getMultiple(req);
    } catch (e) {
      log(e.toString());
      throw Exception();
    }
  }
}
