import 'package:dartz/dartz.dart';
import 'package:ricky_and_morty/apps/episodes/data/sources/source_repository.dart';
import 'package:ricky_and_morty/apps/episodes/domain/models/episode.dart';
import 'package:ricky_and_morty/common/exceptions/failure.dart';

abstract class EpisodeRepository {
  Future<Either<Failure, Episode>> getSingle(String url);
}

class EpisodeRepositoryImp implements EpisodeRepository {
  late EpisodeSource _source;

  EpisodeRepositoryImp([EpisodeSource? source]) {
    _source = source ?? EpisodeSourceImp();
  }

  @override
  Future<Either<Failure, Episode>> getSingle(String url) async {
    try {
      final result = await _source.getSingle(url);

      return result.fold(
        (failure) => Left(failure),
        (data) {
          final episode = Episode.fromMap(data);
          return Right(episode);
        },
      );
    } catch (e) {
      throw Exception(e);
    }
  }
}
