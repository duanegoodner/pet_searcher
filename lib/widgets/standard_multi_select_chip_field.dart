import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

Widget standardMultiSelectChipField({
  List<String> options,
  Function onTap,
  Function validatorCondition,
  String validatorPrompt,
}) {
  return MultiSelectChipField(
    decoration: BoxDecoration(border: Border.all(color: Colors.transparent)),
    showHeader: false,
    scroll: false,
    chipColor: Colors.grey[100],
    textStyle: TextStyle(color: Colors.grey[600], fontSize: 13),
    selectedChipColor: Colors.blue[800],
    selectedTextStyle: TextStyle(
        color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
    items: options.map((key) => MultiSelectItem(key, key)).toList(),
    onTap: onTap,
    validator: (values) {
      if (validatorCondition(values)) {
        return validatorPrompt;
      } else {
        return null; //validation passed
      }
    },
  );
}
