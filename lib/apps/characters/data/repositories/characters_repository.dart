import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:ricky_and_morty/apps/characters/data/sources/characters_source.dart';
import 'package:ricky_and_morty/apps/characters/domain/models/character.dart';
import 'package:ricky_and_morty/apps/characters/domain/models/get_all_characters_response.dart';
import 'package:ricky_and_morty/apps/characters/domain/models/request/all_request.dart';
import 'package:ricky_and_morty/apps/characters/domain/models/request/multiple_request.dart';
import 'package:ricky_and_morty/common/exceptions/failure.dart';
import 'package:ricky_and_morty/common/models/rick_and_morty_api/info.dart';

abstract class CharactersRepository {
  Future<Either<Failure, GetAllCharactersResponse>> getAll(AllRequest req);

  Future<Either<Failure, List<Character>>> getMultiple(MultipleRequest req);
}

class CharactersRepositoryImp implements CharactersRepository {
  late CharactersSource _source;

  CharactersRepositoryImp([CharactersSource? source]) {
    _source = source ?? CharactersSourceImp();
  }

  @override
  Future<Either<Failure, GetAllCharactersResponse>> getAll(
      AllRequest req) async {
    try {
      final result = await _source.getAll(req);

      return result.fold(
        (failure) => Left(failure),
        (data) {
          final info = Info.fromMap(data['info']);
          final results = data['results'] as List;
          final characters = results.map((e) => Character.fromMap(e)).toList();

          return Right(GetAllCharactersResponse(
            info: info,
            characters: characters,
          ));
        },
      );
    } catch (e) {
      log(e.toString());
      throw Exception();
    }
  }

  @override
  Future<Either<Failure, List<Character>>> getMultiple(
      MultipleRequest req) async {
    try {
      final result = await _source.getMultiple(req);

      return result.fold(
        (failure) => Left(failure),
        (data) {
          final results = data;
          final characters = results.map((e) => Character.fromMap(e)).toList();
          return Right(characters);
        },
      );
    } catch (e) {
      log(e.toString());
      throw Exception();
    }
  }
}
