import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pet_matcher/models/animal.dart';
import 'package:pet_matcher/models/animal_filter.dart';
import 'package:pet_matcher/models/app_user.dart';
import 'package:pet_matcher/screens/add_pet_screen.dart';
import 'package:pet_matcher/screens/animal_detail_screen.dart';
import 'package:pet_matcher/screens/choose_animal_type_screen.dart';
import 'package:pet_matcher/widgets/admin_drawer.dart';
import 'package:pet_matcher/widgets/animal_search_button.dart';
import 'package:pet_matcher/widgets/animal_sort_button.dart';
import 'package:pet_matcher/widgets/user_drawer.dart';
import 'package:provider/provider.dart';

class AnimalInventoryScreen extends StatelessWidget {
  static const routeName = 'animalInventoryScreen';
  const AnimalInventoryScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String userType = Provider.of<AppUser>(context).role;
    return ChangeNotifierProxyProvider<List<Animal>, AnimalFilter>(
      create: (_) => AnimalFilter(),
      update: (_, animals, filter) => filter..updateIncomingList(animals),
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
      AnimalSortButton(),
      animalAddButton(context),
    ];
  } else {
    return [AnimalSearchButton(), AnimalSortButton()];
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
      List<Animal> animals = filter?.outputList;

      if (animals == null) {
        return Expanded(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      }
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
      Navigator.of(context).pushNamed(AnimalDetailScreen.routename, arguments: animal);
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
                  child: ClipOval(
                    child: CachedNetworkImage(
                      imageUrl: animal.imageURL,
                      width: 100,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
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
                        Text(
                          '\nDate Added:\n${animal.formattedDateAdded}',
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 13,
                          ),
                        ),
                        animalInventoryLayout(userType, animal, context),
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

Widget animalInventoryLayout(
    String userType, Animal animal, BuildContext context) {
  if (userType == 'admin') {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        editIcon(animal, context),
        deleteIcon(animal, context),
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

Widget editIcon(Animal animal, BuildContext context) {
  return IconButton(
      icon: Icon(Icons.edit),
      tooltip: 'Edit animal',
      onPressed: () {
        Navigator.of(context)
            .pushNamed(AddPetScreen.routeName, arguments: animal);
      });
}

Widget deleteIcon(Animal animal, BuildContext context) {
  return IconButton(
      icon: Icon(Icons.delete),
      tooltip: 'Remove animal',
      onPressed: () {
        _showMyDialog(animal, context);
      });
}

//Reference: https://api.flutter.dev/flutter/material/AlertDialog-class.html
Future<void> _showMyDialog(Animal animal, BuildContext context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Delete this animal?'),
        content: SingleChildScrollView(
          child: ListBody(
            children: [
              Text(
                  'Would you like to permanently remove this animal from the animal inventory?'),
            ],
          ),
        ),
        actions: [
          TextButton(
            child: Text('No'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text('Yes'),
            onPressed: () {
              FirebaseFirestore.instance
                  .collection('animals')
                  .doc(animal.animalID)
                  .delete();
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
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
