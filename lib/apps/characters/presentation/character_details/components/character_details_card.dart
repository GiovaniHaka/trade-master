import 'package:flutter/material.dart';

import 'package:ricky_and_morty/apps/characters/domain/models/character.dart';
import 'package:ricky_and_morty/apps/favorites/presentation/favorite_button/favorite_button.dart';
import 'package:ricky_and_morty/common/componets/clips/custom_icon_clip.dart';
import 'package:ricky_and_morty/common/componets/separators/vertical_separator.dart';
import 'package:ricky_and_morty/common/constants/ui/custom_colors.dart';
import 'package:ricky_and_morty/common/constants/ui/custom_icon_data.dart';
import 'package:ricky_and_morty/common/constants/ui/custom_text_style.dart';
import 'package:ricky_and_morty/common/constants/ui/separator_constants.dart';
import 'package:ricky_and_morty/utils/datetime/datetime_format.dart';

class CharacterDetailsCard extends StatelessWidget {
  final Character character;

  const CharacterDetailsCard({
    Key? key,
    required this.character,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                character.name,
                style: CustomTextStyle.titleLarge(context),
              ),
            ),
            FavoriteButton(id: character.id),
          ],
        ),
        const VerticalSeparator(),
        Wrap(
          runSpacing: defaultSeparator,
          spacing: defaultSeparator,
          children: [
            CustomIconClip(
              icon: CustomIconData.specie,
              backgroundColor: CustomColors.greenLight,
              foregroundColor: CustomColors.greenStrong,
              text: character.species,
            ),
            CustomIconClip(
              icon: CustomIconData.aliveStatus,
              backgroundColor: CustomColors.purpleLight,
              foregroundColor: CustomColors.purpleStrong,
              text: character.status.translation,
            ),
            CustomIconClip(
              icon: CustomIconData.created,
              backgroundColor: CustomColors.amberLight,
              foregroundColor: CustomColors.amberStrong,
              text: DateTimeFormat(character.created).toYMD(),
            ),
          ],
        ),
      ],
    );
  }
}
