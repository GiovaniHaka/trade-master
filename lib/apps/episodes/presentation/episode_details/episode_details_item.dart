import 'package:flutter/material.dart';
import 'package:ricky_and_morty/common/componets/cards/info_card.dart';
import 'package:rx_notifier/rx_notifier.dart';

import 'package:ricky_and_morty/apps/episodes/domain/models/episode.dart';
import 'package:ricky_and_morty/apps/episodes/presentation/episode_details/episode_details_controller.dart';
import 'package:ricky_and_morty/common/componets/progress_indicators/custom_linear_progress.dart';
import 'package:ricky_and_morty/common/componets/separators/horizontal_separator.dart';
import 'package:ricky_and_morty/common/constants/ui/custom_colors.dart';
import 'package:ricky_and_morty/common/constants/ui/custom_text_style.dart';
import 'package:ricky_and_morty/common/constants/ui/radius_constants.dart';
import 'package:ricky_and_morty/common/states/states.dart';

class EpisodeDetailsItem extends StatefulWidget {
  final String url;

  const EpisodeDetailsItem({
    Key? key,
    required this.url,
  }) : super(key: key);

  @override
  State<EpisodeDetailsItem> createState() => _EpisodeDetailsItemState();
}

class _EpisodeDetailsItemState extends State<EpisodeDetailsItem> {
  final _controller = EpisodeDetailsController();

  @override
  void initState() {
    super.initState();
    _controller.getEpisode(widget.url);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: RxBuilder(
        builder: (_) {
          switch (_controller.state) {
            case States.error:
              return const Text('Algo deu errado');
            case States.loaded:
              return _controller.episode.fold(
                (failure) => InfoCard.failure(message: failure.message),
                (episode) {
                  return _EpisodeItemBody(
                    key: UniqueKey(),
                    episode: episode,
                  );
                },
              );
            default:
              return const Center(
                child: CustomLinearProgress(),
              );
          }
        },
      ),
    );
  }
}

class _EpisodeItemBody extends StatelessWidget {
  final Episode episode;

  const _EpisodeItemBody({
    Key? key,
    required this.episode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _EpisodeIdClip(id: episode.id),
        const HorizontalSeparator(),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                episode.name,
                style: CustomTextStyle.titleSmall(context),
                overflow: TextOverflow.ellipsis,
              ),
              Text(episode.airDate),
            ],
          ),
        ),
      ],
    );
  }
}

class _EpisodeIdClip extends StatelessWidget {
  final int id;

  const _EpisodeIdClip({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30,
      height: 30,
      decoration: const BoxDecoration(
        color: CustomColors.greyMedium,
        borderRadius: BorderRadius.all(
          Radius.circular(defaultRadius),
        ),
      ),
      child: Center(
        child: Text(
          '$id',
          style: CustomTextStyle.titleSmall(context).copyWith(
            color: CustomColors.greyDark,
          ),
        ),
      ),
    );
  }
}
