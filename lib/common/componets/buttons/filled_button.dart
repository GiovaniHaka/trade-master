import 'package:flutter/material.dart';
import 'package:ricky_and_morty/common/componets/progress_indicators/custom_circular_progress.dart';

import 'package:ricky_and_morty/common/constants/ui/custom_colors.dart';
import 'package:ricky_and_morty/common/constants/ui/custom_text_style.dart';
import 'package:ricky_and_morty/common/constants/ui/padding_constants.dart';
import 'package:ricky_and_morty/common/constants/ui/radius_constants.dart';

class FilledButton extends StatelessWidget {
  final Function()? onTap;
  final Color backgroundColor;
  final Color foregroundColor;
  final String text;
  final bool isLoading;

  const FilledButton({
    Key? key,
    required this.onTap,
    required this.backgroundColor,
    required this.foregroundColor,
    required this.text,
    required this.isLoading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ElevatedButton(
        onPressed: onTap,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.disabled)) {
                return CustomColors.greyMedium;
              }
              return backgroundColor;
            },
          ),
          elevation: MaterialStateProperty.resolveWith<double?>(
            (Set<MaterialState> states) {
              return 0;
            },
          ),
          padding: MaterialStateProperty.all<EdgeInsets>(
            const EdgeInsets.all(defaultPadding),
          ),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(defaultRadius),
            ),
          ),
          foregroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              return foregroundColor;
            },
          ),
          textStyle: MaterialStateProperty.resolveWith<TextStyle?>(
            (Set<MaterialState> states) {
              return CustomTextStyle.button(context);
            },
          ),
        ),
        child: isLoading
            ? const SizedBox(
                height: 25,
                width: 25,
                child: CustomCircularProgress(),
              )
            : Text(text),
      ),
    );
  }

  const FilledButton.primary({
    Key? key,
    required this.text,
    required this.onTap,
    this.backgroundColor = Colors.black,
    this.foregroundColor = Colors.white,
    this.isLoading = false,
  }) : super(key: key);

  const FilledButton.secondary({
    Key? key,
    required this.text,
    required this.onTap,
    this.backgroundColor = CustomColors.greyMedium,
    this.foregroundColor = CustomColors.greyDark,
    this.isLoading = false,
  }) : super(key: key);
}
