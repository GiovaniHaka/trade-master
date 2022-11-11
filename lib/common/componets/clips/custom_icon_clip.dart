import 'package:flutter/material.dart';
import 'package:ricky_and_morty/common/componets/separators/horizontal_separator.dart';
import 'package:ricky_and_morty/common/constants/ui/custom_text_style.dart';

class CustomIconClip extends StatelessWidget {
  final Color backgroundColor;
  final Color foregroundColor;
  final String text;
  final IconData icon;

  const CustomIconClip({
    Key? key,
    required this.backgroundColor,
    required this.foregroundColor,
    required this.text,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(100),
        border: Border.all(
          color: foregroundColor,
          width: 2,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: foregroundColor,
            size: 18,
          ),
          const HorizontalSeparator.small(),
          Text(
            text,
            style: CustomTextStyle.labelMedium(context).copyWith(
              color: foregroundColor,
            ),
          ),
        ],
      ),
    );
  }
}
