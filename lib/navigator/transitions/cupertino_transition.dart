import 'package:flutter/cupertino.dart';

class CupertinoTransition extends CupertinoPageRoute {
  final Widget widget;

  CupertinoTransition(
    this.widget,
  ) : super(
          builder: (_) {
            return widget;
          },
        );
}
