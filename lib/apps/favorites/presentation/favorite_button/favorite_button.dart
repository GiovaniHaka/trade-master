import 'package:flutter/material.dart';
import 'package:ricky_and_morty/apps/favorites/presentation/favorite_button/favorite_button_controller.dart';
import 'package:ricky_and_morty/common/constants/ui/custom_icon_data.dart';
import 'package:ricky_and_morty/common/states/states.dart';
import 'package:rx_notifier/rx_notifier.dart';

class FavoriteButton extends StatefulWidget {
  final int id;
  const FavoriteButton({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  late FavoriteButtonController _controller;

  @override
  void initState() {
    super.initState();
    _controller = FavoriteButtonController(widget.id);
    _controller.initialize();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      width: 40,
      child: RxBuilder(
        builder: (_) {
          const errorWidget = Icon(CustomIconData.error);

          switch (_controller.state) {
            case States.error:
              return errorWidget;
            default:
              return _controller.favorite.fold(
                (failure) => errorWidget,
                (isFavorite) {
                  return IconButton(
                    onPressed: () {
                      isFavorite
                          ? _controller.onHandleRemoveFavorite()
                          : _controller.onHandleAddFavorite();
                    },
                    icon: Icon(
                      isFavorite
                          ? CustomIconData.favoriteOn
                          : CustomIconData.favoriteOff,
                    ),
                  );
                },
              );
          }
        },
      ),
    );
  }
}
