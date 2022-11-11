import 'package:dartz/dartz.dart';
import 'package:ricky_and_morty/apps/location/domain/models/location.dart';
import 'package:ricky_and_morty/apps/location/domain/usecases/get_single_location.dart';
import 'package:ricky_and_morty/common/controller/states_controller.dart';
import 'package:ricky_and_morty/common/exceptions/failure.dart';
import 'package:ricky_and_morty/common/states/states.dart';
import 'package:rx_notifier/rx_notifier.dart';

class LocationDetailsController extends StatesController {
  late GetSingleLocation _getSingleLocation;

  LocationDetailsController([GetSingleLocation? getSingleLocation]) {
    _getSingleLocation = getSingleLocation ?? GetSingleLocationImp();
  }

  final _location = RxNotifier<Either<Failure, Location>>(Left(Failure('')));
  Either<Failure, Location> get location => _location.value;

  getLocation(String url) async {
    try {
      setState(States.loading);
      final result = await _getSingleLocation.call(url);

      result.fold(
        (failure) => _location.value = Left(failure),
        (location) {
          _location.value = Right(location);
        },
      );

      setState(States.loaded);
    } catch (e) {
      setState(States.error);
    }
  }
}
