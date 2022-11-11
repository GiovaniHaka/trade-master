import 'package:flutter/material.dart';

class SliverListSeparated extends StatelessWidget {
  final Widget? Function(BuildContext, int) itemBuilder;
  final Widget separator;
  final int itemCount;

  const SliverListSeparated({
    Key? key,
    required this.itemBuilder,
    required this.separator,
    required this.itemCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (_, index) {
          final int itemIndex = index ~/ 2;
          if (!index.isEven) {
            return separator;
          }
          return itemBuilder.call(_, itemIndex);
        },
        semanticIndexCallback: (widget, index) {
          if (index.isEven) return index ~/ 2;
          return null;
        },
        childCount: itemCount * 2 - 1,
      ),
    );
  }
}
