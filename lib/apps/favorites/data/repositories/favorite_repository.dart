import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:ricky_and_morty/apps/favorites/data/sources/favorite_source.dart';
import 'package:ricky_and_morty/common/exceptions/failure.dart';

abstract class FavoriteRepository {
  Future<Either<Failure, List<int>>> getAll();
  Future<Either<Failure, void>> add(int key);
  Future<Either<Failure, bool>> getSingle(int key);
  Future<Either<Failure, void>> remove(int key);
  Stream<Either<Failure, bool>> stream(int key);
  Stream<Either<Failure, dynamic>> onChange();
}

class FavoriteRepositoryImp implements FavoriteRepository {
  late FavoriteSource _source;

  FavoriteRepositoryImp([FavoriteSource? source]) {
    _source = source ?? FavoriteSourceImp();
  }

  @override
  Future<Either<Failure, void>> add(int key) async {
    try {
      return await _source.add(key);
    } catch (e) {
      log(e.toString());
      throw Exception(e);
    }
  }

  @override
  Future<Either<Failure, List<int>>> getAll() async {
    try {
      final result = await _source.getAll();
      return result.fold(
        (failure) => Left(failure),
        (right) {
          final list = right.map((event) {
            final map = Map<int, dynamic>.from(event);
            return map.keys.first;
          }).toList();
          return Right(list);
        },
      );
    } catch (e) {
      log(e.toString());
      throw Exception(e);
    }
  }

  @override
  Future<Either<Failure, void>> remove(int key) async {
    try {
      return await _source.remove(key);
    } catch (e) {
      log(e.toString());
      throw Exception(e);
    }
  }

  @override
  Stream<Either<Failure, bool>> stream(int key) {
    try {
      final result = _source.stream(key);
      return result.map((event) {
        return event.fold(
          (failure) => Left(failure),
          (right) {
            final value = right == null ? false : true;
            return Right(value);
          },
        );
      });
    } catch (e) {
      log(e.toString());
      throw Exception(e);
    }
  }

  @override
  Future<Either<Failure, bool>> getSingle(int key) async {
    try {
      final result = await _source.getSingle(key);
      return result.fold(
        (failure) => Left(failure),
        (right) {
          final value = right == null ? false : true;
          return Right(value);
        },
      );
    } catch (e) {
      log(e.toString());
      throw Exception(e);
    }
  }

  @override
  Stream<Either<Failure, dynamic>> onChange() {
    try {
      final result = _source.onChange();
      return result.map((event) {
        return event.fold(
          (failure) => Left(failure),
          (right) {
            return Right(right);
          },
        );
      });
    } catch (e) {
      log(e.toString());
      throw Exception(e);
    }
  }
}
