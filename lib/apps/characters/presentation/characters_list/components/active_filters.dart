import 'package:flutter/material.dart';

import 'package:ricky_and_morty/apps/characters/domain/models/character_filters.dart';
import 'package:ricky_and_morty/common/componets/clips/custom_icon_clip.dart';
import 'package:ricky_and_morty/common/constants/ui/custom_icon_data.dart';
import 'package:ricky_and_morty/common/constants/ui/separator_constants.dart';

class ActiveFilters extends StatelessWidget {
  final CharacterFilters filters;
  final Function() onTap;

  const ActiveFilters({
    Key? key,
    required this.filters,
    required this.onTap,
  }) : super(key: key);

  List<String> activeFiltersList(CharacterFilters filters) {
    List<String> activeFilters = [];
    final name = filters.name;
    final species = filters.species;

    if (name != null) {
      activeFilters.add(name);
    }

    if (species != null) {
      activeFilters.add(species);
    }

    return activeFilters;
  }

  @override
  Widget build(BuildContext context) {
    if (activeFiltersList(filters).isEmpty) {
      return const SizedBox();
    }

    return Row(
      children: [
        Expanded(
          child: Wrap(
            spacing: defaultSeparator,
            children: activeFiltersList(filters)
                .map(
                  (e) => CustomIconClip(
                    backgroundColor: Colors.transparent,
                    foregroundColor: Colors.black,
                    text: e,
                    icon: CustomIconData.filter,
                  ),
                )
                .toList(),
          ),
        ),
        IconButton(
          onPressed: onTap,
          icon: const Icon(CustomIconData.close),
        )
      ],
    );
  }
}
