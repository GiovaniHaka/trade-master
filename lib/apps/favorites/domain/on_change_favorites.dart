import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:ricky_and_morty/apps/favorites/data/repositories/favorite_repository.dart';
import 'package:ricky_and_morty/common/exceptions/failure.dart';

abstract class OnChangeFavorites {
  Stream<Either<Failure, dynamic>> call();
}

class OnChangeFavoritesImp implements OnChangeFavorites {
  late FavoriteRepository _repository;

  OnChangeFavoritesImp([FavoriteRepository? favoriteRepository]) {
    _repository = favoriteRepository ?? FavoriteRepositoryImp();
  }

  @override
  Stream<Either<Failure, dynamic>> call() {
    try {
      return _repository.onChange();
    } catch (e) {
      log(e.toString());
      throw Exception(e);
    }
  }
}
