import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ricky_and_morty/common/componets/progress_indicators/custom_circular_progress.dart';
import 'package:ricky_and_morty/common/constants/ui/custom_colors.dart';
import 'package:ricky_and_morty/common/constants/ui/custom_icon_data.dart';
import 'package:ricky_and_morty/common/constants/ui/radius_constants.dart';

class CustomNetworkImage extends StatelessWidget {
  final String url;

  const CustomNetworkImage({
    Key? key,
    required this.url,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(defaultRadius),
      child: AspectRatio(
        aspectRatio: 1,
        child: CachedNetworkImage(
          imageUrl: url,
          fit: BoxFit.cover,
          placeholder: (context, url) =>
              const Center(child: CustomCircularProgress()),
          errorWidget: (context, url, error) => const Icon(
            CustomIconData.error,
            color: CustomColors.greyMedium,
          ),
        ),
      ),
    );
  }
}
