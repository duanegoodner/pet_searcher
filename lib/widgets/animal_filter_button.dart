import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pet_matcher/models/animal.dart';
import 'package:pet_matcher/models/animal_filter.dart';

class AnimalFilterButton extends StatelessWidget {
  const AnimalFilterButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AnimalFilter animalFilter =
        Provider.of<AnimalFilter>(context, listen: false);

    return ChangeNotifierProvider.value(
      value: animalFilter,
      child: PopupMenuButton(
        child: Icon(Icons.sort),
        itemBuilder: (context) => List.generate(
          Animal.sortOptions.length,
          (index) => PopupMenuItem(
            value: Animal.sortOptions[index].keys.toList()[0],
            child: Text('${Animal.sortOptions[index].values.toList()[0]}'),
          ),
        ),
        onSelected: (String value) {
          Provider.of<List<Animal>>(context, listen: false)
              .sort((a, b) => a.toJson()[value].compareTo(b.toJson()[value]));
          Provider.of<AnimalFilter>(context, listen: false)
              .updateSortCriteria(value);
        },
      ),
    );
  }
}
