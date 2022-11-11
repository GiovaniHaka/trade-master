import 'package:flutter/material.dart';
import 'package:ricky_and_morty/common/constants/ui/separator_constants.dart';

class VerticalSeparator extends StatelessWidget {
  final double height;

  const VerticalSeparator({
    Key? key,
    this.height = defaultSeparator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: height);
  }

  const VerticalSeparator.large({
    Key? key,
    this.height = largeSeparator,
  }) : super(key: key);
  
  const VerticalSeparator.medium({
    Key? key,
    this.height = mediumSeparator,
  }) : super(key: key);
  
  const VerticalSeparator.small({
    Key? key,
    this.height = smallSeparator,
  }) : super(key: key);
}
