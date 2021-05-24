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
