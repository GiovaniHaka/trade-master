import 'package:flutter/material.dart';
import 'package:ricky_and_morty/common/componets/buttons/button_detector.dart';

class IconCard extends StatelessWidget {
  final IconData icon;
  final Color backgroundColor;
  final Color foregroundColor;
  final Function()? onTap;

  const IconCard({
    Key? key,
    required this.icon,
    required this.foregroundColor,
    required this.backgroundColor,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double dimensions = 30;

    return ButtonDetector(
      color: backgroundColor,
      onTap: onTap,
      child: SizedBox(
        height: dimensions,
        width: dimensions,
        child: Center(
          child: Icon(
            icon,
            color: foregroundColor,
            size: 15,
          ),
        ),
      ),
    );
  }
}
