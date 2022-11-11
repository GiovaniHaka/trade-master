import 'package:flutter/material.dart';

import 'package:ricky_and_morty/apps/characters/domain/models/character_filters.dart';
import 'package:ricky_and_morty/common/componets/buttons/filled_button.dart';
import 'package:ricky_and_morty/common/componets/forms/custom_form_field.dart';
import 'package:ricky_and_morty/common/componets/forms/unfocuser.dart';
import 'package:ricky_and_morty/common/componets/separators/vertical_separator.dart';
import 'package:ricky_and_morty/common/constants/ui/custom_text_style.dart';
import 'package:ricky_and_morty/common/constants/ui/padding_constants.dart';

class FiltersForm extends StatefulWidget {
  final CharacterFilters initialFilters;
  final ValueChanged<CharacterFilters> onConfirm;

  const FiltersForm({
    Key? key,
    required this.initialFilters,
    required this.onConfirm,
  }) : super(key: key);

  @override
  State<FiltersForm> createState() => _FiltersFormState();
}

class _FiltersFormState extends State<FiltersForm> {
  String? name;
  String? species;

  @override
  void initState() {
    super.initState();
    name = widget.initialFilters.name;
    species = widget.initialFilters.species;
  }

  @override
  Widget build(BuildContext context) {
    return Unfocuser(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(viewPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Filtrar',
                  style: CustomTextStyle.headlineSmall(context),
                ),
                const CloseButton(),
              ],
            ),
            const VerticalSeparator.large(),
            CustomFormField(
              labelText: 'Nome (opcional)',
              hintText: 'Preencha o nome do personagem',
              initialValue: name ?? '',
              onChanged: (val) {
                setState(() {
                  name = val;
                });
              },
            ),
            const VerticalSeparator.large(),
            CustomFormField(
              labelText: 'Espécie (opcional)',
              hintText: 'Preencha o a espécie do personagem',
              initialValue: species ?? '',
              onChanged: (val) {
                setState(() {
                  species = val;
                });
              },
            ),
            const VerticalSeparator.large(),
            FilledButton.primary(
              text: 'Buscar',
              onTap: () {
                final filters = CharacterFilters();

                if (name != null) {
                  filters.name = name!.isEmpty ? null : name;
                }

                if (species != null) {
                  filters.species = species!.isEmpty ? null : species;
                }

                widget.onConfirm(filters);
              },
            ),
          ],
        ),
      ),
    );
  }
}
