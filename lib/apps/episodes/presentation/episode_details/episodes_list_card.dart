import 'package:flutter/material.dart';
import 'package:ricky_and_morty/apps/episodes/presentation/episode_details/episode_details_item.dart';
import 'package:ricky_and_morty/common/componets/cards/decorated_card.dart';
import 'package:ricky_and_morty/common/componets/cards/icon_card.dart';
import 'package:ricky_and_morty/common/componets/separators/horizontal_separator.dart';
import 'package:ricky_and_morty/common/componets/separators/vertical_separator.dart';
import 'package:ricky_and_morty/common/constants/ui/custom_colors.dart';
import 'package:ricky_and_morty/common/constants/ui/custom_icon_data.dart';
import 'package:ricky_and_morty/common/constants/ui/custom_text_style.dart';

class EpisodesListCard extends StatelessWidget {
  final List<String> urls;

  const EpisodesListCard({
    Key? key,
    required this.urls,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              const IconCard(
                icon: CustomIconData.episode,
                foregroundColor: CustomColors.pink,
                backgroundColor: CustomColors.pinkLight,
              ),
              const HorizontalSeparator(),
              Text(
                'Episódios',
                style: CustomTextStyle.titleMedium(context),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
          const VerticalSeparator.medium(),
          Builder(builder: (_) {
            if (urls.isEmpty) {
              return const Text(
                'Este personagem não participou de nenhum episódio',
              );
            }
            return ListView.separated(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (_, index) {
                final url = urls[index];

                return EpisodeDetailsItem(
                  key: UniqueKey(),
                  url: url,
                );
              },
              separatorBuilder: (_, index) {
                return const Divider();
              },
              itemCount: urls.length,
            );
          })
        ],
      ),
    );
  }
}
