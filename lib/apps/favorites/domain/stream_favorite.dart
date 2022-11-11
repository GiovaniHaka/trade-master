import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:ricky_and_morty/apps/favorites/data/repositories/favorite_repository.dart';
import 'package:ricky_and_morty/common/exceptions/failure.dart';

abstract class StreamFavorite {
  Stream<Either<Failure, bool>> call(int key);
}

class StreamFavoriteImp implements StreamFavorite {
  late FavoriteRepository _repository;

  StreamFavoriteImp([FavoriteRepository? favoriteRepository]) {
    _repository = favoriteRepository ?? FavoriteRepositoryImp();
  }

  @override
  Stream<Either<Failure, bool>> call(int key) {
    try {
      return _repository.stream(key);
    } catch (e) {
      log(e.toString());
      throw Exception(e);
    }
  }
}
