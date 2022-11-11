import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:ricky_and_morty/apps/favorites/data/repositories/favorite_repository.dart';
import 'package:ricky_and_morty/common/exceptions/failure.dart';

abstract class GetSingleFavorite {
  Future<Either<Failure, bool>> call(int id);
}

class GetSingleFavoriteImp implements GetSingleFavorite {
  late FavoriteRepository _repository;

  GetSingleFavoriteImp([FavoriteRepository? favoriteRepository]) {
    _repository = favoriteRepository ?? FavoriteRepositoryImp();
  }

  @override
  Future<Either<Failure, bool>> call(int id) async {
    try {
      return await _repository.getSingle(id);
    } catch (e) {
      log(e.toString());
      throw Exception(e);
    }
  }
}
