import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:ricky_and_morty/apps/characters/domain/models/request/all_request.dart';
import 'package:ricky_and_morty/apps/characters/domain/models/request/multiple_request.dart';
import 'package:ricky_and_morty/common/constants/endpoints/ricky_morty_endpoints.dart';
import 'package:ricky_and_morty/common/exceptions/failure.dart';
import 'package:ricky_and_morty/services/http_client/domain/models/custom_request.dart';
import 'package:ricky_and_morty/services/http_client/domain/models/custom_response.dart';
import 'package:ricky_and_morty/services/http_client/domain/usecases/http_client.dart';

abstract class CharactersSource {
  Future<Either<Failure, Map<String, dynamic>>> getAll(AllRequest req);

  Future<Either<Failure, List<dynamic>>> getMultiple(MultipleRequest req);
}

class CharactersSourceImp implements CharactersSource {
  late HttpClient _httpClient;

  CharactersSourceImp([HttpClient? httpClient]) {
    _httpClient = httpClient ?? HttpClietImp();
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> getAll(AllRequest req) async {
    try {
      String path = RickMortyApi.characters;
      Map<String, dynamic>? query;

      final url = req.url;
      final filters = req.filters;

      if (filters != null) {
        query = filters.toMap();
      }

      if (url != null) {
        path = url;
        query = null;
      }

      final request = CustomRequest(path, queryParameters: query);

      final response = await _httpClient.get(request);
      final status = response.status;
      final data = response.data;

      switch (status) {
        case ResponseStatus.success:
          return Right(data!);
        case ResponseStatus.badRequest:
          return Left(Failure(
            'Não conseguimos encontrar os personagens solicitados',
          ));
        case ResponseStatus.unknown:
          return Left(Failure(
            'Não conseguimos encontrar os personagens',
          ));
        case ResponseStatus.error:
          return Left(Failure(
            'Erro ao encontrar personagens',
          ));
        default:
          throw Exception();
      }
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<Either<Failure, List<dynamic>>> getMultiple(
      MultipleRequest req) async {
    try {
      String path = RickMortyApi.characters;
      final ids = req.ids;

      if (ids != null) {
        String idsStr = ids.join(',');
        path = '${RickMortyApi.characters}/$idsStr';
      }

      final request = CustomRequest(path);

      final response = await _httpClient.get(request);
      final status = response.status;
      final data = response.data;

      switch (status) {
        case ResponseStatus.success:
          if (data! is List) {
            return Right(data!);
          }
          return Right([data!]);
        case ResponseStatus.unknown:
          return Left(Failure('Não conseguimos encontrar os personagens'));
        case ResponseStatus.error:
          return Left(Failure('Erro ao encontrar os personagens'));
        default:
          throw UnimplementedError();
      }
    } catch (e) {
      log(e.toString());
      throw Exception();
    }
  }
}
