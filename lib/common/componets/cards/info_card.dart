import 'package:flutter/material.dart';
import 'package:ricky_and_morty/common/componets/cards/decorated_card.dart';
import 'package:ricky_and_morty/common/componets/separators/horizontal_separator.dart';
import 'package:ricky_and_morty/common/constants/ui/custom_colors.dart';
import 'package:ricky_and_morty/common/constants/ui/custom_icon_data.dart';
import 'package:ricky_and_morty/common/constants/ui/custom_text_style.dart';

class InfoCard extends StatelessWidget {
  final Color strongColor;
  final Color lightColor;
  final String message;

  const InfoCard({
    Key? key,
    this.strongColor = CustomColors.greyDark,
    this.lightColor = CustomColors.greyMedium,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedCard(
      color: lightColor,
      child: Row(
        children: [
          Icon(
            CustomIconData.error,
            color: strongColor,
          ),
          const HorizontalSeparator(),
          Expanded(
            child: Text(
              message,
              style: CustomTextStyle.bodySmall(context).copyWith(
                color: strongColor,
              ),
            ),
          )
        ],
      ),
    );
  }

  const InfoCard.failure({
    Key? key,
    this.strongColor = CustomColors.redStrong,
    this.lightColor = CustomColors.redLight,
    required this.message,
  }) : super(key: key);
}
