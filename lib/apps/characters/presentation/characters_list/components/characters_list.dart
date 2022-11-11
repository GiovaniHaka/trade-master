import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import 'package:ricky_and_morty/apps/characters/domain/models/character.dart';
import 'package:ricky_and_morty/apps/characters/presentation/characters_list/components/character_card.dart';
import 'package:ricky_and_morty/common/componets/cards/info_card.dart';
import 'package:ricky_and_morty/common/componets/progress_indicators/custom_circular_progress.dart';
import 'package:ricky_and_morty/common/componets/separators/vertical_separator.dart';
import 'package:ricky_and_morty/common/componets/slivers/sliver_list_separated.dart';
import 'package:ricky_and_morty/common/exceptions/failure.dart';
import 'package:ricky_and_morty/common/states/states.dart';
import 'package:ricky_and_morty/navigator/routes.dart';

class CharactersList extends StatelessWidget {
  final States state;
  final Either<Failure, List<Character>> characters;

  const CharactersList({
    Key? key,
    required this.state,
    required this.characters,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late Widget widget;
    switch (state) {
      case States.loaded:
        return characters.fold(
          (failure) {
            return SliverToBoxAdapter(
              child: InfoCard.failure(message: failure.message),
            );
          },
          (favorites) {
            return SliverListSeparated(
              itemBuilder: (_, index) {
                final char = favorites[index];
                return CharacterCard(
                  key: UniqueKey(),
                  character: char,
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      Routes.characterDetails,
                      arguments: char,
                    );
                  },
                );
              },
              separator: const VerticalSeparator(),
              itemCount: favorites.length,
            );
          },
        );
      case States.empty:
        widget = const Text(
          'Não encontramos os personagens',
        );
        break;
      case States.error:
        widget = const Text('Erro');
        break;
      default:
        widget = const Center(
          child: CustomCircularProgress(),
        );
    }
    return SliverToBoxAdapter(
      child: widget,
    );
  }
}
