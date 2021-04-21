import 'package:flutter/material.dart';

Widget standardDropdownBox({
  @required Function validatorCondition,
  @required Function onSaved,
  String labelText,
  String validatorPrompt,
  EdgeInsets addPadding = const EdgeInsets.all(10),
  String chosenResponse,
  List<String> items,
}) {
  return Padding(
    padding: addPadding,
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: new BorderRadius.circular(40.0),
      ),
      child: Padding(
        padding: EdgeInsets.only(left: 15, right: 15, top: 5),
        child: DropdownButtonFormField<String>(
            decoration:
                InputDecoration(border: InputBorder.none, labelText: labelText),
            value: chosenResponse,
            items: items.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (value) {},
            onSaved: onSaved,
            validator: (value) {
              if (validatorCondition(value)) {
                return validatorPrompt;
              } else {
                return null; //validation passed
              }
            }),
      ),
    ),
  );
}
