import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:ricky_and_morty/apps/favorites/data/repositories/favorite_repository.dart';
import 'package:ricky_and_morty/common/exceptions/failure.dart';

abstract class AddFavorite {
  Future<Either<Failure, void>> call(int key);
}

class AddFavoriteImp implements AddFavorite {
  late FavoriteRepository _repository;

  AddFavoriteImp([FavoriteRepository? favoriteRepository]) {
    _repository = favoriteRepository ?? FavoriteRepositoryImp();
  }

  @override
  Future<Either<Failure, void>> call(int key) async {
    try {
      return await _repository.add(key);
    } catch (e) {
      log(e.toString());
      throw Exception(e);
    }
  }
}
