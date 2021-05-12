import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
//import 'package:cached_network_image/cached_network_image.dart';
//import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:pet_matcher/locator.dart';
import 'package:pet_matcher/models/animal.dart';
//import 'package:pet_matcher/models/animal_category_constants.dart';
import 'package:pet_matcher/models/animal_filter.dart';
import 'package:pet_matcher/screens/animal_detail_screen.dart';
import 'package:pet_matcher/screens/choose_animal_type_screen.dart';
import 'package:pet_matcher/services/animal_service.dart';
import 'package:pet_matcher/widgets/admin_drawer.dart';
import 'package:pet_matcher/widgets/animal_filter_button.dart';
import 'package:pet_matcher/widgets/animal_search_button.dart';
import 'package:pet_matcher/widgets/user_drawer.dart';
import 'package:provider/provider.dart';

class AnimalInventoryScreen extends StatelessWidget {
  static const routeName = 'animalInventoryScreen';
  const AnimalInventoryScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String userType = ModalRoute.of(context).settings.arguments;
    return ChangeNotifierProvider(
      create: (context) => AnimalFilter(),
      child: Scaffold(
        appBar: inventoryAppBar(context, userType),
        drawer: getDrawerType(userType),
        backgroundColor: Colors.blue[200],
        body: Column(
          children: [
            animalList(context, userType),
          ],
        ),
      ),
    );
  }

  //function returning user or admin drawer
  Widget getDrawerType(userType) {
    if (userType == 'admin') {
      return AdminDrawer();
    } else {
      return UserDrawer();
    }
  }

  Widget inventoryAppBar(BuildContext context, String userType) {
    String appBarTitle = 'Search Animals';
    if (userType == 'admin') {
      appBarTitle = 'Animal Inventory';
    }

    return AppBar(
      centerTitle: false,
      title: Text(
        appBarTitle,
        textAlign: TextAlign.start,
      ),
      backgroundColor: Colors.blue[300],
      actions: addAppbarActions(context, userType),
    );
  }
}

List<Widget> addAppbarActions(BuildContext context, String userType) {
  if (userType == 'admin') {
    return [
      AnimalSearchButton(),
      AnimalFilterButton(),
      animalAddButton(context),
    ];
  } else {
    return [AnimalSearchButton(), AnimalFilterButton()];
  }
}

Widget animalAddButton(BuildContext context) {
  return IconButton(
      icon: Icon(Icons.add),
      tooltip: 'Add an animal',
      onPressed: () {
        Navigator.of(context)
            .pushReplacementNamed(ChooseAnimalTypeScreen.routeName);
      });
}

Widget animalList(BuildContext context, String userType) {
  // List<Animal> allAnimals = Provider.of<List<Animal>>(context);
  return Consumer<AnimalFilter>(
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
            return inventoryListTile(context, animal, userType);
          },
        ),
      );
    },
  );
}

Widget inventoryListTile(BuildContext context, Animal animal, String userType) {
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
            height: 200,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: CircleAvatar(
                    radius: 100.0,
                    backgroundColor: Colors.transparent,
                    backgroundImage: NetworkImage(animal.imageURL),
                  ),
                  //child: CachedNetworkImage(
                  //imageUrl: animal.imageURL,
                  //),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          '${animal.name}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                          ),
                        ),
                        Text(
                          'Breed: ${animal.breed}',
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          'Age: ${animal.age}',
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 20,
                          ),
                        ),
                        SizedBox(height: 10),
                        animalInventoryLayout(userType, animal),
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

Widget animalInventoryLayout(String userType, Animal animal) {
  if (userType == 'admin') {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        editIcon(animal),
        deleteIcon(animal),
      ],
    );
  } else {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [favoriteIcon(animal)]);
  }
}

Widget favoriteIcon(Animal animal) {
  return IconButton(
    icon: Icon(Icons.favorite_border_outlined),
    tooltip: 'Save animal',
    onPressed: () {
      //NOTE: Still need to allow for selecting favorites
      //and adding to favorite screen if we want to do that
    },
  );
}

Widget editIcon(Animal animal) {
  return IconButton(
      icon: Icon(Icons.edit), tooltip: 'Edit animal', onPressed: () {});
}

Widget deleteIcon(Animal animal) {
  return IconButton(
      icon: Icon(Icons.delete), tooltip: 'Remove animal', onPressed: () {});
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
