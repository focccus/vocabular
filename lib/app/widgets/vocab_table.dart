import 'package:flutter/material.dart';
import 'package:vocabular/app/models/vocab.dart';

class VocabTable extends StatelessWidget {
  final List<Vocab> vocabs;
  final List<Vocab> selected;
  final void Function(Vocab) onSelected;
  final bool showForms;
  final String lang;

  VocabTable(
    this.vocabs, {
    this.onSelected,
    this.showForms = false,
    this.lang = 'English',
    this.selected,
  });

  @override
  Widget build(BuildContext context) {
    return DataTable(
      showCheckboxColumn: selected != null,
      columns: [
        DataColumn(label: Text(lang)),
        if (showForms) DataColumn(label: Text('Formen')),
        DataColumn(label: Text('Deutsch')),
      ],
      rows: vocabs
          .map(
            (vocab) => DataRow(
              cells: [
                DataCell(Text(vocab.other)),
                if (showForms) DataCell(Text(vocab.forms ?? '')),
                DataCell(Text(vocab.main)),
              ],
              onSelectChanged: (_) =>
                  onSelected != null ? onSelected(vocab) : null,
              selected: selected?.contains(vocab) ?? false,
            ),
          )
          .toList(),
    );
  }
}
