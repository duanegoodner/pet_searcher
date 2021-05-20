import 'package:cached_network_image/cached_network_image.dart';
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
import 'package:pet_matcher/widgets/delete_dialog.dart';
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
        child: Padding(
          padding: const EdgeInsets.only(left: 5, right: 5),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 250,
                childAspectRatio: 2.1 / 3,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5),
            itemCount: animals.length,
            itemBuilder: (context, index) {
              Animal animal = animals[index];
              return inventoryListTile(context, animal, userType);
            },
          ),
        ),
      );
    },
  );
}

Widget inventoryListTile(BuildContext context, Animal animal, String userType) {
  return GestureDetector(
    onTap: () {
      Navigator.of(context)
          .pushNamed(AnimalDetailScreen.routename, arguments: animal);
    },
    child: Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      clipBehavior: Clip.hardEdge,
      child: Padding(
        padding: EdgeInsets.only(bottom: 7),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            animalPhotoTile(userType, animal, context),
            animalInfoText(animal),
          ],
        ),
      ),
    ),
  );
}

Widget animalPhotoTile(String userType, Animal animal, BuildContext context) {
  return Stack(
    alignment: AlignmentDirectional.center,
    children: [
      AspectRatio(
        aspectRatio: 1.1,
        child: ClipRRect(
          clipBehavior: Clip.hardEdge,
          // borderRadius: BorderRadius.circular(10.0),
          child: CachedNetworkImage(
            imageUrl: animal.imageURL,
            // width: 180,
            // height: 150,
            fit: BoxFit.cover,
          ),
        ),
      ),
      animalInventoryLayout(userType, animal, context),
    ],
  );
}

Widget animalInfoText(Animal animal) {
  return Padding(
    padding: const EdgeInsets.only(top: 10, bottom: 5, left: 5, right: 5),
    child: Align(
      alignment: Alignment.bottomLeft,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
              fontSize: 14,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            'Age: ${animal.age}',
            style: TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 14,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            'Arrived: ${animal.formattedDateAdded}',
            style: TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 13,
            ),
          ),
        ],
      ),
    ),
  );
}

Widget animalInventoryLayout(
    String userType, Animal animal, BuildContext context) {
  if (userType == 'admin') {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          editIcon(animal, context),
          deleteIcon(animal, context),
        ],
      ),
    );
  } else {
    return Positioned(
      bottom: 0,
      right: 0,
      child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [favoriteIcon(animal)]),
    );
  }
}

Widget favoriteIcon(Animal animal) {
  return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButton(
          icon: Icon(Icons.favorite, color: Colors.white),
          tooltip: 'Save animal',
          onPressed: () {
            //NOTE: Still need to allow for selecting favorites
            //and adding to favorite screen if we want to do that
          },
        ),
      ]);
}

Widget editIcon(Animal animal, BuildContext context) {
  return IconButton(
      icon: Icon(
        Icons.edit_outlined,
        color: Colors.white,
        size: 30,
      ),
      tooltip: 'Edit animal',
      onPressed: () {
        Navigator.of(context)
            .pushNamed(AddPetScreen.routeName, arguments: animal);
      });
}

Widget deleteIcon(Animal animal, BuildContext context) {
  return IconButton(
      icon: Icon(
        Icons.delete_outlined,
        color: Colors.red[400],
        size: 30,
      ),
      tooltip: 'Remove animal',
      onPressed: () {
        showMyDialog('animals', animal, context);
      });
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
