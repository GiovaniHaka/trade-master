import 'package:flutter/material.dart';

import 'package:ricky_and_morty/apps/characters/domain/models/character.dart';
import 'package:ricky_and_morty/apps/favorites/presentation/favorite_button/favorite_button.dart';
import 'package:ricky_and_morty/common/componets/cards/decorated_card.dart';
import 'package:ricky_and_morty/common/componets/cards/icon_card.dart';
import 'package:ricky_and_morty/common/componets/images/custom_network_image.dart';
import 'package:ricky_and_morty/common/componets/separators/horizontal_separator.dart';
import 'package:ricky_and_morty/common/componets/separators/vertical_separator.dart';
import 'package:ricky_and_morty/common/constants/ui/custom_colors.dart';
import 'package:ricky_and_morty/common/constants/ui/custom_icon_data.dart';
import 'package:ricky_and_morty/common/constants/ui/custom_text_style.dart';

class CharacterCard extends StatelessWidget {
  final Character character;
  final Function() onTap;

  const CharacterCard({
    Key? key,
    required this.character,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedCard(
      onTap: onTap,
      color: CustomColors.greyLight,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            flex: 2,
            child: CustomNetworkImage(url: character.image),
          ),
          const HorizontalSeparator(),
          Flexible(
            flex: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  character.species,
                  style: CustomTextStyle.labelMedium(context),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  character.name,
                  style: CustomTextStyle.titleMedium(context),
                  overflow: TextOverflow.ellipsis,
                ),
                const VerticalSeparator(),
                IconSpecs(
                  icon: CustomIconData.episode,
                  text: '${character.episode.length}',
                )
              ],
            ),
          ),
          FavoriteButton(id: character.id),
        ],
      ),
    );
  }
}

class IconSpecs extends StatelessWidget {
  final IconData icon;
  final String text;

  const IconSpecs({
    Key? key,
    required this.icon,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconCard(
          icon: icon,
          backgroundColor: CustomColors.greenLight,
          foregroundColor: CustomColors.greenStrong,
        ),
        const HorizontalSeparator.small(),
        Text(
          text,
          style: CustomTextStyle.bodyMedium(context),
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
