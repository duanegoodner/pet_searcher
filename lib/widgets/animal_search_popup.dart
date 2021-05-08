import 'package:flutter/material.dart';
import 'package:pet_matcher/widgets/animal_search_form.dart';

class AnimalSearchButton extends StatefulWidget {
  AnimalSearchButton({Key key}) : super(key: key);

  @override
  _AnimalSearchButtonState createState() => _AnimalSearchButtonState();
}

class _AnimalSearchButtonState extends State<AnimalSearchButton> {
  Future<void> showInformationDialog(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AnimalSearchForm();
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.search),
        tooltip: 'Search',
        onPressed: () async {
          await showInformationDialog(context);
        });
  }
}
