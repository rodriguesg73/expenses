// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, prefer_const_literals_to_create_immutables, unused_field, unnecessary_null_comparison, cast_from_null_always_fails

import 'package:expenses/components/adaptative_components/adaptative_button.dart';
import 'package:expenses/components/adaptative_components/adaptative_text_field.dart';
import 'package:expenses/components/adaptative_components/adaptative_date_picker.dart';
import 'package:flutter/material.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, double, DateTime) onSubmit;

  TransactionForm(this.onSubmit, {super.key});

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _titleController = TextEditingController();

  final _valueController = TextEditingController();

  DateTime _selectedDate = DateTime.now();

  _onSubmitForm() {
    final title = _titleController.text;
    final value = double.tryParse(_valueController.text) ?? 0;

    if (title.isEmpty || value <= 0) {
      return;
    }
    widget.onSubmit(title, value, _selectedDate);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom + 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            AdaptativeTextField(
              label: 'Titulo',
              controller: _titleController,
              keyboardType: TextInputType.text,
              onSubmitted: (_) => _onSubmitForm(),
            ),
            AdaptativeTextField(
              label: 'Valor (R\$)',
              controller: _valueController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              onSubmitted: (_) => _onSubmitForm(),
            ),
            AdaptativeDatePicker(
                selectedDate: _selectedDate,
                onDateChanged: (newDate) {
                  setState(() {
                    _selectedDate = newDate;
                  });
                }),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [AdaptativeButton('Nova Transação', _onSubmitForm)],
            ),
          ],
        ),
      ),
    );
  }
}
