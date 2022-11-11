import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:ricky_and_morty/common/exceptions/failure.dart';
import 'package:ricky_and_morty/services/local_database/domain/usecases/delete_local_data.dart';
import 'package:ricky_and_morty/services/local_database/domain/usecases/get_all_local_data.dart';
import 'package:ricky_and_morty/services/local_database/domain/usecases/get_single_local_data.dart';
import 'package:ricky_and_morty/services/local_database/domain/usecases/put_local_data.dart';
import 'package:ricky_and_morty/services/local_database/domain/usecases/on_change_local_data.dart';
import 'package:ricky_and_morty/services/local_database/domain/usecases/stream_local_data.dart';

abstract class FavoriteSource {
  Future<Either<Failure, List<dynamic>>> getAll();
  Future<Either<Failure, void>> add(int key);
  Future<Either<Failure, void>> remove(int key);
  Future<Either<Failure, dynamic>> getSingle(int key);
  Stream<Either<Failure, dynamic>> stream(int key);
  Stream<Either<Failure, dynamic>> onChange();
}

class FavoriteSourceImp implements FavoriteSource {
  late GetSingleLocalData _getSingleLocalData;
  late GetAllLocalData _getAllLocalData;
  late DeleteLocalData _deleteLocalData;
  late PutLocalData _putLocalData;
  late StreamLocalData _streamLocalData;
  late OnChangeLocalData _onChangeLocalData;

  FavoriteSourceImp([
    GetSingleLocalData? getSingleLocalData,
    GetAllLocalData? getAllLocalData,
    DeleteLocalData? deleteLocalData,
    PutLocalData? putLocalData,
    StreamLocalData? streamLocalData,
    OnChangeLocalData? onChangeLocalData,
  ]) {
    _getSingleLocalData = getSingleLocalData ?? GetSingleLocalDataImp();
    _getAllLocalData = getAllLocalData ?? GetAllLocalDataImp();
    _deleteLocalData = deleteLocalData ?? DeleteLocalDataImp();
    _putLocalData = putLocalData ?? PutLocalDataImp();
    _streamLocalData = streamLocalData ?? StreamLocalDataImp();
    _onChangeLocalData = onChangeLocalData ?? OnChangeLocalDataImp();
  }

  static const favoritesSchema = 'favorites';

  @override
  Future<Either<Failure, void>> add(int key) async {
    try {
      await _putLocalData.call(favoritesSchema, key: key, value: true);
      return const Right(null);
    } catch (e) {
      log(e.toString());
      return Left(Failure('Não foi possível adicionar aos favoritos'));
    }
  }

  @override
  Future<Either<Failure, List>> getAll() async {
    try {
      final list = await _getAllLocalData.call(favoritesSchema);
      return Right(list);
    } catch (e) {
      log(e.toString());
      return Left(Failure('Não foi possível encontrar os favoritos'));
    }
  }

  @override
  Future<Either<Failure, void>> remove(int key) async {
    try {
      await _deleteLocalData.call(favoritesSchema, key: key);
      return const Right(null);
    } catch (e) {
      log(e.toString());
      return Left(Failure('Não foi possível remover dos favoritos'));
    }
  }

  @override
  Stream<Either<Failure, dynamic>> stream(int key) async* {
    try {
      final stream = _streamLocalData.call(favoritesSchema, key: key);
      yield* stream.map(
        (event) {
          return Right(event);
        },
      );
    } catch (e) {
      log(e.toString());
      yield Left(Failure('Não foi possível buscar o favorito'));
    }
  }

  @override
  Future<Either<Failure, dynamic>> getSingle(int key) async {
    try {
      final result = await _getSingleLocalData.call(
        favoritesSchema,
        key: key,
      );

      return Right(result);
    } catch (e) {
      log(e.toString());
      return Left(Failure('Não foi possível encontrar favorito'));
    }
  }

  @override
  Stream<Either<Failure, dynamic>> onChange() async* {
    try {
      final stream = _onChangeLocalData.call(favoritesSchema);
      yield* stream.map(
        (event) {
          return Right(event);
        },
      );
    } catch (e) {
      log(e.toString());
      yield Left(Failure('Não foi possível buscar o favorito'));
    }
  }
}
