import 'package:flutter/material.dart';

import 'package:ricky_and_morty/apps/characters/domain/models/character.dart';
import 'package:ricky_and_morty/apps/characters/presentation/character_details/components/character_details_card.dart';
import 'package:ricky_and_morty/apps/episodes/presentation/episode_details/episodes_list_card.dart';
import 'package:ricky_and_morty/apps/location/presentation/location_details/location_details_card.dart';
import 'package:ricky_and_morty/common/componets/images/custom_network_image.dart';
import 'package:ricky_and_morty/common/componets/separators/vertical_separator.dart';
import 'package:ricky_and_morty/common/constants/ui/custom_icon_data.dart';
import 'package:ricky_and_morty/common/constants/ui/padding_constants.dart';

class CharacterDetailsScreen extends StatelessWidget {
  final Character character;

  const CharacterDetailsScreen({
    Key? key,
    required this.character,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(viewPadding),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CustomNetworkImage(url: character.image),
              const VerticalSeparator.large(),
              CharacterDetailsCard(character: character),
              const VerticalSeparator.large(),
              LocationDetailsCard(
                title: 'Origem',
                icon: CustomIconData.origin,
                url: character.origin.url,
              ),
              const VerticalSeparator.large(),
              LocationDetailsCard(
                title: 'Localização',
                icon: CustomIconData.location,
                url: character.location.url,
              ),
              const VerticalSeparator.large(),
              EpisodesListCard(urls: character.episode),
            ],
          ),
        ),
      ),
    );
  }
}
