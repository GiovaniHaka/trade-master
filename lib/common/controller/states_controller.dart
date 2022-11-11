import 'package:ricky_and_morty/common/states/states.dart';
import 'package:rx_notifier/rx_notifier.dart';

class StatesController {
  final _state = RxNotifier<States>(States.initial);
  States get state => _state.value;

  setState(States state) {
    _state.value = state;
  }
}
