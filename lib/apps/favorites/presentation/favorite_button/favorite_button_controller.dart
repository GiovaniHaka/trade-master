import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:ricky_and_morty/apps/favorites/domain/add_favorite.dart';
import 'package:ricky_and_morty/apps/favorites/domain/get_single_favorite.dart';
import 'package:ricky_and_morty/apps/favorites/domain/remove_favorite.dart';
import 'package:ricky_and_morty/apps/favorites/domain/stream_favorite.dart';
import 'package:ricky_and_morty/common/controller/states_controller.dart';
import 'package:ricky_and_morty/common/exceptions/failure.dart';
import 'package:ricky_and_morty/common/states/states.dart';
import 'package:rx_notifier/rx_notifier.dart';

class FavoriteButtonController extends StatesController {
  late GetSingleFavorite _getSingleFavorite;
  late AddFavorite _addFavorite;
  late RemoveFavorite _removeFavorite;
  late StreamFavorite _streamFavorite;
  final int id;

  FavoriteButtonController(
    this.id, [
    GetSingleFavorite? getSingleFavorite,
    AddFavorite? addFavorite,
    RemoveFavorite? removeFavorite,
    StreamFavorite? streamFavorite,
  ]) {
    _getSingleFavorite = getSingleFavorite ?? GetSingleFavoriteImp();
    _addFavorite = addFavorite ?? AddFavoriteImp();
    _removeFavorite = removeFavorite ?? RemoveFavoriteImp();
    _streamFavorite = streamFavorite ?? StreamFavoriteImp();
  }

  late StreamSubscription<Either<Failure, bool>> _subscription;

  final _favorite = RxNotifier<Either<Failure, bool>>(const Right(false));
  Either<Failure, bool> get favorite => _favorite.value;

  Future<void> initialize() async {
    try {
      final singleFavorite = await _getSingleFavorite.call(id);
      singleFavorite.fold(
        (l) => _favorite.value = Left(l),
        (r) => _favorite.value = Right(r),
      );

      final stream = _streamFavorite.call(id);
      _subscription = stream.listen((event) {
        event.fold(
          (l) => _favorite.value = Left(l),
          (r) => _favorite.value = Right(r),
        );
        setState(States.loaded);
      });
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> onHandleAddFavorite() async {
    try {
      await _addFavorite.call(id);
    } catch (e) {
      setState(States.error);
    }
  }

  Future<void> onHandleRemoveFavorite() async {
    try {
      await _removeFavorite.call(id);
    } catch (e) {
      setState(States.error);
    }
  }

  dispose() {
    _subscription.cancel();
    _favorite.dispose();
  }
}
