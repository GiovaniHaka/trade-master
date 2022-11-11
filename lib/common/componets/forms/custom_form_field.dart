// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:ricky_and_morty/common/constants/ui/custom_colors.dart';
import 'package:ricky_and_morty/common/constants/ui/custom_text_style.dart';
import 'package:ricky_and_morty/common/constants/ui/margin_constants.dart';
import 'package:ricky_and_morty/common/constants/ui/padding_constants.dart';

class CustomFormField extends StatefulWidget {
  final String? Function(String?)? validator;
  final Function(String?)? onChanged;
  final String? hintText;
  final String? labelText;
  final String? helperText;
  final String initialValue;
  final TextInputType keyboardType;
  final TextCapitalization textCapitalization;

  const CustomFormField({
    Key? key,
    this.initialValue = '',
    this.keyboardType = TextInputType.text,
    this.textCapitalization = TextCapitalization.none,
    this.validator,
    this.onChanged,
    this.hintText,
    this.labelText,
    this.helperText,
  }) : super(key: key);

  @override
  _CustomFormFieldState createState() => _CustomFormFieldState();
}

class _CustomFormFieldState extends State<CustomFormField> {
  bool isPassVisible = false;
  double underlineWidth = 2;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: defaultMargin),
      child: TextFormField(
        initialValue: widget.initialValue,
        textInputAction: TextInputAction.done,
        onChanged: widget.onChanged,
        style: CustomTextStyle.titleSmall(context).copyWith(height: 1.5),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(vertical: defaultPadding),
          helperText: widget.helperText,
          helperStyle: CustomTextStyle.titleSmall(context),
          hintText: widget.hintText,
          errorStyle: CustomTextStyle.titleSmall(context).copyWith(
            color: Colors.red,
          ),
          hintStyle: CustomTextStyle.titleSmall(context).copyWith(
            color: Colors.grey,
          ),
          labelText: widget.labelText,
          labelStyle: CustomTextStyle.titleSmall(context).copyWith(
            color: Colors.grey,
          ),
          filled: false,
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: CustomColors.greyMedium,
              width: underlineWidth,
            ),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: CustomColors.greyDark,
              width: underlineWidth,
            ),
          ),
          errorBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.red,
              width: underlineWidth,
            ),
          ),
          disabledBorder: InputBorder.none,
          errorMaxLines: 3,
          alignLabelWithHint: false,
          floatingLabelBehavior: FloatingLabelBehavior.always,
        ),
        validator: widget.validator,
        keyboardType: TextInputType.name,
        textAlignVertical: TextAlignVertical.center,
        textCapitalization: widget.textCapitalization,
      ),
    );
  }
}
