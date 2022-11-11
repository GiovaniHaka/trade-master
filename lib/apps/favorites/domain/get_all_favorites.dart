import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:ricky_and_morty/apps/favorites/data/repositories/favorite_repository.dart';
import 'package:ricky_and_morty/common/exceptions/failure.dart';

abstract class GetAllFavorites {
  Future<Either<Failure, List<int>>> call();
}

class GetAllFavoritesImp implements GetAllFavorites {
  late FavoriteRepository _repository;

  GetAllFavoritesImp([FavoriteRepository? favoriteRepository]){
    _repository = favoriteRepository ?? FavoriteRepositoryImp();
  }

  @override
  Future<Either<Failure, List<int>>> call() async {
    try {
      return await _repository.getAll();
    } catch (e) {
      log(e.toString());
      throw Exception(e);
    }
  }
}
