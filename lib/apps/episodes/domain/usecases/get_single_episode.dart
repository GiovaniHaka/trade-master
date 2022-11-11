import 'package:dartz/dartz.dart';
import 'package:ricky_and_morty/apps/episodes/data/repositories/episode_repository.dart';
import 'package:ricky_and_morty/apps/episodes/domain/models/episode.dart';
import 'package:ricky_and_morty/common/exceptions/failure.dart';

abstract class GetSingleEpisode {
  Future<Either<Failure, Episode>> call(String url);
}

class GetSingleEpisodeImp implements GetSingleEpisode {
  late EpisodeRepository _repository;

  GetSingleEpisodeImp([EpisodeRepository? repository]) {
    _repository = repository ?? EpisodeRepositoryImp();
  }

  @override
  Future<Either<Failure, Episode>> call(String url) async {
    try {
      return await _repository.getSingle(url);
    } catch (e) {
      throw Exception(e);
    }
  }
}
