import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:vocabular/app/models/box.dart';
import 'package:vocabular/app/models/langs.dart';
import 'package:vocabular/app/models/vocab.dart';
import 'package:vocabular/app/widgets/insert_dialog/dialog_controller.dart';

class VocabDialog extends StatefulWidget {
  final Vocab vocab;
  final bool hasFormen;
  final bool loadFromStorage;
  final String lang;

  VocabDialog({
    this.vocab,
    this.loadFromStorage = true,
    this.hasFormen,
    this.lang = 'English',
  });

  @override
  _VocabDialogState createState() => _VocabDialogState();
}

class _VocabDialogState extends ModularState<VocabDialog, DialogController> {
  final TextEditingController _textField = TextEditingController();

  final TextEditingController _textFieldTranslation = TextEditingController();

  final TextEditingController _textFieldForms = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final formFocus = FocusNode();

  Vocab vocab;

  @override
  void initState() {
    controller.lang = widget.lang;
    controller.loadStorage = widget.loadFromStorage;
    if (widget.vocab != null) {
      loadVocab(widget.vocab);
    }
    super.initState();
  }

  @override
  void dispose() {
    formFocus.dispose();
    super.dispose();
  }

  void loadVocab(Vocab v) {
    _textField.text = v.main;
    _textFieldTranslation.text = v.other;
    _textFieldForms.text = v.forms ?? '';
    vocab = v;
  }

  void submit() {
    if (_formKey.currentState.validate()) {
      Navigator.of(context).pop(Vocab(
        id: vocab?.id,
        main: _textField.text,
        other: _textFieldTranslation.text,
        forms: widget.hasFormen ? _textFieldForms.text : null,
      ));
    }
  }

  void delete() {
    if (widget.vocab != null) {
      Navigator.of(context).pop(Vocab(
        id: -1,
      ));
    } else {
      _textField.text = '';
      _textFieldTranslation.text = '';
      _textFieldForms.text = '';
    }
  }

  void suggestionSelected(SuggestionEntry s) {
    loadVocab(s.vocab);
    FocusScope.of(context).nextFocus();
  }

  String get languageName =>
      getLanguageByIsoCode(controller.lang, germanLanguagesList).name;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.all(32.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      title: Stack(
        children: <Widget>[
          Text(widget.vocab != null
              ? 'Vokabel bearbeiten'
              : 'Vokabel hinzufügen'),
          if (widget.vocab != null)
            Positioned(
              right: -16,
              top: -14,
              child: IconButton(
                color: Colors.red,
                icon: Icon(Icons.delete_forever),
                onPressed: delete,
              ),
            ),
        ],
      ),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TypeAheadFormField<SuggestionEntry>(
                textFieldConfiguration: TextFieldConfiguration(
                  autofocus: true,
                  controller: _textFieldTranslation,
                  decoration: InputDecoration(labelText: languageName),
                  textInputAction: TextInputAction.next,
                  onSubmitted: (_) => FocusScope.of(context).nextFocus(),
                ),
                suggestionsCallback: controller.getSuggestions,
                hideOnEmpty: true,
                hideOnError: true,
                itemBuilder: (context, suggestion) {
                  return ListTile(
                    leading: Icon(suggestion.isThirdParty
                        ? Icons.language
                        : Icons.storage),
                    title: Text(
                      suggestion.vocab.other + ' - ' + suggestion.vocab.main,
                    ),
                    subtitle: widget.hasFormen
                        ? Text(suggestion.vocab?.forms ?? '')
                        : null,
                  );
                },
                onSuggestionSelected: suggestionSelected,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Bitte gebe die Vokabel für $languageName ein';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _textField,
                decoration: InputDecoration(labelText: "Deutsch"),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) =>
                    widget.hasFormen ? formFocus.requestFocus() : submit(),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Bitte gebe die Vokabel ein';
                  }
                  return null;
                },
              ),
              if (widget.hasFormen)
                TextFormField(
                  focusNode: formFocus,
                  controller: _textFieldForms,
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) => submit(),
                  decoration: InputDecoration(labelText: "Formen"),
                ),
            ],
          ),
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text('Abbrechen'),
          onPressed: () => Navigator.of(context).pop(null),
        ),
        RaisedButton(
          color: Colors.indigo,
          child: Text('Weiter'),
          onPressed: submit,
        )
      ],
    );
  }
}
