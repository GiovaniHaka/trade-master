import 'package:flutter/material.dart';
import 'package:ricky_and_morty/apps/characters/presentation/favorite_characters/components/favorite_characters_list.dart';
import 'package:ricky_and_morty/apps/characters/presentation/favorite_characters/favorite_characters_controller.dart';
import 'package:ricky_and_morty/common/constants/ui/custom_text_style.dart';
import 'package:ricky_and_morty/common/constants/ui/padding_constants.dart';
import 'package:rx_notifier/rx_notifier.dart';

class FavoriteCharactersScreen extends StatefulWidget {
  const FavoriteCharactersScreen({Key? key}) : super(key: key);

  @override
  State<FavoriteCharactersScreen> createState() =>
      _FavoriteCharactersScreenState();
}

class _FavoriteCharactersScreenState extends State<FavoriteCharactersScreen> {
  final _controller = FavoriteCharactersController();

  @override
  void initState() {
    super.initState();
    _controller.initializeFavoritesListen();
    _controller.getFavorites();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            const SliverAppBar(),
            SliverPadding(
              padding: const EdgeInsets.all(viewPadding),
              sliver: SliverToBoxAdapter(
                child: Text(
                  'Favoritos',
                  style: CustomTextStyle.headlineSmall(context),
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: viewPadding),
              sliver: RxBuilder(
                builder: (context) {
                  return FavoriteCharactersList(
                    state: _controller.state,
                    favorites: _controller.favorites,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
