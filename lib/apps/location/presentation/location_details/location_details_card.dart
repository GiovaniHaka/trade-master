import 'package:flutter/material.dart';
import 'package:ricky_and_morty/common/componets/cards/info_card.dart';
import 'package:rx_notifier/rx_notifier.dart';

import 'package:ricky_and_morty/apps/location/domain/models/location.dart';
import 'package:ricky_and_morty/apps/location/presentation/location_details/locations_details_controller.dart';
import 'package:ricky_and_morty/common/componets/cards/decorated_card.dart';
import 'package:ricky_and_morty/common/componets/cards/icon_card.dart';
import 'package:ricky_and_morty/common/componets/progress_indicators/custom_linear_progress.dart';
import 'package:ricky_and_morty/common/componets/separators/horizontal_separator.dart';
import 'package:ricky_and_morty/common/componets/separators/vertical_separator.dart';
import 'package:ricky_and_morty/common/constants/ui/custom_colors.dart';
import 'package:ricky_and_morty/common/constants/ui/custom_text_style.dart';
import 'package:ricky_and_morty/common/states/states.dart';

class LocationDetailsCard extends StatefulWidget {
  final IconData icon;
  final String title;
  final String url;

  const LocationDetailsCard({
    Key? key,
    required this.icon,
    required this.title,
    required this.url,
  }) : super(key: key);

  @override
  State<LocationDetailsCard> createState() => _LocationDetailsCardState();
}

class _LocationDetailsCardState extends State<LocationDetailsCard> {
  final _controller = LocationDetailsController();

  @override
  void initState() {
    super.initState();
    _controller.getLocation(widget.url);
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              IconCard(
                icon: widget.icon,
                foregroundColor: CustomColors.pink,
                backgroundColor: CustomColors.pinkLight,
              ),
              const HorizontalSeparator(),
              Text(
                widget.title,
                style: CustomTextStyle.titleMedium(context),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
          const VerticalSeparator.medium(),
          RxBuilder(builder: (_) {
            switch (_controller.state) {
              case States.error:
                return const Text('Erro');
              case States.loaded:
                return _controller.location.fold(
                  (failure) => InfoCard.failure(message: failure.message),
                  (location) => _LocationDetailsBody(location: location),
                );
              default:
                return const CustomLinearProgress();
            }
          })
        ],
      ),
    );
  }
}

class _LocationDetailsBody extends StatelessWidget {
  final Location location;

  const _LocationDetailsBody({
    Key? key,
    required this.location,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _LocationItem(
          title: 'Nome',
          value: location.name,
        ),
        const Divider(),
        _LocationItem(
          title: 'Tipo',
          value: location.type,
        ),
        const Divider(),
        _LocationItem(
          title: 'Dimensão',
          value: location.dimension,
        ),
      ],
    );
  }
}

class _LocationItem extends StatelessWidget {
  final String title;
  final String value;

  const _LocationItem({
    Key? key,
    required this.title,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: CustomTextStyle.labelMedium(context),
        ),
        Text(
          value,
          style: CustomTextStyle.titleSmall(context),
        ),
      ],
    );
  }
}
