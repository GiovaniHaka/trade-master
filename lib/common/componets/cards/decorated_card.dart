import 'package:flutter/material.dart';
import 'package:ricky_and_morty/common/componets/buttons/button_detector.dart';
import 'package:ricky_and_morty/common/constants/ui/custom_colors.dart';
import 'package:ricky_and_morty/common/constants/ui/padding_constants.dart';

class DecoratedCard extends StatelessWidget {
  final Widget child;
  final double padding;
  final Color color;
  final Function()? onTap;

  const DecoratedCard(
      {Key? key,
      required this.child,
      this.padding = defaultPadding,
      this.color = CustomColors.greyLight,
      this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ButtonDetector(
      color: color,
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(padding),
        child: child,
      ),
    );
  }
}
