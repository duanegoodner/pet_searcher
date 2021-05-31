import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

import '../styles.dart';

Widget standardMultiSelectChipField({
  List<String> options,
  Function onTap,
  Function validatorCondition,
  String validatorPrompt,
  List<dynamic> initialValues,
}) {
  return MultiSelectChipField(
    decoration: BoxDecoration(border: Border.all(color: Colors.transparent)),
    showHeader: false,
    scroll: false,
    chipColor: Colors.grey[100],
    textStyle: Styles.multiSelectChipText,
    selectedChipColor: Colors.blue[800],
    selectedTextStyle: Styles.multiSelectChipSelectedText,
    items: options.map((key) => MultiSelectItem(key, key)).toList(),
    initialValue: initialValues,
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

Widget standardMultiSelectDialog({
  List<String> options,
  Function validatorCondition,
  String validatorPrompt,
  Function onConfirm,
}) {
  return MultiSelectDialogField(
      items: options.map((option) => MultiSelectItem(option, option)).toList(),
      onConfirm: onConfirm,
      validator: (values) {
        if (validatorCondition(values)) {
          return validatorPrompt;
        } else {
          return null; //validation passed
        }
      });
}
