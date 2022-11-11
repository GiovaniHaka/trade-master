import 'package:flutter/material.dart';
import 'package:ricky_and_morty/common/componets/progress_indicators/custom_linear_progress.dart';
import 'package:ricky_and_morty/common/states/states.dart';

class AppBarLoading extends PreferredSize {
  const AppBarLoading({
    Key? key,
    required States state,
  }) : super(
          key: key,
          child: state == States.loading
              ? const CustomLinearProgress()
              : const SizedBox(),
          preferredSize: const Size.fromHeight(10),
        );
}
