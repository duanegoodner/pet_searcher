import 'package:flutter/material.dart';

Widget filterDropDownBox({
  String labelText,
  EdgeInsets addPadding = const EdgeInsets.all(3),
  String value,
  List<String> items,
  Function onChanged,
  GlobalKey<FormFieldState> key,
  // String disabledHint,
}) {
  return Padding(
    padding: addPadding,
    child: Container(
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: new BorderRadius.circular(40.0),
      ),
      child: Padding(
        padding: EdgeInsets.only(left: 10, right: 10),
        child: DropdownButtonFormField<String>(
          key: key,
          decoration: InputDecoration(
            border: InputBorder.none,
            labelText: labelText,
            labelStyle: TextStyle(
              fontSize: 13,
            ),
          ),
          value: value,
          items: items.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                style: TextStyle(fontSize: 13),
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
    ),
  );
}

void doNothing(String value) {}
