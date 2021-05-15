import 'package:flutter/material.dart';
import 'package:pet_matcher/widgets/standard_multi_select_chip_field.dart';

Widget standardDispositionField({
  String headerTitle,
  List<String> options,
  Function onTap,
  Function validatorCondition,
  String validatorPrompt,
  double extraPadding = 0,
}) {
  return addPadding(
    amount: extraPadding,
    child: DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: Colors.white,
        ),
      ),
      child: Column(
        children: [
          dispositionHeader(headerTitle: headerTitle),
          dispositionMultiSelect(
              options: options,
              onTap: onTap,
              validatorCondition: validatorCondition,
              validatorPrompt: validatorPrompt),
        ],
      ),
    ),
  );
}

Widget dispositionHeader({String headerTitle}) {
  return Padding(
    padding: EdgeInsets.only(top: 10),
    child: Text(
      headerTitle,
      style: TextStyle(
        color: Colors.white,
        fontSize: 24,
      ),
    ),
  );
}

Widget dispositionMultiSelect({
  List<String> options,
  Function onTap,
  Function validatorCondition,
  String validatorPrompt,
}) {
  return standardMultiSelectChipField(
    options: options,
    onTap: onTap,
    validatorCondition: validatorCondition,
    validatorPrompt: validatorPrompt,
  );
}

Widget addPadding({Widget child, double amount}) {
  return Padding(
    padding: EdgeInsets.all(amount),
    child: child,
  );
}
