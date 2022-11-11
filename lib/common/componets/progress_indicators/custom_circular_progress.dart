import 'package:flutter/material.dart';
import 'package:ricky_and_morty/common/constants/ui/custom_colors.dart';

class CustomCircularProgress extends CircularProgressIndicator {
  const CustomCircularProgress({
    Key? key,
    Color? color,
  }) : super(
          key: key,
          strokeWidth: 2,
          color: color ?? CustomColors.pink,
        );
}
