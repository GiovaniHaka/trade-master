import 'package:dartz/dartz.dart';
import 'package:ricky_and_morty/apps/episodes/domain/models/episode.dart';
import 'package:ricky_and_morty/apps/episodes/domain/usecases/get_single_episode.dart';
import 'package:ricky_and_morty/common/controller/states_controller.dart';
import 'package:ricky_and_morty/common/exceptions/failure.dart';
import 'package:ricky_and_morty/common/states/states.dart';
import 'package:rx_notifier/rx_notifier.dart';

class EpisodeDetailsController extends StatesController {
  late GetSingleEpisode _getSingleEpisode;

  EpisodeDetailsController([GetSingleEpisode? getSingleEpisode]) {
    _getSingleEpisode = getSingleEpisode ?? GetSingleEpisodeImp();
  }

  final _episode = RxNotifier<Either<Failure, Episode>>(Left(Failure('')));
  Either<Failure, Episode> get episode => _episode.value;

  getEpisode(String url) async {
    try {
      setState(States.loading);
      final result = await _getSingleEpisode.call(url);

      result.fold(
        (failure) => _episode.value = Left(failure),
        (episode) => _episode.value = Right(episode),
      );
      setState(States.loaded);
    } catch (e) {
      setState(States.error);
    }
  }
}
