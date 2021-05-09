import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pet_matcher/models/animal_filter.dart';
import 'package:pet_matcher/widgets/animal_search_form.dart';

class AnimalSearchButton extends StatefulWidget {
  AnimalSearchButton({Key key}) : super(key: key);

  @override
  _AnimalSearchButtonState createState() => _AnimalSearchButtonState();
}

class _AnimalSearchButtonState extends State<AnimalSearchButton> {
  Future<void> showInformationDialog(BuildContext context) async {
    AnimalFilter animalFilter =
        Provider.of<AnimalFilter>(context, listen: false);

    return await showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            Widget searchForm = AnimalSearchForm();
            return ChangeNotifierProvider<AnimalFilter>.value(
              value: animalFilter,
              child: searchForm,
            );
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
