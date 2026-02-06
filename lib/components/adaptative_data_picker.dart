import 'package:expenses_app/components/adaptative_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:io';

class AdaptativeDataPicker extends StatelessWidget {
  final DateTime selectedDate;
  final Function(DateTime) onDateChanged;

  const AdaptativeDataPicker({
    required this.selectedDate,
    required this.onDateChanged,
  });

  _showDatePicker(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2015),
      lastDate: DateTime(3000),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      onDateChanged(pickedDate);
    });
  }

  @override
  Widget build(BuildContext context) {
    //print("build() AdaptativeDataPicker");
    return Platform.isIOS
        ? CupertinoDatePicker(
          mode: CupertinoDatePickerMode.date,
          initialDateTime: DateTime.now(),
          minimumDate: DateTime(2019),
          maximumDate: DateTime(2030),
          onDateTimeChanged: onDateChanged,
        )
        : Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    DateFormat("dd/MM/y").format(selectedDate),
                  ),
                ),
                AdaptativeButton(
                  label: "Selecionar data",
                  onPressed: () => _showDatePicker(context),
                ),
              ],
            ),
          );
  }
}
