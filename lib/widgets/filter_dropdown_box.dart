import 'package:flutter/material.dart';

import '../styles.dart';

Widget filterDropDownBox({
  String labelText,
  EdgeInsets addPadding = const EdgeInsets.all(3),
  String value,
  List<String> items,
  Function onChanged,
  GlobalKey<FormFieldState> key,
  // String disabledHint,
}) {
  return Container(
    height: 60,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(40.0),
    ),
    child: Padding(
      padding: EdgeInsets.only(left: 15, right: 5),
      child: DropdownButtonFormField<String>(
        key: key,
        decoration: InputDecoration(
          border: InputBorder.none,
          labelText: labelText,
          labelStyle: Styles.dropdownText,
        ),
        value: value,
        items: items.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              style: Styles.dropdownText,
            ),
          );
        }).toList(),
        onChanged: onChanged,
        // disabledHint: Text(
        //   disabledHint ?? '',
        //   textAlign: TextAlign.end,
        //   style: TextStyle(fontSize: 15),
        // ),
      ),
    ),
  );
}

void doNothing(String value) {}
