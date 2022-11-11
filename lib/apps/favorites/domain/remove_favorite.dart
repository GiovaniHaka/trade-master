import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:ricky_and_morty/apps/favorites/data/repositories/favorite_repository.dart';
import 'package:ricky_and_morty/common/exceptions/failure.dart';

abstract class RemoveFavorite {
  Future<Either<Failure, void>> call(int key);
}

class RemoveFavoriteImp implements RemoveFavorite {
  late FavoriteRepository _repository;

  RemoveFavoriteImp([FavoriteRepository? favoriteRepository]) {
    _repository = favoriteRepository ?? FavoriteRepositoryImp();
  }

  @override
  Future<Either<Failure, void>> call(int key) async {
    try {
      return await _repository.remove(key);
    } catch (e) {
      log(e.toString());
      throw Exception(e);
    }
  }
}
