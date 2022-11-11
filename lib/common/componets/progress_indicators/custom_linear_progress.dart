import 'package:flutter/material.dart';
import 'package:ricky_and_morty/common/constants/ui/custom_colors.dart';

class CustomLinearProgress extends LinearProgressIndicator {
  const CustomLinearProgress({
    Key? key,
    Color? color,
  }) : super(
          key: key,
          minHeight: 2,
          color: color ?? CustomColors.pink,
        );
}
