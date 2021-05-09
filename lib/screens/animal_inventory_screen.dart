import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:pet_matcher/locator.dart';
import 'package:pet_matcher/models/animal.dart';
import 'package:pet_matcher/models/inventory_filter.dart';
import 'package:pet_matcher/screens/animal_detail_screen.dart';
import 'package:pet_matcher/services/animal_service.dart';
import 'package:pet_matcher/widgets/admin_drawer.dart';
import 'package:pet_matcher/widgets/animal_search_popup.dart';
import 'package:provider/provider.dart';

class AnimalInventoryScreen extends StatelessWidget {
  static const routeName = 'animalInventoryScreen';
  const AnimalInventoryScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => InventoryFilter(),
      child: Scaffold(
        appBar: inventoryAppBar(),
        drawer: AdminDrawer(),
        backgroundColor: Colors.blue[200],
        body: Column(
          children: [
            animalList(context),
          ],
        ),
      ),
    );
  }

  Widget inventoryAppBar() {
    return AppBar(
      centerTitle: false,
      title: Text(
        'Animal Inventory',
        textAlign: TextAlign.start,
      ),
      backgroundColor: Colors.blue[300],
      actions: [
        AnimalSearchButton(),
        IconButton(
          icon: Icon(Icons.sort),
          tooltip: 'Sort',
          onPressed: () {},
        ),
        IconButton(
            icon: Icon(Icons.edit),
            tooltip: 'Add or remove animals',
            onPressed: () {})
      ],
    );
  }
}

Widget animalList(BuildContext context) {
  return Consumer<InventoryFilter>(
    builder: (context, filter, __) {
      List<Animal> animals = locator<AnimalService>().filterAnimalList(
        filter.searchCriteria,
        Provider.of<List<Animal>>(context),
      );
      return Expanded(
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: animals.length,
          itemBuilder: (context, index) {
            Animal animal = animals[index];
            return inventoryListTile(context, animal);
          },
        ),
      );
    },
  );
}

Widget inventoryListTile(BuildContext context, Animal animal) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => AnimalDetailScreen(animal: animal)),
      );
    },
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Card(
        child: Padding(
          padding: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
          child: SizedBox(
            height: 150,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: CachedNetworkImage(
                    imageUrl: animal.imageURL,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${animal.name}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          'Breed: ${animal.breed}',
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 15,
                          ),
                        ),
                        Text(
                          'Age: ${animal.age}',
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

Widget noAnimalsFoundTile() {
  return GestureDetector(
    onTap: () {},
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Card(
        child: Padding(
          padding: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
          child: SizedBox(
            height: 150,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      'Sorry. No animals found.',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
