import 'package:dartz/dartz.dart';
import 'package:ricky_and_morty/apps/location/data/repositories/location_repository.dart';
import 'package:ricky_and_morty/apps/location/domain/models/location.dart';
import 'package:ricky_and_morty/common/exceptions/failure.dart';

abstract class GetSingleLocation {
  Future<Either<Failure, Location>> call(String url);
}

class GetSingleLocationImp implements GetSingleLocation {
  late LocationRepository _repository;

  GetSingleLocationImp([LocationRepository? repository]) {
    _repository = repository ?? LocationRepositoryImp();
  }

  @override
  Future<Either<Failure, Location>> call(String url) async {
    try {
      return await _repository.getSingle(url);
    } catch (e) {
      throw Exception(e);
    }
  }
}
